import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class PhoneInput extends StatefulWidget {
  final TextEditingController? controller;
  final String hint;
  const PhoneInput({
    super.key,
    required this.controller,
    required this.hint,
  });

  @override
  State<PhoneInput> createState() => _PhoneInputState();
}

class _PhoneInputState extends State<PhoneInput> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: IntlPhoneField(
        disableLengthCheck: true,
        controller: widget.controller,
        style: GoogleFonts.firaSans(
          fontSize: 14,
          color: Color(0xFF829AB1),
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
          hintText: widget.hint,
          hintStyle: GoogleFonts.firaSans(
            fontSize: 14,
            color: Color(0xFF829AB1),
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          fillColor:  Color(0xFFF0F4F8).withOpacity(0.7),
          filled: true,
          isDense: true, // Reduces the height
        ),
        initialCountryCode: 'TN',
        onChanged: (phone) {
          // widget.controller.text = phone.number.toString() ;  
        },
      ),
    );
  }
}
