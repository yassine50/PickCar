import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pickcar/DataClass/user.dart';
import 'package:pickcar/Tools/ApiMethode.dart';
import 'package:pickcar/view/MesVoiture/MesVoiture.dart';
import 'package:pickcar/view/MesVoiture/bloc/bloc/mes_voiture_bloc.dart';
import 'package:pickcar/view/Steps/Steps.dart';
import 'package:pickcar/view/Steps/bloc/bloc/steps_bloc.dart';
import 'package:pickcar/view/Steps/widget/HeadStepper.dart';
import 'package:pickcar/view/Steps/widget/Step1.dart';
import 'package:pickcar/view/Steps/widget/Step2.dart';
import 'package:pickcar/view/widgets/CounterInput/CounterInput.dart';
import 'package:pickcar/view/widgets/button/AuthButtns.dart';
import 'package:pickcar/view/widgets/popups/Allpop.dart';
import 'package:pickcar/view/widgets/text/text.dart';

import '../../MesLocation/bloc/bloc/mesvoiture_bloc.dart';

class Step6Widget extends StatefulWidget {
  final User user;
   final bool ShowStepper;
  const Step6Widget({super.key,  this.ShowStepper =  true, required this.user});

  @override
  State<Step6Widget> createState() => _Step6WidgetState();
}

class _Step6WidgetState extends State<Step6Widget> {
  @override
  Widget build(BuildContext context) {
    return Column(
                          children: [
                            if(widget.ShowStepper) ...{
                               HeadStepper(activeStep: 5,),
                            },
                            
                            Container(
                              // alignment: Alignment.center,
                              // margin: EdgeInsets.symmetric(horizontal: 24,vertical: 8),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Color(0xFF519374)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: Color(0xFF519374),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                      child: AllText.text(
                                          textAlign: TextAlign.center,
                                          fontsize: 14,
                                          color: Color(0xFF519374),
                                          FontWeight: FontWeight.w400,
                                          text: "Privacy Policy ")),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: AllText.text(
                                  fontsize: 12,
                                  color: Color(0xFF16005A),
                                  FontWeight: FontWeight.w400,
                                  text:
                                      "En ajoutant une voiture sur notre plateforme, vous certifiez être le propriétaire légitime du véhicule ou disposer de l'autorisation légale de le louer."
                                      "Le véhicule doit être en bon état de fonctionnement, respectant les normes de sécurité en vigueur, et couvert par une assurance valide durant toute la période de location. "
                                      " Vous vous engagez à maintenir le véhicule régulièrement et à informer les utilisateurs de tout problème éventuel."
                                      " Vous êtes responsable de fixer un prix de location approprié, bien que la plateforme puisse vous conseiller en fonction des tendances du marché."
                                      "En cas de non-respect de ces conditions, nous nous réservons le droit de retirer votre véhicule de la plateforme."
                                      ""),
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: StepsWidgetState.acc,
                                    onChanged: (value) {
                                      setState(() {
                                       StepsWidgetState. acc = value!;
                                      });
                                    }),
                                AllText.text(
                                    fontsize: 12,
                                    color: Colors.black,
                                    FontWeight: FontWeight.w400,
                                    text: "Accepter les conditions")
                              ],
                            ),
                            AuthButtons(
                              onTap: () async {
                                if(StepsWidgetState.acc) {
                                  print('this is the selected brand'+Step2Widget.selectedBrand!) ; 
                                  final response = await ApiMethode.RequestMethode(

      endPoint: "http://10.0.2.2:8080/cars/",
      body: {
          "carIdentifier": "string",

   "carAddress": {
    "place":  StepsWidgetState.country.text,
    "longitude": Step1Widget.addressSelected.lon,
    "latitude":Step1Widget.addressSelected.lat,
  },
 // "rest": StepsWidgetState.restriction.text,

  "mileAge":int.parse(StepsWidgetState.kilometrage.text.toString()) ,
  "seatsNumber": int.parse(StepsWidgetState.place.text.toString()),
  "doorsNumber": int.parse(StepsWidgetState.porte.text.toString()),
  "description": StepsWidgetState.plusInfo.text,
  "dateFirstFabrication": StepsWidgetState.dateTime.year,
  "pricePerHour": int.parse(CounterInputState.currentValue.toString()),
  "model": Step2Widget.SelectedModel!,
    "brand":Step2Widget.selectedBrand!,
     "category": Step2Widget.selectedType!,
  "motor": StepsWidgetState.moteur.text,
  "gearBoxType": StepsWidgetState.boite.text,
  "licensePlate": StepsWidgetState.matricule.text,
   "equipement":  StepsWidgetState.equipment.join('//'),
    "restriction": StepsWidgetState.restriction.text,
      "options": [
    "test"
  ],
   "minDuration": Step2Widget.Min,
  "maxDuration": Step2Widget.Max,
  "photosNames": [
    "test"
  ]
},
      jwt:widget.user.jwtToken!,
      //para: "newMode=${event.newMode}",
      type: "POST",
    );
    if (response != "") {
       Map<String, dynamic> userMap =  json.decode(response);
       for(int i = 0 ; i< 4; i++) {
 final responseimg = await ApiMethode.RequestBodyWithHeader(
      jwt:widget.user.jwtToken!,
      file: Step1WidgetState.images[i],
      fileFieldName: "files",
      fileName: userMap['car']['carIdentifier']+"__"+i.toString()+".png",
      endPoint: "http://10.0.2.2:8080/upload",
      body: {},
      type: "POST",
    );
    sleep(Duration(milliseconds: 120)) ; 
  
       }
    

      MesVoiture.MesVoitureController.emit(MesVoitureInitial());
      Navigator.pop(context); 
      
         Allpups.succsess(context, 'Voiture ajoutée avec succès');
   
    } else {}
  
                                }

                                // activeStep = 1 ;

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