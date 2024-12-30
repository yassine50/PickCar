import 'package:flutter/material.dart';
import 'package:pickcar/DataClass/car.dart';
import 'package:pickcar/DataClass/user.dart';
import 'package:pickcar/Tools/ApiMethode.dart';
import 'package:pickcar/Tools/Constants.dart';
import 'package:pickcar/view/DetailPageMesVoiture/DetailPageMesVoiture.dart';
import 'package:pickcar/view/MesVoiture/MesVoiture.dart';
import 'package:pickcar/view/MesVoiture/bloc/bloc/mes_voiture_bloc.dart';
import 'package:pickcar/view/Steps/Steps.dart';
import 'package:pickcar/view/Steps/bloc/bloc/steps_bloc.dart';
import 'package:pickcar/view/Steps/widget/HeadStepper.dart';
import 'package:pickcar/view/widgets/button/AuthButtns.dart';
import 'package:pickcar/view/widgets/button/DropDownButton.dart';
import 'package:pickcar/view/widgets/form/input.dart';
import 'package:pickcar/view/widgets/popups/Allpop.dart';
import 'package:pickcar/view/widgets/text/text.dart';

class Step3Widget extends StatefulWidget {
  final String car;
  final User user;
  final TextEditingController boite;
  final TextEditingController moteur;
  final TextEditingController kilometrage;
  final TextEditingController porte;
  final TextEditingController place;
  final bool ShowStepper;
    final Car? carobject;
  

  const Step3Widget(
      {super.key,
      required this.boite,
      required this.moteur,
      required this.kilometrage,
      required this.porte,
      required this.place,
      this.ShowStepper = true,
      required this.user,
      this.car = "", this.carobject});

  @override
  State<Step3Widget> createState() => _Step3WidgetState();
}

class _Step3WidgetState extends State<Step3Widget> {
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.ShowStepper) {
    
    } else {
     widget.boite.text = widget.carobject!.gearboxType! ; 
     widget.moteur.text = widget.carobject!.motor!; 
      widget.kilometrage.text = widget.carobject!.mileage!.toString(); 
       widget.porte.text = widget.carobject!.doorsNumber!.toString() ; 
        widget.place.text =  widget.carobject!.seatsNumber!.toString() ; 
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.ShowStepper) ...{
          HeadStepper(
            activeStep: 2,
          ),
        },

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
                text: "Informations Mécanique")
          ],
        ),
        SizedBox(
          height: 8,
        ),
        AllText.text(
            fontsize: 14,
            color: Colors.grey,
            FontWeight: FontWeight.w400,
            text: "Boite de vitesse*"),
        // Container(
        //   width: double.infinity,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(8),
        //     border: Border.all(color: Color(0xFF16005A)),
        //   ),
        //   child: Input(
        //     controller: boite,
        //     hint: 'Ajouter le type de boite de vitesse',
        //   ),
        // ),

        DropDuwnButton(
          list: Constants.gearBoxTypes,value:  widget.ShowStepper ? null :  widget.boite.text,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                widget.boite.text = value;
              });
            }
          },
        ),
        AllText.text(
            fontsize: 14,
            color: Colors.grey,
            FontWeight: FontWeight.w400,
            text: "Moteur*"),
        DropDuwnButton(
          list: Constants.carMotors ,value:  widget.ShowStepper ? null : widget.moteur.text,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                widget.moteur.text = value;
              });
            }
          },
        ),

        // Container(
        //   width: double.infinity,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(8),
        //     border: Border.all(color: Color(0xFF16005A)),
        //   ),
        //   child: Input(
        //     controller: moteur,
        //     hint: 'Ajouter le nom de moteur',
        //   ),
        // ),
        AllText.text(
            fontsize: 14,
            color: Colors.grey,
            FontWeight: FontWeight.w400,
            text: "Kilométrage*"),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFF16005A)),
          ),
          child: Input(
            controller: widget.kilometrage,
            hint: '0-15 000klm',
          ),
        ),
        AllText.text(
            fontsize: 14,
            color: Colors.grey,
            FontWeight: FontWeight.w400,
            text: "Porte*"),
        DropDuwnButton(
          list: List.generate(6, (index) => (index + 1).toString()), value: widget.ShowStepper ? null : widget.porte.text,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                widget.porte.text = value;
              });
            }
          },
        ),

        AllText.text(
            fontsize: 14,
            color: Colors.grey,
            FontWeight: FontWeight.w400,
            text: "Place*"),
        DropDuwnButton(
          list: List.generate(8, (index) => (index + 1).toString()), value: widget.ShowStepper ? null :  widget.place.text,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                widget.place.text = value;
              });
            }
          },
        ),

        AuthButtons(
          onTap: () async {
            // activeStep = 1 ;
            if (widget.boite.text != "" &&
                widget.moteur.text != "" &&
                widget.kilometrage.text != "" &&
                widget.porte.text != "" &&
                widget.place.text != "") {
              if (widget.ShowStepper == false) {
                if (widget.carobject!.status == "CREATED" ||
                    widget.carobject!.status == "UPDATED" ||
                    widget.carobject!.status == "FREE") {
                          final response = await ApiMethode.RequestMethode(
                    endPoint: "http://10.0.2.2:8080/cars/update/" + widget.car,
                    body: {
                      "gearBoxType": widget.boite.text,
                       "motor":widget.moteur.text,
                    "mileAge":int.parse(widget.kilometrage.text) ,
                    "seatsNumber": int.parse(widget.place.text),
                    "doorsNumber": int.parse(widget.porte.text),
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
                      Allpups.warningPopup(context, 'La voiture est en cours de location.');
                    }
             
              } else {
                StepsWidgetState.step.emit(Steps4());
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
    ;
  }
}
