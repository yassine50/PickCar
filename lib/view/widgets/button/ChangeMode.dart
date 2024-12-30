import 'package:flutter/material.dart';
import 'package:pickcar/DataClass/user.dart';
import 'package:pickcar/view/Mode/mode.dart';
import 'package:pickcar/view/widgets/text/text.dart';

class ChangeMode extends StatelessWidget {
  final User user ; 
  const ChangeMode({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return 
    GestureDetector(
      onTap: () {
         Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) =>Mode(user:user ,)),
  );
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 8),
              height: 32,
            
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF2576B9),
                      Color(0xFF592FAA),
                    ],
                  )
                  //  color: Color(0xFF2576B9),
                  ),
              child: AllText.text(fontsize: 10, color: Colors.white, FontWeight: FontWeight.w700, text: "Changer mode")
            ),
    );
  }
}