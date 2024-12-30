import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pickcar/view/widgets/text/text.dart';

class SelectDate extends StatelessWidget {
  final DateTime? date  ; 
  const SelectDate({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      decoration: BoxDecoration(
        color: Colors.white,
          border: Border.all(color: Color(0xFF2576B9)),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        Icon(Icons.calendar_month_outlined, color:Color(0xFF2576B9) ,),
        AllText.text(fontsize: 14, color: Colors.grey, FontWeight: FontWeight.w400, text: date == null ? "Quand?" : DateFormat('dd/MM/yyyy').format(date!))
      ],)
    );
  }
}