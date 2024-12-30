import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:pickcar/DataClass/address.dart';
import 'package:pickcar/DataClass/car.dart';
import 'package:pickcar/DataClass/user.dart';
import 'package:pickcar/Tools/ApiMethode.dart';
import 'package:pickcar/view/DetailPageMesVoiture/DetailPageMesVoiture.dart';
import 'package:pickcar/view/MesVoiture/MesVoiture.dart';
import 'package:pickcar/view/MesVoiture/bloc/bloc/mes_voiture_bloc.dart';
import 'package:pickcar/view/Steps/Steps.dart';
import 'package:pickcar/view/Steps/bloc/bloc/steps_bloc.dart';
import 'package:pickcar/view/Steps/widget/HeadStepper.dart';
import 'package:pickcar/view/widgets/CounterInput/CounterInput.dart';
import 'package:pickcar/view/widgets/button/AuthButtns.dart';
import 'package:pickcar/view/widgets/form/input.dart';
import 'package:pickcar/view/widgets/popups/Allpop.dart';
import 'package:pickcar/view/widgets/text/text.dart';

class Step1Widget extends StatefulWidget {
  final String car;
  final User user;
  final TextEditingController country;
  final TextEditingController City;
  final TextEditingController street;
  final TextEditingController zipCode;
  final bool ShowStepper;
  final Car? carobject;
  static Address addressSelected = Address();
  Step1Widget({
    super.key,
    required this.country,
    required this.City,
    required this.zipCode,
    required this.street,
    this.ShowStepper = true,
    required this.user,
    this.car = '',
    this.carobject,
  });

  @override
  State<Step1Widget> createState() => Step1WidgetState();
}

class Step1WidgetState extends State<Step1Widget> {
  List<Address> suggestions = [];

  static List<XFile> images = [];

