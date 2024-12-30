import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pickcar/view/widgets/background/background.dart';
import 'package:pickcar/view/widgets/button/AuthButtns.dart';
import 'package:pickcar/view/widgets/form/input.dart';
import 'package:pickcar/view/widgets/text/text.dart';

class VerifAccount extends StatefulWidget {
  const VerifAccount({super.key});

  @override
  State<VerifAccount> createState() => _VerifAccountState();
}

class _VerifAccountState extends State<VerifAccount> {
  TextEditingController confirm = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Background(
          url: "assets/images/background2.svg",
        ),
        Container(
          // alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 38,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back)),
                  Container(
                    height: 36,
                    width: 36,
                    child: SvgPicture.asset(
                      "assets/images/topAppBar.svg",
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
              Expanded(
                  child: Center(
                child: SingleChildScrollView(
                  // reverse: ,
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'Vérifi',
                          style: GoogleFonts.firaSans(
                            fontSize: 32,
                            color: Color(0xFFACC5E7),
                            fontWeight: FontWeight.w500,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'cation',
                              style: GoogleFonts.firaSans(
                                fontSize: 32,
                                color: Color(0xFF5AB58B),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: " votre compte",
                              style: GoogleFonts.firaSans(
                                fontSize: 32,
                                color: Color(0xFF001A3E),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 42,),
                   Container(
                    alignment: Alignment.topLeft,
                    child: AllText.text(fontsize: 16, color: Color(0xFF001A3E), FontWeight: FontWeight.w400, text: "Le code a été envoyer")) , 
                   SizedBox(height: 18,),

Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: AllText.text(
                                fontsize: 11,
                                color: Color(0xFF334E68),
                                FontWeight: FontWeight.w500,
                                text: "Code de validation"),
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
                              controller: confirm,
                              hint: "**************",
                            ),
                          )
                        ],
                      ),


                   AuthButtons(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => VerifAccount()),
                          // );
                        },
                        text: 'Continuer',
                        width: double.infinity,
                        outlinedButton: false,
                        firstColor: Color(0xFF2576B9),
                        secondColor: Color(0xFF592FAA),
                      ),
                      SizedBox(height: 8,),
                        Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AllText.text(fontsize: 14, color: Colors.black, FontWeight: FontWeight.w600, text: "Je n’ai pas reçu de code de validation "),
                   AllText.text(fontsize: 14, color: Color(0xFF2576B9), FontWeight: FontWeight.w600, text: " Clic ici "),
              
               ],),
                      SizedBox(height: 26,),
                    ],
                  ),
                ),
              )),
            ],
          ),
        )
      ],
    ));
  }
}