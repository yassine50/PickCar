import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:pickcar/view/Home/Home.dart';
import 'package:pickcar/view/Home/bloc/bloc/home_bloc.dart';
import 'package:pickcar/view/widgets/Filtre/flitre.dart';
import 'package:pickcar/view/widgets/button/AuthButtns.dart';
import 'package:pickcar/view/widgets/text/text.dart';

class SelectDateBottomSheet extends StatefulWidget {
  SelectDateBottomSheet({super.key});

  @override
  State<SelectDateBottomSheet> createState() => _SelectDateBottomSheetState();
}

class _SelectDateBottomSheetState extends State<SelectDateBottomSheet> {
   Future<void> _selectDate(BuildContext context , String type ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (picked != null ) {
      setState(() {
        if(type == "StartDate") {
  FiltreState.StartDate = picked;
        }else if(type == "DueDate") {
          FiltreState.DueDate = picked;
        }
      
      });
    }
  }



    Future<void> _selectTime(BuildContext context,String type) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime:  TimeOfDay.now(),
    );
    if (picked != null) {
     
              setState(() {
        if(type == "StartTime") {
  FiltreState.StartTime = picked;
        }else if(type == "DueTime") {
          FiltreState.DueTime = picked;
        }
      
      });
     
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.calendar_month,
              color: Color(0xFF270093),
            ),
            SizedBox(
              width: 8,
            ),
            AllText.text(
                fontsize: 16,
                color: Colors.black,
                FontWeight: FontWeight.w700,
                text: "Date")
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AllText.text(
                    fontsize: 16,
                    color: Colors.black,
                    FontWeight: FontWeight.w400,
                    text: "Début"),
                SizedBox(
                  height: 4,
                ),
                GestureDetector(
                  onTap: (){
                    _selectDate(context,"StartDate") ; 
                  },
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.42,
                    padding: EdgeInsets.only(top: 12, bottom: 12, left: 12),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Container(
                                alignment: Alignment.topLeft,
                                child: AllText.text(
                                    fontsize: 14,
                                    color: Colors.grey,
                                    FontWeight: FontWeight.w400,
                                    text:FiltreState.StartDate == null ?"":
                                     DateFormat('yyyy/MM/dd')
                                        .format(FiltreState.StartDate!)
                                        .toString()))),
                        Icon(Icons.calendar_month),
                        SizedBox(
                          width: 8,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AllText.text(
                    fontsize: 16,
                    color: Colors.black,
                    FontWeight: FontWeight.w400,
                    text: "Fin"),
                SizedBox(
                  height: 4,
                ),
                GestureDetector(
                   onTap: (){
                    _selectDate(context,"DueDate") ; 
                  },
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.42,
                    padding: EdgeInsets.only(top: 12, bottom: 12, left: 12),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Container(
                                alignment: Alignment.topLeft,
                                child: AllText.text(
                                    fontsize: 14,
                                    color: Colors.grey,
                                    FontWeight: FontWeight.w400,
                                    text:FiltreState.DueDate == null ? "" : 
                                    DateFormat('yyyy/MM/dd')
                                        .format(FiltreState.DueDate!)
                                        .toString()))),
                        Icon(Icons.calendar_month),
                        SizedBox(
                          width: 8,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Icon(
              Icons.access_time,
              color: Color(0xFF270093),
            ),
            SizedBox(
              width: 8,
            ),
            AllText.text(
                fontsize: 16,
                color: Colors.black,
                FontWeight: FontWeight.w700,
                text: "Date")
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AllText.text(
                    fontsize: 16,
                    color: Colors.black,
                    FontWeight: FontWeight.w400,
                    text: "Début"),
                SizedBox(
                  height: 4,
                ),
                GestureDetector(
                   onTap: (){
                    _selectTime(context,"StartTime") ; 
                  },
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.42,
                    padding: EdgeInsets.only(top: 12, bottom: 12, left: 12),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Container(
                                alignment: Alignment.topLeft,
                                child: AllText.text(
                                    fontsize: 14,
                                    color: Colors.grey,
                                    FontWeight: FontWeight.w400,
                                    text: FiltreState.StartTime == null ?"": FiltreState.StartTime!.format(context)))),
                        Icon(Icons.access_time),
                        SizedBox(
                          width: 8,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AllText.text(
                    fontsize: 16,
                    color: Colors.black,
                    FontWeight: FontWeight.w400,
                    text: "Fin"),
                SizedBox(
                  height: 4,
                ),
                 GestureDetector(
                   onTap: (){
                    _selectTime(context,"DueTime") ; 
                  },
                  child: Container(
                     width: MediaQuery.sizeOf(context).width * 0.42,
                    padding: EdgeInsets.only(top: 12, bottom: 12, left: 12),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Container(
                                alignment: Alignment.topLeft,
                                child: AllText.text(
                                    fontsize: 14,
                                    color: Colors.grey,
                                    FontWeight: FontWeight.w400,
                                    text: FiltreState.DueTime == null ?"": FiltreState.DueTime!.format(context)))),
                        Icon(Icons.access_time),
                        SizedBox(
                          width: 8,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        SizedBox(
          height: 8,
        ),
        AuthButtons(
          onTap: () {
            Home.HomeController.add(getCars());
             Navigator.pop(context) ; 
            
          },
          text: "Confirmer",
          width: double.infinity,
          outlinedButton: false,
          firstColor: Color(0xFF2576B9),
          secondColor: Color(0xFF592FAA),
          radius: 8,
        )
      ],
    );
  }
}
