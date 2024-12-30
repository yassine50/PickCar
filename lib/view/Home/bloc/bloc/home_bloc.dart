import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:pickcar/DataClass/car.dart';
import 'package:pickcar/Tools/ApiMethode.dart';
import 'package:pickcar/view/widgets/Filtre/Marque/Marque.dart';
import 'package:pickcar/view/widgets/Filtre/Price/Price.dart';
import 'package:pickcar/view/widgets/Filtre/TypeCar/TypeCar.dart';
import 'package:pickcar/view/widgets/Filtre/flitre.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  
    HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {
      // TODO: implement event handler
     
    });
     on<getCars>(loadCars) ;
  }

  Future<FutureOr<void>> loadCars(getCars event, Emitter<HomeState> emit) async {
    if(FiltreState.StartDate != null &&  FiltreState.DueDate != null &&  FiltreState.StartTime !=null && FiltreState.DueTime != null  ) {

           DateTime combinedDateTimeStart = DateTime(
  FiltreState.StartDate!.year,
    FiltreState.StartDate!.month,
    FiltreState.StartDate!.day,
    FiltreState.StartTime!.hour,
    FiltreState.StartTime!.minute,
    53
  );
  DateTime combinedDateTimeEnd = DateTime(
  FiltreState.DueDate!.year,
    FiltreState.DueDate!.month,
    FiltreState.DueDate!.day,
    FiltreState.DueTime!.hour,
    FiltreState.DueTime!.minute,
    17
  );
   final response = await ApiMethode.RequestMethode(
      endPoint: "http://10.0.2.2:8080/cars/filter",
      body: {},
      para:
      
      "search="+FiltreState.search.text+
      "&startDate="+DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(combinedDateTimeStart) +
      "&endDate="+DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(combinedDateTimeEnd)+
      "&city="+
      "&brand="+  (MarqueState.selectedBrand.isEmpty ? "":MarqueState.selectedBrand.first )+
      "&type="+(TypeCarState.selectedType.isEmpty ? "":TypeCarState.selectedType.first )+
     // "&minPrice="+PriceState.currentRangeValues.start.toString()+
     // "&maxPrice="+PriceState.currentRangeValues.end.toString()+
      "&gearType="+
     "&engine="+
      "&page="+
     "&size="+
      "&sortBy="+
     "&sortDirection=", 
      // "startDate=${FiltreState.StartDate}&",
    type: "GET",
   );

    if (response != "") {
       List<Car> cars = [] ; 

       Map<String, dynamic> userMap =  json.decode(response);
List <dynamic> responseConverted = userMap['content'];
print(response);
       for(int i = 0 ; i<  responseConverted.length ; i++ ) {
          Car car = Car.fromJson(  responseConverted[i]);
          if(car.status == "Créé" && car.status == "UPDATED" && car.status == "FREE") {
                   cars.add(car);
          }
       }
        emit(DataLoaded(cars)); 
   

    } else {}
    }else {
       final response = await ApiMethode.RequestMethode(
      endPoint: "http://10.0.2.2:8080/cars/filter",
      body: {},
      para:
      
      "search="+FiltreState.search.text+
      "&city="+
      "&brand="+  (MarqueState.selectedBrand.isEmpty ? "":MarqueState.selectedBrand.first )+
      "&type="+(TypeCarState.selectedType.isEmpty ? "":TypeCarState.selectedType.first )+
     // "&minPrice="+(PriceState.currentRangeValues.start == 0 ?"" :  PriceState.currentRangeValues.start.toString())+
      //"&maxPrice="+(PriceState.currentRangeValues.end == 0 ?"" :  PriceState.currentRangeValues.end.toString())+
      "&gearType="+
     "&engine="+
      "&page="+
     "&size="+
      "&sortBy="+
     "&sortDirection=", 
      // "startDate=${FiltreState.StartDate}&",
    type: "GET",
   );

    if (response != "") {
       List<Car> cars = [] ; 

       Map<String, dynamic> userMap =  json.decode(response);
List <dynamic> responseConverted = userMap['content'];
print(response);
       for(int i = 0 ; i<  responseConverted.length ; i++ ) {
          Car car = Car.fromJson(  responseConverted[i]);
          if(car.status == "Créé" && car.status == "UPDATED" && car.status == "FREE") {
                   cars.add(car);
          }
       }
        emit(DataLoaded(cars)); 
   

    } else {}
    }

   
  }
}
