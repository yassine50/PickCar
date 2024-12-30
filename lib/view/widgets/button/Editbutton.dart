import 'package:flutter/material.dart';

class EditButton extends StatefulWidget {
  final bool edit ;
   final VoidCallback onTap;
  const EditButton({super.key, required this.onTap, required this.edit});

  @override
  State<EditButton> createState() => _EditButtonState();
}

class _EditButtonState extends State<EditButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
              height: 32,
              width: 32,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF2576B9),
                      Color(0xFF592FAA),
                    ],
                  )
                  //  color: Color(0xFF2576B9),
                  ),
              child:  Icon(
                widget.edit ? Icons.edit : Icons.close,
                size: 18,
                color: Colors.white,
              ),
            ),
    );
  }
}