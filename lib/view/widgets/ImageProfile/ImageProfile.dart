import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pickcar/DataClass/user.dart';
import 'package:pickcar/Tools/ApiMethode.dart';
import 'package:pickcar/Tools/Constants.dart';

class ImageProfile extends StatefulWidget {
  final User user ;
  const ImageProfile({super.key, required this.user});

  @override
  State<ImageProfile> createState() => _ImageProfileState();
}

class _ImageProfileState extends State<ImageProfile> {
   Future<void> pick() async {
    final img = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (img != null) {
      
      // the call to the backend 
    final response = await ApiMethode.RequestBodyWithHeader(
      jwt:widget.user.jwtToken! ,
      file: img,
      fileFieldName: "files",
      fileName: widget.user.userIdentifier.toString()+".png",
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
    return      Row(
      children: [
        GestureDetector(
          onTap:pick , 
          child: Stack(
            children: [
             Container(
              height: 89,
              width: 89,
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
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Container(
              padding: EdgeInsets.all(8),
           
              decoration: BoxDecoration(
                   color: Color(0xFFC2C7D0),
             
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: CircleAvatar(
                // radius: 30,
               // backgroundColor: Color(0xFFC2C7D0),
                foregroundImage: NetworkImage('http://10.0.2.2:8080/uploads/'+widget.user.userIdentifier.toString()+'.png'+ '?v=${DateTime.now().millisecondsSinceEpoch}'),
                child: Icon(Icons.person, size: 60, color: Colors.blue.shade800),
              ),
          
             ),
          
             ),
             
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.edit,
                    size: 15,
                    color: Colors.teal,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  
                  widget.user.firstName! +" "+widget.user.lastName!,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.verified_outlined,
                  color: Colors.teal,
                  size: 20,
                ),
              ],
            ),
            Text(
              widget.user.currentMode! == Constants.ModeProprietaire ?" Propriétaire":"Locataire",
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue.shade700,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
