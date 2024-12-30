import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pickcar/DataClass/user.dart';
import 'package:pickcar/Tools/ApiMethode.dart';
import 'package:pickcar/hive/LocalStorage.dart';
import 'package:pickcar/view/profile/Bloc/bloc/profile_bloc_bloc.dart';
import 'package:pickcar/view/profile/profile.dart';
import 'package:pickcar/view/widgets/GoogleNavBar/Navbar.dart';
import 'package:pickcar/view/widgets/ImageProfile/ImageProfile.dart';
import 'package:pickcar/view/widgets/button/Backbutton.dart';
import 'package:pickcar/view/widgets/button/Editbutton.dart';
import 'package:pickcar/view/widgets/button/logout.dart';
import 'package:pickcar/view/widgets/button/saveButton.dart';
import 'package:pickcar/view/widgets/form/ProfileInput.dart';

class PaymentPage extends StatefulWidget {
  final User user;
  const PaymentPage({super.key, required this.user});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
    TextEditingController titulaire = TextEditingController();
    TextEditingController iban = TextEditingController();
    TextEditingController adress = TextEditingController();
  bool edit = true; 
  
bool update = false ; 
   
  @override
  void initState() {
   // adress.text = widget.user.address!.country! + " " + widget.user.address!.city!+" "+ widget.user.address!.street!+" "+ widget.user.address!.zipCode!;
   
    // TODO: implement initState
    WidgetsBinding.instance
        .addPostFrameCallback((_) async {
 // Simulate a network request
     var user = await LocalStorage.GetUser();
   //  if(user["currentMode"] == Constants.ModeLocataire) {
          var customer = await LocalStorage.GetCustomer();
     final response = await ApiMethode.RequestMethode(
       endPoint: "http://10.0.2.2:8080/bankAccounts/users/"+user["userIdentifier"]+"/details",
       body: {},
       jwt: user['jwt-token'],
       //para: "page=0&sortBy=id&sortDirection=ASC",
       type: "GET",
     );

     if (response != "" ) {
      Map<String, dynamic> result=  json.decode(response); 
      setState(() {
          titulaire.text = result['bankName']!;
            iban.text = result['iban']!;
            if(titulaire.text != '' && iban.text != "") {
              update = true ; 
            }else {
              update = false ; 
            }
      });
      
      
     
       
     } else {

     }

   
        });
    super.initState();
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
                children: [
                  EditButton(
                      edit: edit,
                    onTap: () {
                    setState(() {
                      edit = !edit;
                    });
                  },),
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
                  controller: titulaire,
                  hint: 'Le nom du titulaire du compte',
                  title: 'Titulaire du compte',
                  icon: Icons.person,
                ),
                ProfileInput(
                  readOnly: edit,
                  controller: iban,
                  hint: 'FR7630006000011234567890187',
                  title: 'IBAN',
                  icon: Icons.person,
                ),
    
    
          
          const SizedBox(
            height: 12,
          ),
           if(edit ==  false) ...{
          SaveBButton(
            onTap: () async {
                       final response = await ApiMethode.RequestMethode(
      endPoint: "http://10.0.2.2:8080/bankAccounts/",
      body:  update ?{
  "newBankName": titulaire.text,
  "newIban": iban.text
      }
       : {
          "bankName": titulaire.text,
  "iban": iban.text

  },
      jwt:widget.user.jwtToken!,
      para: "",
      type: update ? "PUT" :"POST",
    );  
    //widget.user. = ; 
   
  
    Profile.ProfileController.emit(ProfileBlocInitial()); 
            },
          ),
           }
        ],
      ),
    );
  }
}