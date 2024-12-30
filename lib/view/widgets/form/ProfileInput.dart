import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pickcar/view/widgets/text/text.dart';

class ProfileInput extends StatelessWidget {
  final bool readOnly ; 
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final String title ; 
  const ProfileInput(
      {super.key,
      required this.controller,
      required this.hint,
      required this.icon, required this.title, required this.readOnly});

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        Container(
          alignment: Alignment.topLeft,
          child: AllText.text(fontsize: 14, color: Colors.black, FontWeight: FontWeight.w400, text: title),) , 
  SizedBox(height: 4,),
        Container(

          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(8))

          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextFormField(
                  readOnly: readOnly ,
                  onChanged: (value) {},
                  cursorColor: Colors.black,
                  controller: controller,
                  style: GoogleFonts.firaSans(
                    fontSize: 14,
                    color: Color(0xFF829AB1),
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    hintText: hint,
                    hintStyle: GoogleFonts.firaSans(
                      fontSize: 14,
                      color: Color(0xFF829AB1),
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusColor: Colors.black,
                  ),
                ),
              ),
              Icon(icon),
              SizedBox(width: 8,)
            ],
          ),
        ),
      ],
    );
  }
}
