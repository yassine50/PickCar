import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
import 'package:pickcar/view/widgets/CounterInput/CounterInput.dart';
import 'package:pickcar/view/widgets/button/AuthButtns.dart';
import 'package:pickcar/view/widgets/button/DropDownButton.dart';
import 'package:pickcar/view/widgets/form/input.dart';
import 'package:pickcar/view/widgets/popups/Allpop.dart';
import 'package:pickcar/view/widgets/text/text.dart';

class Step2Widget extends StatefulWidget {
  final Car? carobject;
  final String car;
  final User user;
  final TextEditingController matricule;
  static String? selectedBrand;
  static String? selectedType;
  static String? SelectedModel;
  static String? Min;
  static String? Max;

  bool ShowStepper;
  Step2Widget({
    super.key,
    required this.matricule,
    this.ShowStepper = true,
    required this.user,
    this.car = "",
    this.carobject,
  });

  @override
  State<Step2Widget> createState() => _Step2WidgetState();
}

class _Step2WidgetState extends State<Step2Widget> {
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      //initialEntryMode:DatePickerEntryMode. ,
      initialDatePickerMode: DatePickerMode.year,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        StepsWidgetState.dateTime = picked;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.ShowStepper) {
      Step2Widget.selectedBrand = null;
      Step2Widget.selectedType = null;
      Step2Widget.SelectedModel = null;
      Step2Widget.Min = null;
      Step2Widget.Max = null;
    } else {
      widget.matricule.text = widget.carobject!.licensePlate!;
      StepsWidgetState.dateTime =
          DateTime(widget.carobject!.dateFirstFabrication!);
      Step2Widget.selectedBrand = widget.carobject!.brand;
      Step2Widget.selectedType = widget.carobject!.category!;
      Step2Widget.SelectedModel = widget.carobject!.model;
      Step2Widget.Min = widget.carobject!.min!.toString();
      Step2Widget.Max = widget.carobject!.max!.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget GetModel() {
      List<String> model = [];
      for (int i = 0; i < Constants.carModels.length; i++) {
        if (Constants.carModels[i]["brand"] == Step2Widget.selectedBrand) {
          model = Constants.carModels[i]["models"];
        }
      }
      return DropDuwnButton(
        list: model,
        value: widget.ShowStepper ? null : widget.carobject!.model,
        onChanged: (value) {
          if (value != null) {
            setState(() {
              Step2Widget.SelectedModel = value;
            });
          }
        },
      );

      // Wrap(
      //             alignment: WrapAlignment.center,
      //             spacing: 8,
      //             runSpacing: 8,
      //             children: [
      //               for (int i = 0; i < model.length; i++)
      //                 GestureDetector(
      //                   onTap: () {
      //                     setState(() {
      //                      Step2Widget.SelectedModel = model[i];
      //                     });
      //                   },
      //                   child: Container(
      //                     padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      //                     decoration: BoxDecoration(
      //                       color: Step2Widget.SelectedModel ==model[i]
      //                           ? Colors.blue
      //                           : Colors.white,
      //                       border: Border.all(color: Color(0xFF468ACE)),
      //                       borderRadius: BorderRadius.all(Radius.circular(10)),
      //                     ),
      //                     child: AllText.text(
      //                       fontsize: 14,
      //                       color: Step2Widget.SelectedModel ==model[i]
      //                           ? Colors.white
      //                           : Color(0xFF468ACE),
      //                       FontWeight: FontWeight.w500,
      //                       text: model[i],
      //                     ),
      //                   ),
      //                 ),
      //             ],
      //           );
    }

    ;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.ShowStepper) ...{
          HeadStepper(
            activeStep: 1,
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
                text: "Générale info ")
          ],
        ),
      
            AllText.text(
            fontsize: 14,
            color: Colors.grey,
            FontWeight: FontWeight.w400,
            text: "Type de véhicule* "),

        DropDuwnButton(
          list: Constants.carTypes,
          value: widget.ShowStepper ? null : widget.carobject!.category!,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                Step2Widget.selectedType = value;
              });
            }
          },
        ),
       
      

        // Wrap(
        //       alignment: WrapAlignment.center,
        //       spacing: 8,
        //       runSpacing: 8,
        //       children: [
        //         for (int i = 0; i < Constants.carTypes.length; i++)
        //           GestureDetector(
        //             onTap: () {
        //               setState(() {
        //                 Step2Widget.selectedType = Constants.carTypes[i];
        //               });
        //             },
        //             child: Container(
        //               padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        //               decoration: BoxDecoration(
        //                 color: Step2Widget.selectedType ==Constants.carTypes[i]
        //                     ? Colors.blue
        //                     : Colors.white,
        //                 border: Border.all(color: Color(0xFF468ACE)),
        //                 borderRadius: BorderRadius.all(Radius.circular(10)),
        //               ),
        //               child: AllText.text(
        //                 fontsize: 14,
        //                 color: Step2Widget.selectedType ==Constants.carTypes[i]
        //                     ? Colors.white
        //                     : Color(0xFF468ACE),
        //                 FontWeight: FontWeight.w500,
        //                 text: Constants.carTypes[i],
        //               ),
        //             ),
        //           ),
        //       ],
        //     ),
        SizedBox(
          height: 8,
        ),
        AllText.text(
            fontsize: 14,
            color: Colors.grey,
            FontWeight: FontWeight.w400,
            text: "Date première fabrication* "),
        GestureDetector(
          onTap: () {
            _selectDate(context);
          },
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xFF16005A)),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AllText.text(
                      fontsize: 14,
                      color: Colors.grey,
                      FontWeight: FontWeight.w400,
                      text: StepsWidgetState.dateTime == null
                          ? "Quand?"
                          : DateFormat('dd/MM/yyyy')
                              .format(StepsWidgetState.dateTime!))
                ],
              )),
        ),
        SizedBox(
          height: 8,
        ),
          if(widget.ShowStepper ) ...{
AllText.text(
            fontsize: 14,
            color: Colors.grey,
            FontWeight: FontWeight.w400,
            text: "Marque de véhicule* "),
        DropDuwnButton(
          list: Constants.carBrands,
          value: widget.ShowStepper ? null : widget.carobject!.brand,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                Step2Widget.selectedBrand = value;
              });
            }
          },
        ),

          },
        
        //   Wrap(
        //   alignment: WrapAlignment.center,
        //   spacing: 8,
        //   runSpacing: 8,
        //   children: [
        //     for (int i = 0; i < Constants.carBrands.length; i++)
        //       GestureDetector(
        //         onTap: () {
        //           setState(() {
        //             Step2Widget.selectedBrand = Constants.carBrands[i];
        //           });
        //         },
        //         child: Container(
        //           padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        //           decoration: BoxDecoration(
        //             color: Step2Widget.selectedBrand ==Constants.carBrands[i]
        //                 ? Colors.blue
        //                 : Colors.white,
        //             border: Border.all(color: Color(0xFF468ACE)),
        //             borderRadius: BorderRadius.all(Radius.circular(10)),
        //           ),
        //           child: AllText.text(
        //             fontsize: 14,
        //             color: Step2Widget.selectedBrand ==Constants.carBrands[i]
        //                 ? Colors.white
        //                 : Color(0xFF468ACE),
        //             FontWeight: FontWeight.w500,
        //             text: Constants.carBrands[i],
        //           ),
        //         ),
        //       ),
        //   ],
        // ),
        // Container(
        //   width: double.infinity,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(8),
        //     border: Border.all(color: Color(0xFF16005A)),
        //   ),
        //   child: Input(
        //     controller: widget.marque,
        //     hint: 'Ajouter la marque de véhicule',
        //   ),
        // ),
        SizedBox(
          height: 8,
        ),
          if(widget.ShowStepper ) ...{
        AllText.text(
            fontsize: 14,
            color: Colors.grey,
            FontWeight: FontWeight.w400,
            text: "Model* "),

        GetModel(),
          },
        // Container(
        //   width: double.infinity,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(8),
        //     border: Border.all(color: Color(0xFF16005A)),
        //   ),
        //   child: Input(
        //     controller: widget.model,
        //     hint: 'Ajouter le model de votre voiture ici',
        //   ),
        // ),
        AllText.text(
            fontsize: 14,
            color: Colors.grey,
            FontWeight: FontWeight.w400,
            text: "Min* "),

        DropDuwnButton(
          // value: widget.carobject,
          list: List.generate(6, (index) => (index + 1).toString()),
          value: widget.ShowStepper ? null : widget.carobject!.min!.toString(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                Step2Widget.Min = value;
              });
            }
          },
        ),
        AllText.text(
            fontsize: 14,
            color: Colors.grey,
            FontWeight: FontWeight.w400,
            text: "Max* "),
        // Container(
        //   width: double.infinity,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(8),
        //     border: Border.all(color: Color(0xFF16005A)),
        //   ),
        //   child: Input(
        //     controller: widget.typeVehicule,
        //     hint: 'Ajouter le type de véhicule',
        //   ),
        // ),

        DropDuwnButton(
          list: List.generate(54, (index) => (7 + index).toString()),
          value: widget.ShowStepper ? null : widget.carobject!.max!.toString(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                Step2Widget.Max = value;
              });
            }
          },
        ),
        SizedBox(
          height: 8,
        ),
        AllText.text(
            fontsize: 14,
            color: Colors.grey,
            FontWeight: FontWeight.w400,
            text: "Plaque Immatriculation*"),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFF16005A)),
          ),
          child: Input(
            controller: widget.matricule,
            hint: 'Ajouter la plaque d\'immatriculation',
          ),
        ),
        AuthButtons(
          onTap: () async {
            // activeStep = 1 ;
            if (Step2Widget.SelectedModel != "" &&
                Step2Widget.selectedType != "" &&
                Step2Widget.selectedBrand != "" &&
                widget.matricule.text != "") {
              if ((widget.ShowStepper == false)) {
                if (widget.carobject!.status == "CREATED" ||
                    widget.carobject!.status == "UPDATED" ||
                    widget.carobject!.status == "FREE") {
                  final response = await ApiMethode.RequestMethode(
                    endPoint: "http://10.0.2.2:8080/cars/update/" + widget.car,
                    body: {
                      // "pricePerHour": int.parse(CounterInputState.currentValue.toString()),
                      "dateFirstFabrication": StepsWidgetState.dateTime.year,
                      "model": Step2Widget.SelectedModel,
                      "licensePlate": widget.matricule.text,
                      "brand": Step2Widget.selectedBrand!,
                      "category": Step2Widget.selectedType,
                      "minDuration": Step2Widget.Min,
                      "maxDuration": Step2Widget.Max,
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
                } else {
                  Allpups.warningPopup(context, 'Modification interdite');
                }
              } else {
                StepsWidgetState.step.emit(Steps3());
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
