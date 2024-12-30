import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pickcar/DataClass/address.dart';
import 'package:pickcar/Tools/ApiMethode.dart';

part 'filter_bloc_event.dart';
part 'filter_bloc_state.dart';

class FilterBlocBloc extends Bloc<FilterBlocEvent, FilterBlocState> {
  FilterBlocBloc() : super(FilterBlocInitial()) {
    on<FilterBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
 on<getAdress>(loadAdress) ;
  }

  Future<FutureOr<void>> loadAdress(getAdress event, Emitter<FilterBlocState> emit) async {
      List<Address> suggestions = [];
    
      suggestions = [];
                    final response = await ApiMethode.RequestMethode(
                      endPoint: "https://us1.locationiq.com/v1/search",
                      body: {},
                      para: "key=pk.ff45627f7bc7ffb352163e73ee94c19f&q=" +
                          event.adress +
                          "&format=json&",
                      type: "GET",
                    );

                    if (response != "") {
                      suggestions = [];
                   //   print(response);
                      List userMap = json.decode(response);
                      for (int i = 0; i < userMap.length; i++) {
                        Address address = Address();
                        address.country = userMap[i]["display_name"];
                        address.lat = double.parse(userMap[i]["lat"]);
                        address.lon = double.parse(userMap[i]["lon"]);
                        print(address.lon) ; 
                        suggestions.add(address);
                      }
                      emit(DataLoaded(suggestions)); 
                  
                     
                    }
  }
}
