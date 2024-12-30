import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:pickcar/DataClass/user.dart';
import 'package:pickcar/Tools/ApiMethode.dart';
import 'package:pickcar/view/CreatePass/CreatePass.dart';

part 'verif_phone_event.dart';
part 'verif_phone_state.dart';

class VerifPhoneBloc extends Bloc<VerifPhoneEvent, VerifPhoneState> {
  VerifPhoneBloc() : super(VerifPhoneInitial()) {
    on<VerifPhoneEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<VerifPhone>(verif);
  }

  Future<User> verif(VerifPhone event, Emitter<VerifPhoneState> emit) async {
    final response = await ApiMethode.RequestMethode(
      endPoint: "http://10.0.2.2:8080/verification/verify/phone",
      body: {},
       para: "phoneNumber=%2B216${event.user.phone}&code=${event.code}",
      type: "GET",
    );

    if (response != "") {
      Map<String, dynamic> userMap = json.decode(response);
      event.user.verificationID = userMap["verificationSID"];
      if(event.fromProfile) {
        Navigator.pop(event.context);  
      }else{
         Navigator.push(
        event.context,
        MaterialPageRoute(
            builder: (context) => CreatePass(
                  user: event.user,
                )),
      );
      }
    
    } else {}
    return User();
  }
}
