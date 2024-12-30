import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:pickcar/DataClass/user.dart';
import 'package:pickcar/Tools/ApiMethode.dart';
import 'package:pickcar/view/PhoneVerif/PhoneVerif.dart';
import 'package:pickcar/view/profile/Bloc/bloc/profile_bloc_bloc.dart';
import 'package:pickcar/view/profile/profile.dart';
import 'package:pickcar/view/widgets/GoogleNavBar/Navbar.dart';
import 'package:pickcar/view/widgets/ImageProfile/ImageProfile.dart';
import 'package:pickcar/view/widgets/button/Backbutton.dart';
import 'package:pickcar/view/widgets/button/Editbutton.dart';
import 'package:pickcar/view/widgets/button/logout.dart';
import 'package:pickcar/view/widgets/button/saveButton.dart';
import 'package:pickcar/view/widgets/card/ContactAdmin.dart';
import 'package:pickcar/view/widgets/form/ProfileInput.dart';
import 'package:pickcar/view/widgets/text/text.dart';

class InfoPersonel extends StatefulWidget {
  final User user;
  const InfoPersonel({super.key, required this.user});

  @override
  State<InfoPersonel> createState() => _InfoPersonelState();
}

class _InfoPersonelState extends State<InfoPersonel> {
  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1960),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  TextEditingController name = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController adress = TextEditingController();
  TextEditingController phone = TextEditingController();
  bool edit = true;
  @override
  void initState() {
    // TODO: implement initState
    name.text =  widget.user. firstName! +" "+widget. user.lastName!;
   selectedDate =widget.user.dateOfBirth! ; 
   email.text = widget.user.email!;
   adress.text = widget.user.address!.country! + "," + widget.user.address!.city!+","+ widget.user.address!.street!+","+ widget.user.address!.zipCode!;
    phone.text =  widget.user.phone!;
        super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print("heyyy");
    print(widget.user.dateOfBirth);
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
                children: [
                  EditButton(
                    edit: edit,
                    onTap: () {
                      setState(() {
                        edit = !edit;
                      });
                    },
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Logout()
                ],
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
          ProfileInput(
            readOnly: edit,
            controller: name,
            hint: 'Aichoucha Yahyoucha',
            title: 'Nom et Prénom',
            icon: Icons.person,
          ),
          // ProfileInput(
          //   readOnly: edit,
          //   controller: date,
          //   hint: 'Bryan Bryan',
          //   title: 'Date de naissance',
          //   icon: Icons.calendar_month,
          // ),
          GestureDetector(
              onTap: () {
                if (edit == false) {
                     _selectDate(context);
                }
             
              
              },
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: AllText.text(
                        fontsize: 14,
                        color: Colors.black,
                        FontWeight: FontWeight.w400,
                        text: "Date de naissance"),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 12, bottom: 12, left: 12),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Container(
                                alignment: Alignment.topLeft,
                                child: AllText.text(
                                    fontsize: 14,
                                    color: Colors.grey,
                                    FontWeight: FontWeight.w400,
                                    text:DateFormat('yyyy/MM/dd')
                              .format(selectedDate)
                              .toString() ))),
                        Icon(Icons.calendar_month),
                        SizedBox(
                          width: 8,
                        )
                      ],
                    ),
                  ),
                ],
              )),
          ProfileInput(
            readOnly: edit,
            controller: phone,
            hint: 'Téléphone',
            title: 'Téléphone',
            icon: Icons.phone,
          ),
          ProfileInput(
            readOnly: edit,
            controller: adress,
            title: 'Adresse',
            hint: 'City stade mednine 4100',
            icon: Icons.place_outlined,
          ),
          GestureDetector(
              onTap: () {
                if(edit == false) {
                  /*
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PhoneVerif(
                            fromProfile: true,
                            user: User(),
                          )),
                );*/
                }
              
              },
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: AllText.text(
                        fontsize: 14,
                        color: Colors.black,
                        FontWeight: FontWeight.w400,
                        text: 'Email'),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 12, bottom: 12, left: 12),
                    decoration: BoxDecoration(
                        color: Color(0xFF8BCBAE),
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Container(
                                alignment: Alignment.topLeft,
                                child: AllText.text(
                                    fontsize: 14,
                                    color: Colors.black,
                                    FontWeight: FontWeight.w400,
                                    text: email.text))),
                        Icon(Icons.email),
                        SizedBox(
                          width: 8,
                        )
                      ],
                    ),
                  ),
                ],
              )),
          const SizedBox(
            height: 12,
          ),
          if(edit ==  false) ...{
 SaveBButton(
            onTap: () async {
               final response = await ApiMethode.RequestMethode(
      endPoint: "http://10.0.2.2:8080/users/",
      body: {
      //   TextEditingController name = TextEditingController();
 // TextEditingController date = TextEditingController();
  //TextEditingController email = TextEditingController();
 // TextEditingController adress = TextEditingController();
  //TextEditingController phone = TextEditingController();
          "newFirstName": name.text.split(' ')[0],
  "newLastName":name.text.split(' ')[1] ,
  "newBirthDate":    DateFormat('yyyy-MM-dd').format(selectedDate),
 // "newNationality": ,
  //"newCommentRejetVerification": "string",
  "newPhone": phone.text,
 // "newEmail": email.text,
  "newAddress": {
    "newCity":  adress.text.split(',')[1],
    "newCountry": adress.text.split(',')[0],
    "newStreet":  adress.text.split(',')[2],
    "newZipCode":  adress.text.split(',')[3]
  }
      },
      jwt:widget.user.jwtToken!,
      para: "",
      type: "PUT",
    );
    widget.user.firstName =  name.text.split(' ')[0]; 
     widget.user.lastName =  name.text.split(' ')[1]; 
      widget.user.dateOfBirth =  selectedDate;
       widget.user.phone = phone.text; 
        widget.user.address!.country = adress.text.split(',')[0]; 
         widget.user.address!.city = adress.text.split(',')[1]; 
          widget.user.address!.street = adress.text.split(',')[2]; 
           widget.user.address!.zipCode = adress.text.split(',')[3]; 
        

     Navigator.pushReplacement<void, void>(
    context,
    MaterialPageRoute<void>(
      builder: (BuildContext context) => GoogleNavBar(user: widget.user,),
    ),
  );

          // Profile.ProfileController.emit(ProfileBlocInitial()); 
            },
          )
          }
         
        ],
      ),
    );
  }
}
