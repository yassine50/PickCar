import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pickcar/DataClass/car.dart';
import 'package:pickcar/DataClass/customer.dart';
import 'package:pickcar/DataClass/rent.dart';
import 'package:pickcar/DataClass/renter.dart';
import 'package:pickcar/Tools/ApiMethode.dart';
import 'package:pickcar/hive/LocalStorage.dart';

part 'mesvoiture_event.dart';
part 'mesvoiture_state.dart';

class MesvoitureBloc extends Bloc<MesvoitureEvent, MesvoitureState> {
  MesvoitureBloc() : super(MesvoitureInitial()) {
    on<MesvoitureEvent>((event, emit) {
      // TODO: implement event handler
    });
      on<getCars>(loadCars) ;
  }

  Future<FutureOr<void>> loadCars(getCars event, Emitter<MesvoitureState> emit) async {
    // sleep(Duration(seconds: 5));
     var user = await LocalStorage.GetUser();
   //  if(user["currentMode"] == Constants.ModeLocataire) {
          var customer = await LocalStorage.GetCustomer();
     final response = await ApiMethode.RequestMethode(
       endPoint: "http://10.0.2.2:8080/rent/filter",
       body: {},
       jwt: user['jwt-token'],
       para: "page=0&sortBy=id&sortDirection=ASC",
       type: "GET",
     );

     if (response != "" ) {
       List<Rent> rent = [] ; 
       Map<String,dynamic> responseConverted =  json.decode(response)   ;
       print(responseConverted);
       for(int i = 0 ; i< responseConverted["content"].length ; i++ ) {
          Rent rents = Rent.fromJson(  responseConverted["content"][i]);
           final getcar = await ApiMethode.RequestMethode(
       endPoint: "http://10.0.2.2:8080/cars/get/"+responseConverted["content"][i]['carIdentifier'],
       body: {},
       //jwt: user['jwt-token'],
       para: "",
       type: "GET",
     );
     if(getcar != "") {
      Map<String,dynamic> responseConvertedCar =  json.decode(getcar)   ;
      Car car = Car.fromJson(responseConvertedCar);
      rents.rentDemand!.car = car ;  
     }
      final getCustomer = await ApiMethode.RequestMethode(
       endPoint: "http://10.0.2.2:8080/customers/details/"+responseConverted["content"][i]['rentDemand']['customerId'],
       body: {},
       jwt: user['jwt-token'],
       para: "",
       type: "GET",
     );
     if(getCustomer != "") {
      Map<String,dynamic> responseConvertedCustomer =  json.decode(getCustomer)   ;
      Customer customer = Customer.fromJson(responseConvertedCustomer);
      rents.rentDemand!.customer = customer ; 
     }else {
      print ("not working") ;
     }
      final getRenter = await ApiMethode.RequestMethode(
       endPoint: "http://10.0.2.2:8080/renters/details/"+responseConverted["content"][i]['rentDemand']['renterIdentifier'],
       body: {},
       jwt: user['jwt-token'],
       para: "",
       type: "GET",
     );
     if(getRenter != "") {
      Map<String,dynamic> responseConvertedRenter =  json.decode(getRenter)   ;
      Renter renter = Renter.fromJson(responseConvertedRenter);
      rents.rentDemand!.car!.renter = renter.user ;
     }else {
      print ("not working") ;
     }
       rent.add(rents);
       }
     
       print(rent);
  
   emit(DataLoaded(rent));
     } else {

     }
    // }else {
 //emit(DataLoaded([]));



   //  }
  }
}
