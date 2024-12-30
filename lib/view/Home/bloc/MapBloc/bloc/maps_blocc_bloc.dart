import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pickcar/DataClass/address.dart';
import 'package:pickcar/DataClass/car.dart';
import 'package:pickcar/DataClass/renter.dart';
import 'package:pickcar/DataClass/user.dart';
import 'package:pickcar/Tools/ApiMethode.dart';
import 'package:pickcar/view/widgets/Filtre/Marque/Marque.dart';
import 'package:pickcar/view/widgets/Filtre/Moteur/Moteur.dart';
import 'package:pickcar/view/widgets/Filtre/TypeCar/TypeCar.dart';

part 'maps_blocc_event.dart';
part 'maps_blocc_state.dart';

class MapsBloccBloc extends Bloc<MapsBloccEvent, MapsBloccState> {
  MapsBloccBloc() : super(MapsBloccInitial()) {
    on<MapsBloccEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<getCars>(loadCars);
  }

  Future<FutureOr<void>> loadCars(
      getCars event, Emitter<MapsBloccState> emit) async {
    List<Car> cars = [];
    final response = await ApiMethode.RequestMethode(
      endPoint: "http://10.0.2.2:8080/cars/filter",
      body: {

      },
      para: "minPrice=0&longitude= " +
          event.adress.lon.toString() +
          "&latitude=" +
          event.adress.lat.toString() +
          "&page=0&size=10&sortBy=category&sortDirection=ASC",
      type: "GET",
    );

    if (response != "") {
      print('this is the  ' + response);
      cars = [];

      Map<String, dynamic> userMap = json.decode(response);
      List<dynamic> responseConverted = userMap['content'];

      for (int i = 0; i < responseConverted.length; i++) {
       // Car caru = Car() ; 
        Car car = Car.fromJson(responseConverted[i]);
        if (car.status == "CREATED" || car.status == "FREE" || car.status =="UPDATED") {
          final getcar = await ApiMethode.RequestMethode(
            endPoint: "http://10.0.2.2:8080/cars/get/" +
                responseConverted[i]['carIdentifier'],
            body: {

            },
            //jwt: user['jwt-token'],
            para: "",
            type: "GET",
          );
          if (getcar != "") {

            Map<String, dynamic> responseConvertedCar = json.decode(getcar);
            car =  Car.fromJson(responseConvertedCar);
            final getRenter = await ApiMethode.RequestMethode(
              endPoint: "http://10.0.2.2:8080/renters/details/" +
                  responseConvertedCar
                      ['renterIdentifier'],
              body: {},
              jwt: event.user.jwtToken!,
              para: "",
              type: "GET",
            );
            if (getRenter != "") {
              Map<String, dynamic> responseConvertedRenter =
                  json.decode(getRenter);
              Renter renter = Renter.fromJson(responseConvertedRenter);
              car.renter = renter.user;
            } else {
              print("not working");
            }
          }
         //  cars.add(car);
           // Filter conditions for selected brand, engine, and other criteria
        bool matchesBrand = MarqueState.selectedBrand.isEmpty || MarqueState.selectedBrand.contains(car.brand);
        bool matchesMotor = MoteurState.selectedMoteur.isEmpty || MoteurState.selectedMoteur.contains(car.motor);
        bool matchesType = TypeCarState.selectedType.isEmpty || TypeCarState.selectedType.contains(car.category);
       // bool matchesGearbox = BoiteVitesseState.selectedGearbox.isEmpty || BoiteVitesseState.selectedGearbox.contains(car.gearbox);

        // If the car matches all selected filters (or if filters are not selected), add it to the list
        if (matchesBrand && matchesMotor && matchesType ) {
          if (i > 0) {
  // Slightly adjust lat and lon based on the index to avoid stacking
  car.lat = car.lat! - (i * 0.0091); // Small increment for latitude
  car.lon = car.lon! - (i * 0.0091); // Small increment for longitude
}
          cars.add(car);
        }
        
        }
      }
      print(cars);
    } else {}
    emit(Carsloaded(cars));
  }
}









//  static  LoadData () async {
//       final response = await ApiMethode.RequestMethode(
//                           endPoint: "http://10.0.2.2:8080/cars/filter",
//                           body: {},
//                           para: "minPrice=0&longitude=11.1097173&latitude=33.5036797&radius=999999999999&page=0&size=10&sortBy=category&sortDirection=ASC",
//                           type: "GET",
//                         );

//                         if (response != "") {
//                           cars = [];

//                           Map<String, dynamic> userMap = json.decode(response);
//                           List<dynamic> responseConverted = userMap['content'];
//                           print(response);
//                           for (int i = 0; i < responseConverted.length; i++) {
//                             Car car = Car.fromJson(responseConverted[i]);
//                             if (car.status == "CREATED") {
//                               cars.add(car);
//                             }
//                           }
//                           setState(() {
//                             cars = cars;
//                           });
//                           print(cars);
//                         } else {}
//   }
