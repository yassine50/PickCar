import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pickcar/DataClass/address.dart';
import 'package:pickcar/DataClass/user.dart';
import 'package:pickcar/Tools/Constants.dart';
import 'package:pickcar/view/Steps/bloc/bloc/steps_bloc.dart';
import 'package:pickcar/view/Steps/widget/Step1.dart';
import 'package:pickcar/view/Steps/widget/Step2.dart';
import 'package:pickcar/view/Steps/widget/Step3.dart';
import 'package:pickcar/view/Steps/widget/Step4.dart';
import 'package:pickcar/view/Steps/widget/Step5.dart';
import 'package:pickcar/view/Steps/widget/Step6.dart';
import 'package:pickcar/view/widgets/CounterInput/CounterInput.dart';
import 'package:pickcar/view/widgets/button/AuthButtns.dart';
import 'package:pickcar/view/widgets/form/input.dart';
import 'package:pickcar/view/widgets/text/text.dart';

class Steps extends StatefulWidget {
  final User user;
  const Steps({super.key, required this.user});

  @override
  State<Steps> createState() => StepsWidgetState();
}

class StepsWidgetState extends State<Steps> {
  int activeStep = 0;
  static StepsBloc step = StepsBloc();
  static TextEditingController matricule = TextEditingController();
  static TextEditingController boite = TextEditingController();
  static TextEditingController moteur = TextEditingController();
  static TextEditingController kilometrage = TextEditingController();
 static TextEditingController porte = TextEditingController();
  static TextEditingController place = TextEditingController();
  static TextEditingController restriction= TextEditingController();
  static TextEditingController plusInfo = TextEditingController();
  static TextEditingController city = TextEditingController();
  static TextEditingController country = TextEditingController();
  static TextEditingController zipCode = TextEditingController();
  static TextEditingController street = TextEditingController();
static  List<String> equipment = [];

 static  bool acc = false;
static Address addressSelected = Address();
  static DateTime dateTime = DateTime.now();

@override
  void initState() {
    // TODO: implement initState
    super.initState();
 CounterInputState.currentValue =0 ; 
  matricule = TextEditingController();
 boite = TextEditingController();
  moteur = TextEditingController();
 kilometrage = TextEditingController();
 porte = TextEditingController();
  place = TextEditingController();
 restriction= TextEditingController();
  plusInfo = TextEditingController();
   city = TextEditingController();
  country = TextEditingController();
   zipCode = TextEditingController();
   street = TextEditingController();
 equipment = [];

acc = false;
  addressSelected = Address();
  dateTime = DateTime.now();

  }

  @override
  Widget build(BuildContext context) {
    step.emit(StepsInitial()); 
    Widget stepsWidget = EasyStepper(
      steppingEnabled: false,
      activeStep: activeStep,
      // lineLength: 50,
      stepShape: StepShape.circle,
      // stepBorderRadius: 15,
      // borderThickness: 2,
      // padding: EdgeInsets.all(20),
      stepRadius: 16,
      finishedStepBorderColor: Color(0xFF2576B9),
      finishedStepTextColor: Color(0xFF2576B9),
      finishedStepBackgroundColor: Color(0xFF2576B9),
      activeStepIconColor: Color(0xFF2576B9),
      activeStepBackgroundColor: Color(0xFF2576B9),
      showLoadingAnimation: false,
      steps: [
        EasyStep(
          customStep: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: AllText.text(
                fontsize: 12,
                color: activeStep >= 0 ? Colors.white : Colors.grey,
                FontWeight: FontWeight.w400,
                text: "1"),
          ),
          customTitle: const Text(
            'étape 01',
            textAlign: TextAlign.center,
          ),
        ),
        EasyStep(
          customStep: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: AllText.text(
                fontsize: 12,
                color: activeStep >= 1 ? Colors.white : Colors.grey,
                FontWeight: FontWeight.w400,
                text: "2"),
          ),
          customTitle: const Text(
            'étape 02',
            textAlign: TextAlign.center,
          ),
        ),
        EasyStep(
          customStep: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: AllText.text(
                fontsize: 12,
                color: activeStep >= 2 ? Colors.white : Colors.grey,
                FontWeight: FontWeight.w400,
                text: "3"),
          ),
          customTitle: const Text(
            'étape 03',
            textAlign: TextAlign.center,
          ),
        ),
        EasyStep(
          customStep: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: AllText.text(
                fontsize: 12,
                color: activeStep >= 3 ? Colors.white : Colors.grey,
                FontWeight: FontWeight.w400,
                text: "4"),
          ),
          customTitle: const Text(
            'étape 04',
            textAlign: TextAlign.center,
          ),
        ),
        EasyStep(
          customStep: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: AllText.text(
                fontsize: 12,
                color: activeStep >= 4 ? Colors.white : Colors.grey,
                FontWeight: FontWeight.w400,
                text: "5"),
          ),
          customTitle: const Text(
            'étape 05',
            textAlign: TextAlign.center,
          ),
        ),
        EasyStep(
          customStep: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: AllText.text(
                fontsize: 12,
                color: activeStep >= 5 ? Colors.white : Colors.grey,
                FontWeight: FontWeight.w400,
                text: "6"),
          ),
          customTitle: const Text(
            'étape 06',
            textAlign: TextAlign.center,
          ),
        ),
      ],
      onStepReached: (index) => setState(() => activeStep = index),
    );

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<StepsBloc, StepsState>(
                    bloc: step,
                    builder: (context, state) {
                      if (state is StepsInitial) {
                        return  Step1Widget(country: country,City: city,street: street,zipCode: zipCode, user: widget.user, ) ; 
                      } else if (state is Steps2) {
                        return Step2Widget(matricule: matricule,user: widget.user,ShowStepper: true,);
                      } else if (state is Steps3) {

                        return Step3Widget( boite: boite, moteur: moteur, kilometrage: kilometrage, porte: porte, place: place,user: widget.user,) ;
                      } else if (state is Steps4) {
                        return Step4Widget(user: widget.user,) ; 
                      } else if (state is Steps5) {
                        return Step5Widget(plusInfo: plusInfo, restriction: restriction,user: widget.user,); 
                      } else if (state is Steps6) {
                        return Step6Widget(user: widget.user);
                      }
                      return Container();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
