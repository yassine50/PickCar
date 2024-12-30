import 'package:flutter/material.dart';
import 'package:pickcar/view/widgets/text/text.dart';

class ContactAdmin extends StatelessWidget {
  const ContactAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 12),
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xFF2576B9)),
          borderRadius: BorderRadius.all(Radius.circular(5))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Icon(Icons.email_outlined, color: Color(0xFF0062A2),),
               SizedBox(width: 8,),
           AllText.text(fontsize: 14, color: Color(0xFF0062A2), FontWeight: FontWeight.w400, text: "Contacter  administrateur"),

        ],),
      );
  }
}