import 'package:flutter/material.dart';
import 'package:pickcar/view/widgets/button/AuthButtns.dart';
import 'package:pickcar/view/widgets/text/text.dart';

class Price extends StatefulWidget {
  const Price({super.key});

  @override
  State<Price> createState() => PriceState();
}

class PriceState extends State<Price> {
  static  RangeValues currentRangeValues = const RangeValues(50, 300);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child:  Column(
          children: [
            SizedBox(
              height: 10,
            ),
            AllText.text(
                fontsize: 16,
                color: Colors.black,
                FontWeight: FontWeight.w500,
                text: "Prix par heure"),
            SizedBox(
              height: MediaQuery.sizeOf(context).height*0.1,
            ),
           RangeSlider(
            activeColor: Color(0xFF8639FF),
      values: currentRangeValues,
      max: 300,
      divisions: 10,
      labels: RangeLabels(
        currentRangeValues.start.round().toString(),
        currentRangeValues.end.round().toString(),
      ),
      onChanged: (RangeValues values) {
        setState(() {
          currentRangeValues = values;
        });
      },
    ),
     SizedBox(
              height: 24,
            ),

    AuthButtons(onTap: () {}, text: "Enregistrer", width: double.infinity, outlinedButton: false, firstColor: Color(0xFF5AB58B), secondColor: Color(0xFFC4E4D3))
          ],
        ),
      
    );
  }
}