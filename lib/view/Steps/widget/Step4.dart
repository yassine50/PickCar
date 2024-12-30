import 'package:flutter/material.dart';
import 'package:pickcar/DataClass/car.dart';
import 'package:pickcar/DataClass/user.dart';
import 'package:pickcar/Tools/ApiMethode.dart';
import 'package:pickcar/Tools/Constants.dart';
import 'package:pickcar/view/MesVoiture/MesVoiture.dart';
import 'package:pickcar/view/MesVoiture/bloc/bloc/mes_voiture_bloc.dart';
import 'package:pickcar/view/Steps/Steps.dart';
import 'package:pickcar/view/Steps/bloc/bloc/steps_bloc.dart';
import 'package:pickcar/view/Steps/widget/HeadStepper.dart';
import 'package:pickcar/view/widgets/button/AuthButtns.dart';
import 'package:pickcar/view/widgets/popups/Allpop.dart';
import 'package:pickcar/view/widgets/text/text.dart';

class Step4Widget extends StatefulWidget {
  final User user;
  final bool ShowStepper;
   final Car? carobject;
  const Step4Widget({super.key, this.ShowStepper = true, required this.user, this.carobject});

  @override
  State<Step4Widget> createState() => _Step4State();
}

class _Step4State extends State<Step4Widget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.ShowStepper) {
    } else {
             StepsWidgetState.equipment = widget.carobject!.equipmentAndOptions! ; 

    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.ShowStepper) ...{
          HeadStepper(
            activeStep: 3,
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
                text: "Equipement et les options ")
          ],
        ),
        SizedBox(
          height: 8,
        ),
        AllText.text(
            fontsize: 14,
            color: Colors.grey,
            FontWeight: FontWeight.w400,
            text: "Equipement et les options *"),
        SizedBox(
          height: 8,
        ),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          runSpacing: 8,
          children: [
            for (int i = 0; i < Constants.carEquipmentNames.length; i++)
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (StepsWidgetState.equipment
                        .contains(Constants.carEquipmentNames[i])) {
                      StepsWidgetState.equipment
                          .remove(Constants.carEquipmentNames[i]);
                    } else {
                      StepsWidgetState.equipment
                          .add(Constants.carEquipmentNames[i]);
                    }
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  decoration: BoxDecoration(
                    color: StepsWidgetState.equipment
                            .contains(Constants.carEquipmentNames[i])
                        ? Colors.blue
                        : Colors.white,
                    border: Border.all(color: Color(0xFF468ACE)),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: AllText.text(
                    fontsize: 14,
                    color: StepsWidgetState.equipment
                            .contains(Constants.carEquipmentNames[i])
                        ? Colors.white
                        : Color(0xFF468ACE),
                    FontWeight: FontWeight.w500,
                    text: Constants.carEquipmentNames[i],
                  ),
                ),
              ),
          ],
        ),
        AuthButtons(
          onTap: () async {
            // activeStep = 1 ;
            if (StepsWidgetState.equipment.length != 0) {


                 if (widget.ShowStepper == false) {
                if (widget.carobject!.status == "CREATED" ||
                    widget.carobject!.status == "UPDATED" ||
                    widget.carobject!.status == "FREE") {
                       final response = await ApiMethode.RequestMethode(
                    endPoint: "http://10.0.2.2:8080/cars/update/" + widget.carobject!.carId!.toString(),
                    body: {
                    "equipement":  StepsWidgetState.equipment.join('//'),
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
                    }


              StepsWidgetState.step.emit(Steps5());
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
