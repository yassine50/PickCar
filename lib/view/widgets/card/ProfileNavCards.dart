import 'package:flutter/material.dart';
import 'package:pickcar/view/widgets/text/text.dart';

class ProfileNavCards extends StatelessWidget {
  final String hint ;  
  final VoidCallback onTap;
  const ProfileNavCards({super.key, required this.hint, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap ,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 12),
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xFF2576B9)),
          borderRadius: BorderRadius.all(Radius.circular(5))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           AllText.text(fontsize: 14, color: Color(0xFF0062A2), FontWeight: FontWeight.w400, text: hint),
            Icon(Icons.arrow_forward_rounded, color: Color(0xFF0062A2),)
        ],),
      ),
    );
  }
}