import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:pickcar/view/widgets/text/text.dart';

class HeadStepper extends StatelessWidget {
  final  int activeStep ; 
  const HeadStepper({super.key, required this.activeStep});

  @override
  Widget build(BuildContext context) {
    return EasyStepper(
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
     
    );
  }
}