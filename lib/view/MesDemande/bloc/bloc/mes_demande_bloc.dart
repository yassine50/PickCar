import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pickcar/DataClass/car.dart';
import 'package:pickcar/DataClass/customer.dart';
import 'package:pickcar/DataClass/rentdemand.dart';
import 'package:pickcar/Tools/ApiMethode.dart';
import 'package:pickcar/Tools/Constants.dart';
import 'package:pickcar/hive/LocalStorage.dart';

part 'mes_demande_event.dart';
part 'mes_demande_state.dart';

class MesDemandeBloc extends Bloc<MesDemandeEvent, MesDemandeState> {
  MesDemandeBloc() : super(MesDemandeInitial()) {
    on<MesDemandeEvent>((event, emit) {
      // TODO: implement event handler
    });
       on<getCars>(loadCars) ;
  }

  Future<FutureOr<void>> loadCars(getCars event, Emitter<MesDemandeState> emit) async {
    var user = await LocalStorage.GetUser();
   //  if(user["currentMode"] == Constants.ModeLocataire) {
          var customer = await LocalStorage.GetCustomer();
     final response = await ApiMethode.RequestMethode(
       endPoint: "http://10.0.2.2:8080/api/rentdemands/filter",
       body: {},
       jwt: user['jwt-token'],
       para: "page=0&sortBy=id&sortDirection=ASC",
       type: "GET",
     );

     if (response != "" ) {
       List<RentDemand> rentDemand = [] ; 
       Map<String,dynamic> responseConverted =  json.decode(response)   ;
       print(responseConverted);
       for(int i = 0 ; i< responseConverted["content"].length ; i++ ) {
          RentDemand rent = RentDemand.fromJson(  responseConverted["content"][i]);

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
      rent.car = car ;  
     }
     final getCustomer = await ApiMethode.RequestMethode(
       endPoint: "http://10.0.2.2:8080/customers/details/"+responseConverted["content"][i]['customerId'],
       body: {},
       jwt: user['jwt-token'],
       para: "",
       type: "GET",
     );
     if(getCustomer != "") {
      Map<String,dynamic> responseConvertedCustomer =  json.decode(getCustomer)   ;
      Customer customer = Customer.fromJson(responseConvertedCustomer);
      rent.customer = customer ;  
     }
       rentDemand.add(rent);
       }
     
       print(rentDemand);
  
   emit(DataLoaded(rentDemand));
     } else {

     }
    // }else {
 //emit(DataLoaded([]));



   //  }

 
  
  }
}
