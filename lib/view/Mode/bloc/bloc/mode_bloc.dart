import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:pickcar/DataClass/customer.dart';
import 'package:pickcar/DataClass/renter.dart';
import 'package:pickcar/DataClass/user.dart';
import 'package:pickcar/Tools/ApiMethode.dart';
import 'package:pickcar/Tools/Constants.dart';
import 'package:pickcar/hive/LocalStorage.dart';
import 'package:pickcar/view/widgets/GoogleNavBar/Navbar.dart';
import 'package:pickcar/view/widgets/popups/Allpop.dart';

part 'mode_event.dart';
part 'mode_state.dart';

class ModeBloc extends Bloc<ModeEvent, ModeState> {
  ModeBloc() : super(ModeInitial()) {
    on<ModeEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<ModeFunction>(Modefun);
  }

  Future<FutureOr<void>> Modefun(ModeFunction event, Emitter<ModeState> emit) async {
   Allpups.loading(event.context);
    final response = await ApiMethode.RequestMethode(
      endPoint: "http://10.0.2.2:8080/users/mode",
      body: {},
      jwt:event.user.jwtToken!,
      para: "newMode=${event.newMode}",
      type: "PUT",
    );

    if (response != "") {
      BuildContext con = event.context ; 
      event.user.currentMode = event.newMode ;
       LocalStorage.SaveUser(event.user);
      Map<String, dynamic> userMap =  json.decode(response);
      if(event.user.currentMode == Constants.ModeLocataire){
         Customer cus = Customer.fromJson(userMap);
      LocalStorage.SaveCustomer(cus);
      print("this is the customer id " +cus.customerIdentifier.toString() ) ; 

 final responseStat = await ApiMethode.RequestMethode(
      endPoint: "http://10.0.2.2:8080/rent/summary/customer",
      body: {},
      jwt:event.user.jwtToken!,
      para: "customerId=${cus.customerIdentifier}",
      type: "GET",
    );
    if(responseStat != '' ) {
        Map<String, dynamic> userStat =  json.decode(responseStat);
        
      event.user.totlaPrice = userStat['totalPrice'];
      event.user.rentCount = userStat['rentCount'];
    }
    Navigator.pop(event.context) ;

      Navigator.push(
    con,
    MaterialPageRoute(builder: (con) => GoogleNavBar( user: event .user,)),
  );
      }else{
        print(event.user.currentMode);
        User use = User.fromJson(userMap);
        use.jwtToken = event.user.jwtToken; 
          Renter renter = Renter.fromJson(userMap);
      LocalStorage.SaveRenter(renter);

      final responseStat = await ApiMethode.RequestMethode(
      endPoint: "http://10.0.2.2:8080/rent/summary/renter",
      body: {},
      jwt:event.user.jwtToken!,
      para: "renterId=${event.user.renterIdentifier}",
      type: "GET",
    );
    if(responseStat != '' ) {
        Map<String, dynamic> userStat =  json.decode(responseStat);
        
    use.totlaPrice = userStat['totalPrice'];
    use.rentCount = userStat['rentCount'];
    }
        Navigator.pop(event.context) ;
      Navigator.push(
    con,
    MaterialPageRoute(builder: (con) => GoogleNavBar( user: use,)),
  );
      }
      
     
      
        
    } else {}
  }
}
