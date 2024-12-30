import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pickcar/DataClass/car.dart';
import 'package:pickcar/DataClass/rentdemand.dart';
import 'package:pickcar/DataClass/user.dart';
import 'package:pickcar/Tools/ApiMethode.dart';
import 'package:pickcar/hive/LocalStorage.dart';

part 'mes_voiture_event.dart';
part 'mes_voiture_state.dart';

class MesVoitureBloc extends Bloc<MesVoitureEvent, MesVoitureState> {
  MesVoitureBloc() : super(MesVoitureInitial()) {
    on<MesVoitureEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<getCars>(loadCars) ;
  }

  Future<FutureOr<void>> loadCars(getCars event, Emitter<MesVoitureState> emit) async {
   //  if(user["currentMode"] == Constants.ModeLocataire) {
          var customer = await LocalStorage.GetCustomer();
     final response = await ApiMethode.RequestMethode(
       endPoint: "http://10.0.2.2:8080/cars/renter/"+event.user.renterIdentifier!,
       body: {},
       jwt: event.user.jwtToken!,
      // para: "page=0&sortBy=id&sortDirection=ASC",
       type: "GET",
     );

     if (response != "" ) {
       List<Car> cars = [] ; 
       //Map<String,dynamic> responseConverted =  json.decode(response)   ;
       //print(responseConverted);
       List <dynamic> responseConverted = json.decode(response) ;
       for(int i = 0 ; i<  responseConverted.length ; i++ ) {
          Car car = Car.fromJson(  responseConverted[i]);
         
       cars.add(car);
       }
     
       
   print(cars);
   emit(DataLoaded(cars));
     } else {

     }
  }
}
