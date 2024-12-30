import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pickcar/DataClass/user.dart';
import 'package:pickcar/view/Mode/bloc/bloc/mode_bloc.dart';
import 'package:pickcar/view/widgets/background/background.dart';
import 'package:pickcar/view/widgets/button/AuthButtns.dart';

class Mode extends StatefulWidget {
  final User user ;
  const Mode({super.key, required this.user});

  @override
  State<Mode> createState() => _ModeState();
}

class _ModeState extends State<Mode> {
  static ModeBloc mode = ModeBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(
            url: "assets/images/background1.svg",
          ),
          Container(
            // alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 24),
            child:  Column(
                 mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 290,
                    width: 397,
                    child: SvgPicture.asset(
                      'assets/images/mode.svg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  AuthButtons(
                        onTap: () {
                          mode.add(ModeFunction(context: context,newMode: "CUSTOMER", user: widget.user));
                        
                        },
                        text: 'Locataire',
                        width: double.infinity,
                        outlinedButton: false,
                        firstColor: Color(0xFF5AB58B),
                        secondColor: Color(0xFFC4E4D3),
                      ),
                      AuthButtons(
                       onTap: () {
                          mode.add(ModeFunction(context: context,newMode: "RENTER",user: widget.user));
                        
                        },
                        text: 'Propriétaire',
                        width: double.infinity,
                        outlinedButton: false,
                        firstColor: Color(0xFF2576B9),
                        secondColor: Color(0xFF592FAA),
                      ),
              SizedBox(height: 160,)
                ],
              ),
         
          )
        ],
      ),
    );
  }
}