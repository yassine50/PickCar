import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pickcar/Tools/emailVerif.dart';
import 'package:pickcar/view/Login/bloc/bloc/login_bloc.dart';
import 'package:pickcar/view/sign%20up/SignUp.dart';
import 'package:pickcar/view/widgets/background/background.dart';
import 'package:pickcar/view/widgets/button/AuthButtns.dart';
import 'package:pickcar/view/widgets/form/input.dart';
import 'package:pickcar/view/widgets/text/text.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static LoginBloc login = LoginBloc();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(
            url: "assets/images/background.svg",
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              reverse: true,
              physics: BouncingScrollPhysics(),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 264,
                    width: 397,
                    child: SvgPicture.asset(
                      'assets/images/loginImage.svg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Bi',
                      style: GoogleFonts.firaSans(
                        fontSize: 36,
                        color: Color(0xFFACC5E7),
                        fontWeight: FontWeight.w500,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'en',
                          style: GoogleFonts.firaSans(
                            fontSize: 36,
                            color: Color(0xFF5AB58B),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: "venue a Pickar.",
                          style: GoogleFonts.firaSans(
                            fontSize: 36,
                            color: Color(0xFF001A3E),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: AllText.text(
                            fontsize: 16,
                            color: Color(0xFF334E68),
                            FontWeight: FontWeight.w500,
                            text: "Email"),
                      ),
                      SizedBox(height: 8.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF0F4F8).withOpacity(0.7),
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFFC1CBDE).withOpacity(0.6),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Input(
                          controller: email,
                          hint: "Name@example.com",
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: AllText.text(
                            fontsize: 16,
                            color: Color(0xFF334E68),
                            FontWeight: FontWeight.w500,
                            text: "Password"),
                      ),
                      SizedBox(height: 8.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF0F4F8).withOpacity(0.7),
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFFC1CBDE).withOpacity(0.6),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Input(
                          obscureText: true,
                          controller: pass,
                          hint: "**************",
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      AuthButtons(
                        onTap: () {
                          if (email.text != "" ) {
                            login.add(LoginEvents(pass.text, email.text, context)) ;
                          }
                        },
                        text: 'Se connecter',
                        width: double.infinity,
                        outlinedButton: false,
                        firstColor: Color(0xFF5AB58B),
                        secondColor: Color(0xFFC4E4D3),
                      ),
                      AuthButtons(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUp()),
                          );
                        },
                        text: 'Créations compte',
                        width: double.infinity,
                        outlinedButton: false,
                        firstColor: Color(0xFF2576B9),
                        secondColor: Color(0xFF592FAA),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AllText.text(
                              fontsize: 14,
                              color: Colors.black,
                              FontWeight: FontWeight.w600,
                              text: "Mot de passe oublié?"),
                          AllText.text(
                              fontsize: 14,
                              color: Color(0xFF2576B9),
                              FontWeight: FontWeight.w600,
                              text: "Réinitialiser maintenant"),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
