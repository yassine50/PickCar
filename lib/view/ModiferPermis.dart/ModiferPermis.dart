import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pickcar/Tools/Constants.dart';
import 'package:pickcar/view/widgets/background/background.dart';
import 'package:pickcar/view/widgets/button/AuthButtns.dart';
import 'package:pickcar/view/widgets/button/DropDownButton.dart';
import 'package:pickcar/view/widgets/text/text.dart';

class ModifierPermis extends StatefulWidget {
  const ModifierPermis({super.key});

  @override
  State<ModifierPermis> createState() => _ModifierPermisState();
}

class _ModifierPermisState extends State<ModifierPermis> {
    static List<XFile> images = [];

  Future<void> pick() async {
    final img = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (img != null) {
     
        images.add(img);
   
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: const ContactAdmin(),

      body: Stack(
        children: [
              Background(url: 'assets/images/backgroundPermis.svg',) , 
     Center(
                child: Container(
                   margin: const EdgeInsets.symmetric(horizontal: 24,),
                   padding: EdgeInsets.symmetric(vertical:12, horizontal: 8),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height*0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: Colors.white
                    ),
                    child: Column(
                      children: [
                      AllText.text(fontsize: 16, color: Colors.black, FontWeight: FontWeight.w400, text: "Scan Permis"),
                      SizedBox(height: 8,),
                      Container(
                        alignment: Alignment.topLeft,
                        child:  AllText.text(fontsize: 16, color: Colors.black, FontWeight: FontWeight.w400, text: "Pays"),
                      ),
                      SizedBox(height: 8,),
                       DropDuwnButton(
              list: Constants.countries,
               onChanged: (value) {
                if(value != null) {
                  setState(() {
                    
                  });
                }
              },
            ),
            SizedBox(height:8),
            GestureDetector(
              onTap: pick,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xFF2576B9))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.file_download_outlined, color: Color(0xFF2576B9),),
                    AllText.text(fontsize: 15, color: Color(0xFF2576B9), FontWeight: FontWeight.w400, text: "Sélection Carte permis recto")
                  ],
                ),),
            ),
                SizedBox(height:8),
                 GestureDetector(
                  onTap: pick,
                   child: Container(
                                 width: double.infinity,
                                 padding: EdgeInsets.symmetric(vertical: 12),
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(8),
                                   border: Border.all(color: Color(0xFF2576B9))
                                 ),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                    Icon(Icons.file_download_outlined, color: Color(0xFF2576B9),),
                    AllText.text(fontsize: 15, color: Color(0xFF2576B9), FontWeight: FontWeight.w400, text: "Sélection Carte permis recto")
                                   ],
                                 ),),
                 ),
              AuthButtons(onTap: () {  }, text: 'Enregistrer',  firstColor: Color(0xFF2576B9),
                        secondColor: Color(0xFF592FAA), width: double.infinity, outlinedButton: false, radius: 4,)

                    ],) ,
                  )
              )
              
             
         
       
        ],
      ),
    );
  }
}