import 'package:flutter/material.dart';
import 'package:pickcar/view/widgets/text/text.dart';

class SaveBButton extends StatelessWidget {
   final VoidCallback onTap;
  const SaveBButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
             padding: EdgeInsets.symmetric(vertical: 8),
              width: double.infinity,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  // gradient: LinearGradient(
                  //   begin: Alignment.topCenter,
                  //   end: Alignment.bottomCenter,
                  //   colors: [
                  //     Color(0xFF2576B9),
                  //     Color(0xFF592FAA),
                  //   ],
                  // )
                  color: Color(0xFF2E805D)
                  //  color: Color(0xFF2576B9),
                  ),
              child:AllText.text(fontsize: 16, color: Colors.white, FontWeight: FontWeight.w400, text: "Enregistrer")
            ),
    );
  }
}