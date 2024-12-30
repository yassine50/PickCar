import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'createpass_event.dart';
part 'createpass_state.dart';

class CreatepassBloc extends Bloc<CreatepassEvent, CreatepassState> {
  CreatepassBloc() : super(CreatepassInitial(0, Colors.white)) {
    on<CreatepassEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<CalculeStrength>(calculeStrength);
  }

  FutureOr<void> calculeStrength(
      CalculeStrength event, Emitter<CreatepassState> emit) {
        if(event.pass.isEmpty) {
           emit(CreatepassInitial( 0.1, Color( 0xFFF44336))) ; 
        }else {
           if (validatePassword(event.pass)) {
       emit(CreatepassInitial( 1.0, Color(0xFF4CAF50))) ;    // Strong password
    } else {
      // Check which criteria are not met and return the corresponding strength
      if (event.pass.length >= 8) {
         emit(CreatepassInitial( 0.6, Color(0xFFFFEB3B))) ; 
        // At least eight characters but missing other criteria
      } else {
         emit(CreatepassInitial( 0.3, Color( 0xFFF44336))) ; 
       // Not enough characters
      }
    }
        }
   
  }

  bool validatePassword(String password) {
    if (password.length < 8) {
      return false;
    }

    // Initialize flags to track whether each criteria is met
    bool hasUpperCase = false;
    bool hasLowerCase = false;
    bool hasDigit = false;
    bool hasSpecialChar = false;

    // Check each character in the password
    for (int i = 0; i < password.length; i++) {
      if (password[i].toUpperCase() != password[i]) {
        hasLowerCase = true;
      }
      if (password[i].toLowerCase() != password[i]) {
        hasUpperCase = true;
      }
      if (password.codeUnitAt(i) >= 48 && password.codeUnitAt(i) <= 57) {
        hasDigit = true;
      }
      // Special characters are ASCII codes between 32 and 47, 58 and 64,
      // 91 and 96, and 123 and 126.
      if ((password.codeUnitAt(i) >= 32 && password.codeUnitAt(i) <= 47) ||
          (password.codeUnitAt(i) >= 58 && password.codeUnitAt(i) <= 64) ||
          (password.codeUnitAt(i) >= 91 && password.codeUnitAt(i) <= 96) ||
          (password.codeUnitAt(i) >= 123 && password.codeUnitAt(i) <= 126)) {
        hasSpecialChar = true;
      }
    }

    // Check if all criteria are met
    return hasUpperCase && hasLowerCase && hasDigit && hasSpecialChar;
  }
}