  Future<void> pick() async {
    final img = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (img != null) {
      // the call to the backend
      print("this is teh token" + widget.user.jwtToken.toString());
      setState(() {
        images.add(img);
      });
      // images.add(img);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.ShowStepper) {
      images = [];
    } else {
      widget.country.text = widget.carobject!.address!.country!;
      CounterInputState.currentValue = widget.carobject!.pricePerHour!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.ShowStepper) ...{
          HeadStepper(
            activeStep: 0,
          ),
        },

        Container(
          // margin: EdgeInsets.symmetric(horizontal: 24,vertical: 8),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color(0xFF519374)),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.info_outline,
                color: Color(0xFF519374),
              ),
              SizedBox(
                width: 8,
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: AllText.text(
                      textAlign: TextAlign.start,
                      fontsize: 14,
                      color: Color(0xFF519374),
                      FontWeight: FontWeight.w400,
                      text:
                          "Il faut ajouté tous les détails de votre véhicule pour continuer la procédure d’annonce location "))
            ],
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.directions_car,
              color: Color(0xFF5727BC),
            ),
            AllText.text(
                fontsize: 16,
                color: Color(0xFF5727BC),
                FontWeight: FontWeight.w700,
                text: "Générale info ")
          ],
        ),
        SizedBox(
          height: 8,
        ),
        AllText.text(
            fontsize: 14,
            color: Colors.grey,
            FontWeight: FontWeight.w400,
            text: "Ajouté les photo de 4 face de votre voiture*"),
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: pick,
              child: Container(
                width: MediaQuery.sizeOf(context).width * 0.43,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                    color: images.length > 0 ? Color(0xFF2576B9) : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color(0xFF2576B9))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      images.length > 0
                          ? Icons.check
                          : Icons.file_download_outlined,
                      color:
                          images.length > 0 ? Colors.white : Color(0xFF2576B9),
                    ),
                    AllText.text(
                        fontsize: 15,
                        color: images.length > 0
                            ? Colors.white
                            : Color(0xFF2576B9),
                        FontWeight: FontWeight.w400,
                        text: "Photo 01 avant")
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: pick,
              child: Container(
                width: MediaQuery.sizeOf(context).width * 0.43,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                    color: images.length > 1 ? Color(0xFF2576B9) : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color(0xFF2576B9))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      images.length > 1
                          ? Icons.check
                          : Icons.file_download_outlined,
                      color:
                          images.length > 1 ? Colors.white : Color(0xFF2576B9),
                    ),
                    AllText.text(
                        fontsize: 15,
                        color: images.length > 1
                            ? Colors.white
                            : Color(0xFF2576B9),
                        FontWeight: FontWeight.w400,
                        text: "Photo 02 avant")
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: pick,
              child: Container(
                width: MediaQuery.sizeOf(context).width * 0.43,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                    color: images.length > 2 ? Color(0xFF2576B9) : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color(0xFF2576B9))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      images.length > 2
                          ? Icons.check
                          : Icons.file_download_outlined,
                      color:
                          images.length > 2 ? Colors.white : Color(0xFF2576B9),
                    ),
                    AllText.text(
                        fontsize: 15,
                        color: images.length > 2
                            ? Colors.white
                            : Color(0xFF2576B9),
                        FontWeight: FontWeight.w400,
                        text: "Photo 03 avant")
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: pick,
              child: Container(
                width: MediaQuery.sizeOf(context).width * 0.43,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                    color: images.length > 3 ? Color(0xFF2576B9) : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color(0xFF2576B9))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      images.length > 3
                          ? Icons.check
                          : Icons.file_download_outlined,
                      color:
                          images.length > 3 ? Colors.white : Color(0xFF2576B9),
                    ),
                    AllText.text(
                        fontsize: 15,
                        color: images.length > 3
                            ? Colors.white
                            : Color(0xFF2576B9),
                        FontWeight: FontWeight.w400,
                        text: "Photo 04 avant")
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 8,
        ),
        AllText.text(
            fontsize: 14,
            color: Colors.grey,
            FontWeight: FontWeight.w400,
            text: "Addresse*"),
        SizedBox(
          height: 8,
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFF16005A)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextFormField(
                  onChanged: (value) async {
                    suggestions = [];
                    final response = await ApiMethode.RequestMethode(
                      endPoint: "https://us1.locationiq.com/v1/search",
                      body: {},
                      para: "key=pk.ff45627f7bc7ffb352163e73ee94c19f&q=" +
                          widget.country.text +
                          "&format=json&",
                      type: "GET",
                    );

                    if (response != "") {
                      suggestions = [];
                      //   print(response);
                      List userMap = json.decode(response);
                      for (int i = 0; i < userMap.length; i++) {
                        Address address = Address();
                        address.country = userMap[i]["display_name"];
                        address.lat = double.parse(userMap[i]["lat"]);
                        address.lon = double.parse(userMap[i]["lon"]);
                        print(address.lon);
                        suggestions.add(address);
                      }
                      setState(() {
                        suggestions = suggestions;
                      });
                    }
                  },
                  cursorColor: Colors.black,
                  controller: widget.country,
                  style: GoogleFonts.firaSans(
                    fontSize: 14,
                    color: Color.fromARGB(255, 130, 154, 177),
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    hintText: 'Pays, Ville, Code postal, Rue',
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
            ],
          ),
        ),

        SizedBox(
          height: 8,
        ),

        for (int i = 0; i < suggestions.length; i++) ...{
          GestureDetector(
              onTap: () {
                setState(() {
                  widget.country.text = suggestions[i].country!;
                  Step1Widget.addressSelected = suggestions[i];
                  suggestions = [];
                });
              },
              child: Text(
                suggestions[i].country!,
                style: TextStyle(color: Colors.black),
              )),
          SizedBox(
            height: 8,
          ),
        },

        // Container(
        //   height: suggestions.length * (MediaQuery.sizeOf(context).height* 0.1),
        //   child: ListView.builder(
        //         itemCount: suggestions.length,
        //         itemBuilder: (BuildContext contrext, int index) {
        //           return ListTile(
        //             title: Text(suggestions[index]),
        //           );
        //         },
        //       ),
        // ),

        /*   AllText.text(
                                fontsize: 14,
                                color: Colors.grey,
                                FontWeight: FontWeight.w400,
                                text: "Ville*"),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Color(0xFF16005A)),
                              ),
                              child: Input(
                                controller: City,
                                hint: 'Ajouter la ville ici...',
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            AllText.text(
                                fontsize: 14,
                                color: Colors.grey,
                                FontWeight: FontWeight.w400,
                                text: "Rue*"),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Color(0xFF16005A)),
                              ),
                              child: Input(
                                controller: street,
                                hint: 'Ajouter la rue ici...',
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            AllText.text(
                                fontsize: 14,
                                color: Colors.grey,
                                FontWeight: FontWeight.w400,
                                text: "Code postal*"),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Color(0xFF16005A)),
                              ),
                              child: Input(
                                controller: zipCode,
                                hint: 'Ajouter le code postal ici...',
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),*/
        AllText.text(
            fontsize: 14,
            color: Colors.grey,
            FontWeight: FontWeight.w400,
            text: "Prix par heure*"),
        SizedBox(
          height: 8,
        ),
        const CounterInput(
          width: double.infinity,
          height: 52,
          iconSize: 16,
        ),
        AuthButtons(
          onTap: () async {
            // activeStep = 1 ;

            if (widget.ShowStepper == false) {
              print( "yhis is the status " + widget.carobject!.status!);
              if (( widget.country.text != "" || CounterInputState.currentValue != 0 || images.length == 4) && (widget.carobject!.status =="CREATED"||widget.carobject!.status =="UPDATED"||widget.carobject!.status =="FREE" ) ) {
                if (images.length == 4) {
                  for (int i = 0; i < Step1WidgetState.images.length; i++) {
                    final responseimg = await ApiMethode.RequestBodyWithHeader(
                      jwt: widget.user.jwtToken!,
                      file: Step1WidgetState.images[i],
                      fileFieldName: "files",
                      fileName: widget.car + "__" + i.toString() + ".png",
                      endPoint: "http://10.0.2.2:8080/upload",
                      body: {},
                      type: "POST",
                    );
                    if (responseimg != "") {
                    } else {}
                  }
                }
                final response = await ApiMethode.RequestMethode(
                  endPoint: "http://10.0.2.2:8080/cars/update/" + widget.car,
                  body: {
                    "newCarAddress": {
                      "newPlace": StepsWidgetState.country.text,
                      "newLongitude": Step1Widget.addressSelected.lon,
                      "newLatitude": Step1Widget.addressSelected.lat
                    },
                    "pricePerHour":
                        int.parse(CounterInputState.currentValue.toString()),
                  },
                  jwt: widget.user.jwtToken!,
                  //para: "newMode=${event.newMode}",
                  type: "PUT",
                );

                if (response != "") {
                  MesVoiture.MesVoitureController.add(
                  getCars(user: widget.user));
                  Navigator.pop(context);
                  Navigator.pop(context);
                } else {}
              }else {
                Allpups.warningPopup(context, 'Modification interdite');
              }
            } else {
              if (widget.country.text != "" &&
                  CounterInputState.currentValue != 0 &&
                  images.length == 4) {
                StepsWidgetState.step.emit(Steps2());
              }
            }
          },
          text: 'Continuer',
          width: double.infinity,
          outlinedButton: false,
          firstColor: Color(0xFF2576B9),
          secondColor: Color(0xFF592FAA),
          radius: 8,
        ),
        SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
