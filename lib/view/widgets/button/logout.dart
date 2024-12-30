import 'package:flutter/material.dart';
import 'package:pickcar/view/Login/Login.dart';

class Logout extends StatelessWidget {
  const Logout({super.key});

  @override
  Widget build(BuildContext context) {
    return
     GestureDetector(
      onTap: () {
         Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) =>Login()),
  );
      },
       child: Container(
              height: 32,
              width: 32,
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
              child: const Icon(
                Icons.logout_outlined,
                size: 18,
                color: Colors.white,
              ),
            ),
     );
  }
}