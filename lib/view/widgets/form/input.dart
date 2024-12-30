import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pickcar/view/CreatePass/CreatePass.dart';
import 'package:pickcar/view/CreatePass/bloc/bloc/createpass_bloc.dart';

class Input extends StatefulWidget {
  final TextEditingController controller;
  final bool calculePasse;
  final String hint;
  final bool obscureText;
  const Input({
    super.key,
    required this.controller,
    required this.hint,
    this.obscureText = false,
    this.calculePasse = false,
  });

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  late bool _obscureText;
  @override
  void initState() {
    _obscureText = widget.obscureText;
    super.initState();
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextFormField(
            onChanged: (value) {
              if (widget.calculePasse) {
                CreatePassState.CreatePass.add(CalculeStrength(value));
              }
            },
            obscureText: _obscureText,
            cursorColor: Colors.black,
            controller: widget.controller,
            style: GoogleFonts.firaSans(
              fontSize: 14,
              color: Color(0xFF829AB1),
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
              hintText: widget.hint,
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
        if (widget.obscureText) ...{
          IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: Color(0xFF829AB1),
            ),
            onPressed: _toggleVisibility,
          ),
        }
      ],
    );
  }
}
