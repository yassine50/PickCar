
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pickcar/DataClass/address.dart';
import 'package:pickcar/DataClass/user.dart';
import 'package:pickcar/Tools/ApiMethode.dart';
import 'package:pickcar/Tools/Constants.dart';
import 'package:pickcar/view/CreatePass/CreatePass.dart';
import 'package:pickcar/view/PhoneVerif/PhoneVerif.dart';
import 'package:pickcar/view/widgets/background/background.dart';
import 'package:pickcar/view/widgets/button/AuthButtns.dart';
import 'package:pickcar/view/widgets/button/DropDownSginUp.dart';
import 'package:pickcar/view/widgets/form/input.dart';
import 'package:pickcar/view/widgets/form/phoneInput.dart';
import 'package:pickcar/view/widgets/text/text.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nom = TextEditingController();
  TextEditingController prenom = TextEditingController();
  TextEditingController email = TextEditingController();
TextEditingController phone = TextEditingController();
  TextEditingController codePostal = TextEditingController();
  TextEditingController ville = TextEditingController();
  TextEditingController nationalite = TextEditingController();
    TextEditingController adresse = TextEditingController();
      DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1960),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    // phone = PhoneNumber(countryISOCode: "TN", countryCode: "+216", number: "");
    super.initState();
  }

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
            child: SingleChildScrollView(
              reverse: true,
              physics: BouncingScrollPhysics(),
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
                  RichText(
                    text: TextSpan(
                      text: 'Cré',
                      style: GoogleFonts.firaSans(
                        fontSize: 36,
                        color: Color(0xFFACC5E7),
                        fontWeight: FontWeight.w500,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'er',
                          style: GoogleFonts.firaSans(
                            fontSize: 36,
                            color: Color(0xFF5AB58B),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: " un compte",
                          style: GoogleFonts.firaSans(
                            fontSize: 36,
                            color: Color(0xFF001A3E),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: AllText.text(
                            fontsize: 16,
                            color: Color(0xFF334E68),
                            FontWeight: FontWeight.w500,
                            text: "Nom*"),
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
                          controller: nom,
                          hint: "Nom",
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: AllText.text(
                            fontsize: 16,
                            color: Color(0xFF334E68),
                            FontWeight: FontWeight.w500,
                            text: "Prénom*"),
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
                          controller: prenom,
                          hint: "Prénom",
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: AllText.text(
                            fontsize: 16,
                            color: Color(0xFF334E68),
                            FontWeight: FontWeight.w500,
                            text: "Email*"),
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
                  SizedBox(height: 8.0),
              
               Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: AllText.text(
                            fontsize: 16,
                            color: Color(0xFF334E68),
                            FontWeight: FontWeight.w500,
                            text: "Date de naissance*"),
                      ),
                      SizedBox(height: 8.0),
                      GestureDetector(
                        onTap: () {
_selectDate(context);
                        } ,
                        child: Container(
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
                          child:Container(
                            alignment: Alignment.topLeft,
                            width: double.infinity,
                             padding:EdgeInsets.symmetric(vertical: 12,horizontal: 16),
                            decoration: BoxDecoration(
                             
                            ),
                            child: AllText.text(fontsize: 14, color: Color(0xFF829AB1), FontWeight: FontWeight.w400, text: DateFormat('yyyy/MM/dd')
                                  .format(selectedDate)
                                  .toString()),
                          )
                        ),
                      )
                    ],
                  ),
              
                 SizedBox(height: 8.0),
              
              
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: AllText.text(
                            fontsize: 16,
                            color: Color(0xFF334E68),
                            FontWeight: FontWeight.w500,
                            text: "Numéro de téléphone*"),
                      ),
                   

                      // alignment: Alignment.center,

                      PhoneInput(
                          controller: phone,
                          hint: "Entrer votre numéro de téléphone"),
                    ],
                  ),
                 
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: AllText.text(
                            fontsize: 16,
                            color: Color(0xFF334E68),
                            FontWeight: FontWeight.w500,
                            text: "Pays*"),
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
                        child: DropDownSginUp(list: Constants.countries, )
                      )
                    ],
                  ),
                     SizedBox(height: 8.0),
                  
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: AllText.text(
                            fontsize: 16,
                            color: Color(0xFF334E68),
                            FontWeight: FontWeight.w500,
                            text: "Code Postale*"),
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
                          controller: codePostal,
                          hint: "Code Postale",
                        ),
                      )
                    ],
                  ),
                 
                  SizedBox(height: 8.0),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: AllText.text(
                            fontsize: 16,
                            color: Color(0xFF334E68),
                            FontWeight: FontWeight.w500,
                            text: "Ville*"),
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
                          controller: ville,
                          hint: "Ville",
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 8.0),
                    Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: AllText.text(
                            fontsize: 16,
                            color: Color(0xFF334E68),
                            FontWeight: FontWeight.w500,
                            text: "Adresse*"),
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
                          controller: adresse,
                          hint: "Adresse",
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: AllText.text(
                            fontsize: 16,
                            color: Color(0xFF334E68),
                            FontWeight: FontWeight.w500,
                            text: "Nationalité*"),
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
                          controller: nationalite,
                          hint: "Nationalité",
                        ),
                      )
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(bottom: 24),
                      child: AuthButtons(
                        onTap: () {
                          if(nom.text !="" && prenom.text !="" &&   email.text !=""   && phone.text != "" && codePostal.text !="" && ville.text !="" && nationalite.text !="" ) {
                            // signUp.add(event) ;
                            Address address = Address(zipCode: codePostal.text ,city:ville.text,country: DropDownSginUp.pays ,street: adresse.text ) ; 
                            User user = User(firstName: nom.text , lastName: prenom.text ,email: email.text , phone: phone.text ,address:address , nationality: nationalite.text ,dateOfBirth:selectedDate ) ; 
                           
                          
                            // ApiMethode.RequestMethode(endPoint: "http://10.0.2.2:8080/verification/send/one-time-password" ,body:{}, type: "POST",para: "phoneNumber=%2B216"+phone.text);
                            
                             Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreatePass(
                  user: user,
                )),
                          );
                          }
                         
                        },
                        text: 'Continuer',
                        width: double.infinity,
                        outlinedButton: false,
                        firstColor: Color(0xFF2576B9),
                        secondColor: Color(0xFF592FAA),
                      )
                      ),
                ],
              ),
            ),
          )
        ],
      ),
    );
    ;
  }
}
