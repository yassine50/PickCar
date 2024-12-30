import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pickcar/DataClass/user.dart';
import 'package:pickcar/view/CreatePass/CreatePass.dart';
import 'package:pickcar/view/PhoneVerif/bloc/bloc/verif_phone_bloc.dart';
import 'package:pickcar/view/widgets/background/background.dart';
import 'package:pickcar/view/widgets/button/AuthButtns.dart';
import 'package:pickcar/view/widgets/form/PinCode.dart';
import 'package:pickcar/view/widgets/form/input.dart';
import 'package:pickcar/view/widgets/form/phoneInput.dart';
import 'package:pickcar/view/widgets/text/text.dart';

class PhoneVerif extends StatefulWidget {
  final  bool fromProfile  ; 
  final User user ; 
  const PhoneVerif({super.key, required this.user,  this.fromProfile = false , });

  @override
  State<PhoneVerif> createState() => _PhoneVerifState();
}

class _PhoneVerifState extends State<PhoneVerif> {
  TextEditingController code = TextEditingController();
  static VerifPhoneBloc verifPhone = VerifPhoneBloc();
  
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
                            fontSize: 36,
                            color: Color(0xFFACC5E7),
                            fontWeight: FontWeight.w500,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'cation',
                              style: GoogleFonts.firaSans(
                                fontSize: 36,
                                color: Color(0xFF5AB58B),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: " votre Téléphone",
                              style: GoogleFonts.firaSans(
                                fontSize: 36,
                                color: Color(0xFF001A3E),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                     SizedBox(height: 24,),
                   AllText.text(fontsize: 18, color: Colors.black, FontWeight: FontWeight.w500, text: "Le code a été envoyer par SMS"),
                   AllText.text(fontsize: 16, color: Colors.black.withOpacity(0.7), FontWeight: FontWeight.w400, text: "Veuillez saisir le code à 6 chiffres que vous avez reçu pour confirmer votre numéro de téléphone."),
                    SizedBox(height: 8,),
                   AllText.text(fontsize: 11, color: Colors.black, FontWeight: FontWeight.w700, text: "Code de validation est valable juste 40s"),
                   SizedBox(height: 12,),
                   PinCode( code: code,),
                   AuthButtons(
                        onTap: () {
                          if(code.text.length > 5) {
                             verifPhone.add(VerifPhone(context, widget.user, code.text,widget.fromProfile)) ; 
                          //       Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => CreatePass(user: widget.user,)),
                          // );
                          }
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
              
               ],)

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
