import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pickcar/DataClass/user.dart';
import 'package:pickcar/view/ConditionGenerale/bloc/bloc/register_bloc.dart';
import 'package:pickcar/view/Mode/mode.dart';
import 'package:pickcar/view/VerifAccount/VerifAccount.dart';
import 'package:pickcar/view/widgets/background/background.dart';
import 'package:pickcar/view/widgets/button/AuthButtns.dart';
import 'package:pickcar/view/widgets/text/text.dart';

class ConditionGenerale extends StatefulWidget {
  final User user;
  const ConditionGenerale({super.key, required this.user});

  @override
  State<ConditionGenerale> createState() => _ConditionGeneraleState();
}

class _ConditionGeneraleState extends State<ConditionGenerale> {
  static RegisterBloc register = RegisterBloc();
  bool _accepted = false;

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
              SizedBox(
                height: 28,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Cond',
                  style: GoogleFonts.firaSans(
                    fontSize: 32,
                    color: Color(0xFFACC5E7),
                    fontWeight: FontWeight.w500,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'itions',
                      style: GoogleFonts.firaSans(
                        fontSize: 32,
                        color: Color(0xFF5AB58B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: " Générale",
                      style: GoogleFonts.firaSans(
                        fontSize: 32,
                        color: Color(0xFF001A3E),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 42,
              ),
              Container(
                  alignment: Alignment.topLeft,
                  child: AllText.text(
                      fontsize: 16,
                      color: Color(0xFF001A3E),
                      FontWeight: FontWeight.w400,
                      text: "Le code a été envoyer")),
              SizedBox(
                height: 12,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F7FA).withOpacity(0.19),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  // height,
                  child: SingleChildScrollView(
                      child: AllText.text(
                          textAlign: TextAlign.start,
                          fontsize: 14,
                          color: Color(0xFF001A3E).withOpacity(0.9),
                          FontWeight: FontWeight.w400,
                          text:
                              'En vous inscrivant ou en vous connectant à notre application, vous acceptez nos conditions générales d''utilisation. '
                              'Vos informations personnelles seront traitées conformément à notre politique de confidentialité, et nous nous engageons à protéger vos données. '
                              'Vous êtes responsable de la sécurité de votre compte et de la confidentialité de vos identifiants.'
                              'Toute activité réalisée depuis votre compte vous incombe.'
                              'Nous nous réservons le droit de suspendre ou de désactiver votre accès en cas de violation des présentes conditions. '
                              'L''utilisation de l''application est soumise aux lois en vigueur dans votre juridiction.'
                              'En cas de litige, seules les juridictions compétentes seront habilitées à statuer.'
                            )),
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Checkbox(
                    value: _accepted,
                    onChanged: (bool? value) {
                      setState(() {
                        _accepted = value ?? false;
                      });
                    },
                  ),
                  Expanded(
                    child: Text(
                      'Accepter les conditions*',
                      style: GoogleFonts.firaSans(
                        fontSize: 16,
                        color: Color(0xFF2E3A59),
                      ),
                    ),
                  ),
                ],
              ),
              AuthButtons(
                onTap: () {
                  if (_accepted) {
                    register.add(Register(context, widget.user));
                    //                 Navigator.push(
                    // context,
                    //  MaterialPageRoute(
                    //                           builder: (context) => Mode()),
                    //                     );
                  }
                },
                text: 'Continuer',
                width: double.infinity,
                outlinedButton: false,
                firstColor: Color(0xFF2576B9),
                secondColor: Color(0xFF592FAA),
              ),
              SizedBox(
                height: 26,
              ),
            ],
          ),
        )
      ],
    ));
  }
}
