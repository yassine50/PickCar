import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';


class AllBottomSheet {
 static  void FunBottomSheet (BuildContext context, Widget widget ) {
    showCupertinoModalBottomSheet(
      // transitionBackgroundColor: Color(0xFF6E9A10), 
  context: context,
  builder: (context) => 
  Container(
    padding: EdgeInsets.symmetric(horizontal: 24),
    color: Colors.white,
    height:MediaQuery.of(context).size.height*0.6,
    child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Container(
            margin: EdgeInsets.only(top: 12),
            height: 5,
            width: 80,
            decoration: BoxDecoration(
              color: Color(0xFFCDCFD0),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
          widget
        ],),
      ),
    ),
    ),
);
  }
}