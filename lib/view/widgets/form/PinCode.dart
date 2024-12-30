import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCode extends StatefulWidget {
  final TextEditingController code ; 
  const PinCode({super.key, required this.code});

  @override
  State<PinCode> createState() => _PinCodeState();
}

class _PinCodeState extends State<PinCode> {
  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      controller: widget.code ,
            appContext: context,
            length: 6,
            obscureText: true,
            obscuringCharacter: '*',
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(10),
              fieldHeight: 50,
              fieldWidth: 48,
              activeFillColor: Colors.white,
              selectedFillColor: Colors.white,
              inactiveFillColor: Colors.white,
              activeColor: Colors.blue,
              selectedColor: Colors.blue,
              inactiveColor: Colors.grey.withOpacity(0.3),
            ),
            animationDuration: Duration(milliseconds: 300),
            backgroundColor: Colors.transparent,
            enableActiveFill: true,
            onCompleted: (v) {
              print("Completed: $v");
            },
            onChanged: (value) {
              print(value);
            },
            beforeTextPaste: (text) {
              print("Allowing to paste $text");
              // If you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
              // But you can show anything you want here, like your pop up saying wrong paste format or etc
              return true;
            },
          
        
      );
  }
}