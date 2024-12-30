import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AllText {
  static Widget text(
      {required double fontsize,
      required color,
      required FontWeight,
      required String text,
      TextAlign textAlign = TextAlign.center, 
      }) {
    return AutoSizeText(
      text,
      textAlign: textAlign,
      style: GoogleFonts.firaSans(
        fontSize: fontsize,
        color: color,
        fontWeight: FontWeight,
      ),
    );
  }
}
