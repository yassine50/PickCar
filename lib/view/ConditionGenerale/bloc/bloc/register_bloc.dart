import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:pickcar/DataClass/user.dart';
import 'package:pickcar/Tools/ApiMethode.dart';
import 'package:pickcar/view/Login/Login.dart';
import 'package:pickcar/view/Mode/mode.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<Register>(register);
  }

  Future<FutureOr<void>> register(
      Register event, Emitter<RegisterState> emit) async {
        print("this is the phone " +event.user.phone.toString() ); 
        print("this is the firstname " +event.user.firstName.toString() ); 
        print("this is the lastName " +event.user.lastName.toString() ); 
        print("this is the city " +event.user.address!.city.toString() ); 
        print("this is the country " +event.user.address!.country.toString() ); 
        print("this is the zipCode " +event.user.address!.zipCode.toString() ); 
        print("this is the street " +event.user.address!.street.toString() ); 
        print("this is the email " +event.user.email.toString() ); 
        print("this is the nationality " +event.user.nationality.toString() ); 
        print("this is the password " +event.user.password.toString() ); 
        print("this is the dateOfBirth " +DateFormat('yyyy-MM-dd').format(event.user.dateOfBirth!)); 
       

            final response = await ApiMethode.RequestMethode(
      endPoint: "http://10.0.2.2:8080/users/register",
      body: {
  "phone": event.user.phone,  
  "firstName": event.user.firstName,
  "lastName": event.user.lastName,
  "birthDate": DateFormat('yyyy-MM-dd').format(event.user.dateOfBirth!) ,
  "address": {
    "city": event.user.address!.city,
    "country": event.user.address!.country,
    "zipCode": event.user.address!.zipCode,
    "street":event.user.address!.street,
  },
  "email": event.user.email,
  "nationality":event.user.nationality,
  "password": event.user.password,
},
      type: "POST",
    );

    if (response != "") {
      Navigator.pushReplacement(
        event.context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    } else {}
    // save user to the cache
  }
}
