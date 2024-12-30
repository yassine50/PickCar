import 'package:flutter/material.dart';
import 'package:pickcar/Tools/Constants.dart';

class DropDownSginUp extends StatefulWidget {
  final List<String> list ; 
   static String? pays ; 
   DropDownSginUp({super.key, required this.list ,  });
  @override
  State<DropDownSginUp> createState() => _DropDownSginUpState();
}

class _DropDownSginUpState extends State<DropDownSginUp> {
  String? dropdownValue ;
  @override
  void initState() {
    // TODO: implement initState
     dropdownValue = widget.list.first;
    super.initState();
  }
  bool isFocused = false;


  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          isFocused = hasFocus;
        });
      },
      child: Container(
        height: 48,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
      
     
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: dropdownValue,
            icon: Icon(Icons.arrow_drop_down, color:isFocused ? Theme.of(context).primaryColor : Theme.of(context).shadowColor,),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.black, fontSize: 16),
            onChanged: (String? newValue) {
              setState(() {
                if (newValue != null) {
                  DropDownSginUp.pays = newValue;
                  dropdownValue = newValue;
                }
              });
            },
            items: widget.list
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}