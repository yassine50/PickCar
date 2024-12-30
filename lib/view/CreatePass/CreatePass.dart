import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pickcar/DataClass/user.dart';
import 'package:pickcar/view/ConditionGenerale/ConditionGenerale.dart';
import 'package:pickcar/view/CreatePass/bloc/bloc/createpass_bloc.dart';
import 'package:pickcar/view/widgets/background/background.dart';
import 'package:pickcar/view/widgets/button/AuthButtns.dart';
import 'package:pickcar/view/widgets/card/PasswordRequirementsCard.dart';
import 'package:pickcar/view/widgets/form/PinCode.dart';
import 'package:pickcar/view/widgets/form/input.dart';
import 'package:pickcar/view/widgets/text/text.dart';

class CreatePass extends StatefulWidget {
  final User user;
  CreatePass({super.key, required this.user});

  @override
  State<CreatePass> createState() => CreatePassState();
}

class CreatePassState extends State<CreatePass> {
  TextEditingController pass = TextEditingController();
  TextEditingController confirmPass = TextEditingController();
  static CreatepassBloc CreatePass = CreatepassBloc();
  Color color = const Color(0xFF592FAA);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        const Background(
          url: "assets/images/background2.svg",
        ),
        Container(
            // alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            child: BlocBuilder<CreatepassBloc, CreatepassState>(
                bloc: CreatePass,
                builder: (context, state) {
                  if (state is CreatepassInitial) {
                    return Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          height: 38,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.arrow_back)),
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
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: 'Cré',
                                    style: GoogleFonts.firaSans(
                                      fontSize: 32,
                                      color: const Color(0xFFACC5E7),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'er',
                                        style: GoogleFonts.firaSans(
                                          fontSize: 32,
                                          color: const Color(0xFF5AB58B),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      TextSpan(
                                        text: " votre Mot Passe",
                                        style: GoogleFonts.firaSans(
                                          fontSize: 32,
                                          color: const Color(0xFF001A3E),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 48,
                                ),
                                Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: AllText.text(
                                          fontsize: 16,
                                          color: const Color(0xFF334E68),
                                          FontWeight: FontWeight.w500,
                                          text: "Password"),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF0F4F8)
                                            .withOpacity(0.7),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFFC1CBDE)
                                                .withOpacity(0.6),
                                            blurRadius: 10,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Input(
                                        calculePasse: true,
                                        obscureText: true,
                                        controller: pass,
                                        hint: "**************",
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: AllText.text(
                                          fontsize: 16,
                                          color: const Color(0xFF334E68),
                                          FontWeight: FontWeight.w500,
                                          text: "Confirmation Password"),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF0F4F8)
                                            .withOpacity(0.7),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFFC1CBDE)
                                                .withOpacity(0.6),
                                            blurRadius: 10,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Input(
                                        obscureText: true,
                                        controller: confirmPass,
                                        hint: "**************",
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AllText.text(
                                        fontsize: 12,
                                        color: Colors.black,
                                        FontWeight: FontWeight.w500,
                                        text: "Mot de passe fort"),
                                    Container(
                                      height: 8,
                                      width: 150,
                                      child: LinearProgressIndicator(
                                        color: state.color,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12)),
                                        value: state.strength,
                                        semanticsLabel:
                                            'Linear progress indicator',
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                PasswordRequirementsCard(),
                                AuthButtons(
                                  onTap: () {
                                    if ((pass.text != "" &&
                                            confirmPass.text != "") &&
                                        (pass.text == confirmPass.text) &&
                                        state.strength == 1) {
                                      widget.user.password = pass.text;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ConditionGenerale(
                                                  user: widget.user,
                                                )),
                                      );
                                    } else {}
                                  },
                                  text: 'Continuer',
                                  width: double.infinity,
                                  outlinedButton: false,
                                  firstColor: const Color(0xFF2576B9),
                                  secondColor: const Color(0xFF592FAA),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                          ),
                        )),
                      ],
                    );
                  }
                  return Container();
                }))
      ],
    ));
  }
}
