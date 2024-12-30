import 'package:flutter/material.dart';

class Backbutton extends StatelessWidget {
    final VoidCallback ontap;
  const Backbutton({super.key, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
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
                Icons.arrow_back,
                size: 18,
                color: Colors.white,
              ),
            ),
    );
  }
}