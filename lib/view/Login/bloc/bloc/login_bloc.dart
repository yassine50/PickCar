import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:pickcar/DataClass/user.dart';
import 'package:pickcar/Tools/ApiMethode.dart';
import 'package:pickcar/hive/LocalStorage.dart';
import 'package:pickcar/view/Mode/mode.dart';
import 'package:pickcar/view/widgets/popups/Allpop.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {
      // TODO: implement event handler
    });
     on<LoginEvents>(LoginUser);
  }

  Future<User> LoginUser(LoginEvents event, Emitter<LoginState> emit) async {
   Allpups.loading(event.context);
    final response = await ApiMethode.RequestBodyWithHeader(
      endPoint: "http://10.0.2.2:8080/users/login",
      body: {
        "email": event.email,
        "password": event.pass,
      },
      type: "POST",
    );
   
    if (response != "") {
      Map<String, dynamic> userMap =  json.decode(response["body"]);
     
      User user = User.fromJson(userMap);
      user.jwtToken = response["header"]["jwt-token"];
      LocalStorage.SaveUser(user);
      Navigator.pop(event.context);
       Navigator.pushReplacement(
    event.context,
    MaterialPageRoute(builder: (context) =>Mode(user: user,)),
  );
      return user ; 
    } else {
            Navigator.pop(event.context);
            Allpups.warningPopup(event.context, "Email ou mot de passe incorrecte"); 

  
    }
return User() ; 
  }
}
