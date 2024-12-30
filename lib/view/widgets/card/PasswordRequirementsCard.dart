import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordRequirementsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Color(0xFFE1E9FF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
           
              child: ListTile(
                leading: Icon(
                  Icons.info_outline,
                  color: Color(0xFF007DB2),
                  size: 25,
                ),
                title: Text(
                  'Doit contenir au moins',
                  style: GoogleFonts.firaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color:  Color(0xFF007DB2),
                  ),
                ),
              ),
            ),
            Text(
              '• Le mot de passe doit comporter au moins huit caractères\n'
              '• Y compris au moins une lettre majuscule\n'
              '• Une lettre minuscule, un numéro et un caractère spécial',
              style: GoogleFonts.firaSans(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF00305B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}