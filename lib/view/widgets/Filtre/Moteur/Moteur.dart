import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pickcar/DataClass/user.dart';
import 'package:pickcar/Tools/ApiMethode.dart';
import 'package:pickcar/Tools/Constants.dart';
import 'package:pickcar/view/Home/Map.dart';
import 'package:pickcar/view/Home/bloc/MapBloc/bloc/maps_blocc_bloc.dart';
import 'package:pickcar/view/widgets/Filtre/flitre.dart';
import 'package:pickcar/view/widgets/button/AuthButtns.dart';
import 'package:pickcar/view/widgets/text/text.dart';

class Equipment extends StatefulWidget {
  final User user;
  const Equipment({super.key, required this.user});

  @override
  State<Equipment> createState() => MoteurState();
}

class MoteurState extends State<Equipment> {
 static  List<String> selectedMoteur = [];
  List<String> engine = [] ; 
   getData() async {
    final response = await ApiMethode.RequestMethode(
      endPoint: "http://10.0.2.2:8080/cars/properties",
      body: {},
      jwt:widget.user.jwtToken!,
      para: "property=engines",
      type: "GET",
    );
 if (response != "") {
  Map<String, dynamic> userMap = json.decode(response);
  setState(() {
    engine = (userMap["engines"] as List<dynamic>).map((e) => e as String).toList();
  });
} else {}}
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
    getData() ;
    });
    super.initState();
  }

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
                text: "Moteurs"),
            SizedBox(
              height: 16,
            ),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: [
                for (int i = 0; i < engine .length; i++)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (selectedMoteur.contains(engine[i])) {
                          selectedMoteur.remove(engine[i]);
                        } else {
                          selectedMoteur.add(engine[i]);
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      decoration: BoxDecoration(
                        color: selectedMoteur.contains(engine[i])
                            ? Colors.blue
                            : Colors.white,
                        border: Border.all(color: Color(0xFF468ACE)),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: AllText.text(
                        fontsize: 14,
                        color: selectedMoteur.contains(engine[i])
                            ? Colors.white
                            : Color(0xFF468ACE),
                        FontWeight: FontWeight.w500,
                        text: engine[i],
                      ),
                    ),
                  ),
              ],
            ),
             AuthButtons(onTap: () {
                Mapss.mapBloc.add(getCars(Filtre.addressSelected, widget.user)) ;
                                      Navigator.pop(context) ; 
             }, text: "Enregistrer", width: double.infinity, outlinedButton: false, firstColor: Color(0xFF5AB58B), secondColor: Color(0xFFC4E4D3)),
             SizedBox(
              height: 16,
            ),
          ],
        ),
      
    );
  }
}
