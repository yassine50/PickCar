import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pickcar/DataClass/user.dart';
import 'package:pickcar/Tools/ApiMethode.dart';
import 'package:pickcar/Tools/Constants.dart';
import 'package:pickcar/view/ModiferPermis.dart/ModiferPermis.dart';
import 'package:pickcar/view/profile/Bloc/bloc/profile_bloc_bloc.dart';
import 'package:pickcar/view/profile/profile.dart';
import 'package:pickcar/view/widgets/ImageProfile/ImageProfile.dart';
import 'package:pickcar/view/widgets/button/Backbutton.dart';
import 'package:pickcar/view/widgets/button/DropDownButton.dart';
import 'package:pickcar/view/widgets/button/Editbutton.dart';
import 'package:pickcar/view/widgets/button/logout.dart';
import 'package:pickcar/view/widgets/form/ProfileInput.dart';
import 'package:pickcar/view/widgets/text/text.dart';

class Permis extends StatefulWidget {
  final User user;
  final bool hasPermit;

  const Permis({super.key, required this.hasPermit, required this.user});
  

  @override
  State<Permis> createState() => _PermisState();
}

class _PermisState extends State<Permis> {


   Future<void> pick( int i) async {
    final img = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (img != null) {
      
      // the call to the backend 
    final response = await ApiMethode.RequestBodyWithHeader(
      jwt:widget.user.jwtToken! ,
      file: img,
      fileFieldName: "files",
      fileName: widget.user.userIdentifier.toString()+"__"+i.toString()+".png",
      endPoint: "http://10.0.2.2:8080/upload",
      body: { 
      },
      type: "POST",
    );
    if (response != "") {
       setState(() {
      widget.user.userIdentifier ;
    });
      } else {
    }
   
    }
  }
   
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Backbutton(
                ontap: () {
                  Profile.ProfileController.emit(ProfileBlocInitial());
                },
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [Logout()],
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
           ImageProfile(user: widget.user),
          const SizedBox(
            height: 24,
          ),
          if (widget.hasPermit) ...{
           
            SizedBox(
              height: 4,
            ),
           
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
  onTap: () {
    pick(0);
  },
  child: Container(
    height: 100,
    width: MediaQuery.sizeOf(context).width * 0.4,
    padding: EdgeInsets.all(4),
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 3,
          offset: Offset(0, 1), // changes position of shadow
        ),
      ],
      color: Colors.white,
      // border: Border.all(color: Colors.grey),
      // borderRadius: BorderRadius.all(Radius.circular(15)),
    ),
    child: Stack(
      children: [
        Center(
          child: Icon(Icons.person, size: 60, color: Colors.blue.shade800),
        ), Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'http://10.0.2.2:8080/uploads/' +
                    widget.user.userIdentifier! +
                    '__0.png?v=${DateTime.now().millisecondsSinceEpoch}',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    ),
  ),
),

               GestureDetector(
  onTap: () {
    pick(1);
  },
  child: Container(
    height: 100,
    width: MediaQuery.sizeOf(context).width * 0.4,
    padding: EdgeInsets.all(4),
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 3,
          offset: Offset(0, 1), // changes position of shadow
        ),
      ],
      color: Colors.white,
      // border: Border.all(color: Colors.grey),
      // borderRadius: BorderRadius.all(Radius.circular(15)),
    ),
    child: Stack(
      children: [
        Center(
          child: Icon(Icons.person, size: 60, color: Colors.blue.shade800),
        ), Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'http://10.0.2.2:8080/uploads/' +
                    widget.user.userIdentifier! +
                    '__1.png?v=${DateTime.now().millisecondsSinceEpoch}',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    ),
  ),
),

                
              ],
            ),
            SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () {
                                  Profile.ProfileController.emit(ProfileBlocInitial());
              },
              child:  Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color(0xFF2576B9),
                  border: Border.all(color: Color(0xFF2576B9)),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AllText.text(
                      fontsize: 14,
                      color: Colors.white,
                      FontWeight: FontWeight.w400,
                      text: "Enregistrer"),
                ],
              ),
            )
            ,), 
           
          }
        ],
      ),
    );
  }
}
