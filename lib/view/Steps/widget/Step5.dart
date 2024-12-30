import 'package:flutter/material.dart';
import 'package:pickcar/DataClass/car.dart';
import 'package:pickcar/DataClass/user.dart';
import 'package:pickcar/Tools/ApiMethode.dart';
import 'package:pickcar/view/DetailPageMesVoiture/DetailPageMesVoiture.dart';
import 'package:pickcar/view/MesVoiture/MesVoiture.dart';
import 'package:pickcar/view/Steps/Steps.dart';
import 'package:pickcar/view/Steps/bloc/bloc/steps_bloc.dart';
import 'package:pickcar/view/Steps/widget/HeadStepper.dart';
import 'package:pickcar/view/widgets/button/AuthButtns.dart';
import 'package:pickcar/view/widgets/form/input.dart';
import 'package:pickcar/view/widgets/popups/Allpop.dart';
import 'package:pickcar/view/widgets/text/text.dart';

import '../../MesVoiture/bloc/bloc/mes_voiture_bloc.dart';

class Step5Widget extends StatefulWidget {
  final String car;
  final User user;
  final TextEditingController restriction;
  final TextEditingController plusInfo;
  final Car? carobject;
  final bool ShowStepper;
  const Step5Widget(
      {super.key,
      required this.restriction,
      required this.plusInfo,
      this.ShowStepper = true,
      required this.user,
      this.car = "",
      this.carobject});

  @override
  State<Step5Widget> createState() => _Step5WidgetState();
}

class _Step5WidgetState extends State<Step5Widget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
       if (widget.ShowStepper) {
    } else {
             widget.restriction.text    = widget.carobject!.restriction!; 
             widget.plusInfo.text = widget.carobject!.description!; 

    }

  }
  @override
  Widget build(BuildContext context) {
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.ShowStepper) ...{
          HeadStepper(
            activeStep: 4,
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
                          "Ajouté quelque détails de votre véhicule pour continuer la procédure d’annonce location  ")),
            ],
          ),
        ),
        SizedBox(
          height: 8,
        ),
        AllText.text(
            fontsize: 14,
            color: Colors.grey,
            FontWeight: FontWeight.w400,
            text: "Restriction*"),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFF16005A)),
          ),
          child: Input(
            controller: widget.restriction,
            hint: 'Ne passe pas 300 caractère...... ',
          ),
        ),
        SizedBox(
          height: 8,
        ),
        AllText.text(
            fontsize: 14,
            color: Colors.grey,
            FontWeight: FontWeight.w400,
            text: "Plus d’information de votre véhicule*"),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFF16005A)),
          ),
          child: Input(
            controller: widget.plusInfo,
            hint: 'Ne passe pas 300 caractère...... ',
          ),
        ),
        AuthButtons(
          onTap: () async {
            // activeStep = 1 ;
            if (widget.restriction.text != "" && widget.plusInfo.text != "") {
              if (widget.ShowStepper == false) {
                  if (widget.carobject!.status == "CREATED" ||
                    widget.carobject!.status == "UPDATED" ||
                    widget.carobject!.status == "FREE") {
                        final response = await ApiMethode.RequestMethode(
                  endPoint: "http://10.0.2.2:8080/cars/update/" + widget.carobject!.carId!.toString(),
                  body: {
                   "restriction": widget.restriction.text,
                     "description": widget.plusInfo.text
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
                    }else{
                       Allpups.warningPopup(context, 'Modification interdite'); 
                    }
              
              } else {
                StepsWidgetState.step.emit(Steps6());
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
