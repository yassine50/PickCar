import 'package:flutter/material.dart';

class ProfileVerifCard extends StatelessWidget {
  const ProfileVerifCard({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Pour louer une voiture, votre profil doit être vérifier pour la raisons d’assurance et de sécurité ',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            WidgetSpan(
              child: GestureDetector(
                onTap: () {
                  // Handle the tap event for "Vérifier maintenant"
                  print('Vérifier maintenant tapped!');
                },
                child: Text(
                  'Vérifier maintenant',
                  style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            WidgetSpan(
              child: Icon(Icons.arrow_forward, color: Colors.blue, size: 16),
            ),
          ],
        ),
      ),
    );
  }
}