import 'package:flutter/material.dart';
import 'package:pickcar/Tools/Constants.dart';
import 'package:pickcar/view/widgets/button/AuthButtns.dart';
import 'package:pickcar/view/widgets/text/text.dart';

class ville extends StatefulWidget {
  const ville({super.key});

  @override
  State<ville> createState() => _villeState();
}

class _villeState extends State<ville> {
    List<String> selectedVille = [];
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
                text: "Ville"),
            SizedBox(
              height: 16,
            ),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: [
                for (int i = 0; i < Constants.carBrands.length; i++)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (selectedVille.contains(Constants.carBrands[i])) {
                          selectedVille.remove(Constants.carBrands[i]);
                        } else {
                          selectedVille.add(Constants.carBrands[i]);
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      decoration: BoxDecoration(
                        color: selectedVille.contains(Constants.carBrands[i])
                            ? Colors.blue
                            : Colors.white,
                        border: Border.all(color: Color(0xFF468ACE)),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: AllText.text(
                        fontsize: 14,
                        color: selectedVille.contains(Constants.carBrands[i])
                            ? Colors.white
                            : Color(0xFF468ACE),
                        FontWeight: FontWeight.w500,
                        text: Constants.carBrands[i],
                      ),
                    ),
                  ),
              ],
            ),
             AuthButtons(onTap: () {}, text: "Enregistrer", width: double.infinity, outlinedButton: false, firstColor: Color(0xFF5AB58B), secondColor: Color(0xFFC4E4D3)),
             SizedBox(
              height: 16,
            ),
          ],
        ),
      
    );
  }
}