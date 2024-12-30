import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthButtons extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final double width;
  final Color firstColor;
  final Color secondColor;
  final bool outlinedButton;
  final double radius ; 

  const AuthButtons({
    Key? key,
    required this.onTap,
    required this.text,
    required this.width,
    required this.outlinedButton,
    required this.firstColor,
    required this.secondColor,  this.radius = 48,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle outlinedStyle = OutlinedButton.styleFrom(
      foregroundColor: firstColor,
      side: BorderSide(color: firstColor),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(48)),
      backgroundColor: Colors.white,
    );

    return Container(
      margin: const EdgeInsets.only(top: 12),
      width: width,
      height: 48,
      decoration: BoxDecoration(
        gradient: outlinedButton
            ? null
            : LinearGradient(
                colors: [firstColor, secondColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: outlinedButton
          ? OutlinedButton(
              onPressed: onTap,
              style: outlinedStyle,
              child: Text(
                text,
                style: GoogleFonts.firaSans(
                  fontSize: 14,
                  color: firstColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          : ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(48),
                ),
              ),
             
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    text,
                    style: GoogleFonts.firaSans(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
             
            ),
    );
  }
}
