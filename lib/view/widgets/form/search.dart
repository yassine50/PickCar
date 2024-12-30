import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pickcar/view/Home/Home.dart';
import 'package:pickcar/view/Home/bloc/bloc/home_bloc.dart';
import 'package:pickcar/view/widgets/Filtre/bloc/bloc/filter_bloc_bloc.dart';
import 'package:pickcar/view/widgets/Filtre/flitre.dart';

class Search extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final  bool onChange ; 
  const Search({super.key, required this.controller, required this.hint,  this.onChange = false});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      decoration: BoxDecoration(
        color: Colors.white,
          border: Border.all(color: Color(0xFF2576B9)),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: TextFormField(
        onChanged: (value) {
          if(widget.onChange) {
           // Home.HomeController.add(getCars());
           if(value.length >3) {
           Filtre.filtreBloc.add(getAdress(value)); 

           }
          }
        },
        cursorColor: Colors.black,
        
        controller: widget.controller,
        style: GoogleFonts.firaSans(
          fontSize: 14,
          color: Color(0xFF829AB1),
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xFF2576B9),
          ),
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
    );
  }
}
