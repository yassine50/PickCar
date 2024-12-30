import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:pickcar/DataClass/address.dart';
import 'package:pickcar/DataClass/car.dart';
import 'package:pickcar/DataClass/user.dart';
import 'package:pickcar/Tools/ApiMethode.dart';
import 'package:pickcar/view/MesVoiture/MesVoiture.dart';
import 'package:pickcar/view/MesVoiture/bloc/bloc/mes_voiture_bloc.dart';
import 'package:pickcar/view/Steps/widget/Step1.dart';
import 'package:pickcar/view/Steps/widget/Step2.dart';
import 'package:pickcar/view/Steps/widget/Step3.dart';
import 'package:pickcar/view/Steps/widget/Step4.dart';
import 'package:pickcar/view/Steps/widget/Step5.dart';
import 'package:pickcar/view/widgets/bottomSheet/AllButtomSheet.dart';
import 'package:pickcar/view/widgets/cashedImage/cashedImage.dart';
import 'package:pickcar/view/widgets/popups/Allpop.dart';
import 'package:pickcar/view/widgets/text/text.dart';

class DetailPageMesVoiture extends StatefulWidget {
  final User user;
  final Car car;
  const DetailPageMesVoiture(
      {super.key, required this.car, required this.user});

  @override
  State<DetailPageMesVoiture> createState() => DetailPageMesVoitureState();
}

class DetailPageMesVoitureState extends State<DetailPageMesVoiture> {
  static TextEditingController typeVehicule = TextEditingController();
  static TextEditingController model = TextEditingController();
  static TextEditingController matricule = TextEditingController();
  static TextEditingController boite = TextEditingController();
  static TextEditingController moteur = TextEditingController();
  static TextEditingController kilometrage = TextEditingController();
  static TextEditingController porte = TextEditingController();
  static TextEditingController place = TextEditingController();
  static TextEditingController restriction = TextEditingController();
  static TextEditingController plusInfo = TextEditingController();
  static TextEditingController city = TextEditingController();
  static TextEditingController country = TextEditingController();
  static TextEditingController zipCode = TextEditingController();
  static TextEditingController street = TextEditingController();
  static Address addressSelected = Address();
  static String? selectedBrand;
  static String? selectedType;
  static String? SelectedModel;
  bool isAvailable = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.car.status);
    isAvailable = (widget.car.status != 'NOT_FREE'); 
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              //  mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Color(0xFF3A0CA3),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFF2E805D)),
                              color: Color(0xFF2E805D).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            children: [
                              AllText.text(
                                  fontsize: 14,
                                  color: Color(0xFF2E805D),
                                  FontWeight: FontWeight.w400,
                                  text: "Disponible"),
                              SizedBox(
                                width: 8,
                              ),
                              Container(
                                child: Switch(
                                  value: isAvailable,
                                  onChanged: (value) async {
                                    Allpups.loading(context);
                                    final response =
                                        await ApiMethode.RequestMethode(
                                      endPoint:
                                          "http://10.0.2.2:8080/cars/availability/update",
                                      body: {},
                                      jwt: widget.user.jwtToken!,
                                      para: 'carIdentifier=' +
                                          widget.car.carId.toString() +
                                          "&status=" +
                                          (value == false
                                              ? 'NOT_FREE'
                                              : 'FREE'),
                                      type: "PATCH",
                                    );
                                    MesVoiture.MesVoitureController.emit(MesVoitureInitial()) ;
                                    Navigator.pop(context);
                                    setState(() {
                                      isAvailable = value;
                                    });
                                  },
                                  activeColor: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          onTap: () async {
                            Allpups.loading(context);
                            final response = await ApiMethode.RequestMethode(
                              endPoint: "http://10.0.2.2:8080/cars/" +
                                  widget.car.carId.toString(),
                              body: {},
                              jwt: widget.user.jwtToken!,
                              type: "DELETE",
                            );
                            MesVoiture.MesVoitureController.emit(
                                MesVoitureInitial());
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 12),
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFF44336)),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)),
                            child: Icon(
                              Icons.delete,
                              color: Color(0xFFF44336),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        child: CachedImage(
                          img: 'http://10.0.2.2:8080/uploads/' +
                              widget.car!.carId!.toString() +
                              '__0.png' +
                              '?v=${DateTime.now().millisecondsSinceEpoch}',
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AllText.text(
                                fontsize: 16,
                                color: Colors.black,
                                FontWeight: FontWeight.w500,
                                text: widget.car.brand.toString()),
                            GestureDetector(
                              onTap: () {
                                AllBottomSheet.FunBottomSheet(
                                    context,
                                    Step1Widget(
                                      carobject: widget.car,
                                      country: country,
                                      City: city,
                                      street: street,
                                      zipCode: zipCode,
                                      ShowStepper: false,
                                      user: widget.user,
                                      car: widget.car.carId.toString(),
                                    ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    border:
                                        Border.all(color: Color(0xFF3A0CA3))),
                                child: Icon(
                                  Icons.create_rounded,
                                  color: Color(0xFF3A0CA3),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_month),
                            AllText.text(
                                fontsize: 10,
                                color: Colors.black,
                                FontWeight: FontWeight.w500,
                                text: "Date de création: " +
                                    widget.car.dateFirstFabrication.toString())
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              color: Color(0xFF2E805D).withOpacity(0.1),
                              border: Border.all(color: Color(0xFF2E805D))),
                          child: AllText.text(
                              fontsize: 12,
                              color: Color(0xFF2E805D),
                              FontWeight: FontWeight.w400,
                              text: "Prix/heure: " +
                                  widget.car.pricePerHour.toString())),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () {
                    AllBottomSheet.FunBottomSheet(
                        context,
                        Step2Widget(
                          matricule: matricule,
                          ShowStepper: false,
                          user: widget.user,
                          car: widget.car.carId.toString(),
                          carobject: widget.car,
                        ));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AllText.text(
                            fontsize: 16,
                            color: Color(0xFF29057F),
                            FontWeight: FontWeight.w400,
                            text: "Informations de véhicule"),
                        Icon(Icons.arrow_forward)
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () {
                    AllBottomSheet.FunBottomSheet(
                        context,
                        Step3Widget(
                            carobject: widget.car,
                            boite: boite,
                            moteur: moteur,
                            kilometrage: kilometrage,
                            porte: porte,
                            place: place,
                            ShowStepper: false,
                            user: widget.user,
                            car: widget.car.carId.toString()));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AllText.text(
                            fontsize: 16,
                            color: Color(0xFF29057F),
                            FontWeight: FontWeight.w400,
                            text: "Informations Mécanique"),
                        Icon(Icons.arrow_forward)
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () {
                    AllBottomSheet.FunBottomSheet(
                      context,
                      Step4Widget(
                        ShowStepper: false,
                        user: widget.user,
                        carobject: widget.car,
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AllText.text(
                            fontsize: 16,
                            color: Color(0xFF29057F),
                            FontWeight: FontWeight.w400,
                            text: "équipement et les options"),
                        Icon(Icons.arrow_forward)
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () {
                    AllBottomSheet.FunBottomSheet(
                        context,
                        Step5Widget(
                          carobject: widget.car,
                          restriction: restriction,
                          plusInfo: plusInfo,
                          ShowStepper: false,
                          user: widget.user,
                          car: widget.car.carId.toString(),
                        ));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AllText.text(
                            fontsize: 16,
                            color: Color(0xFF29057F),
                            FontWeight: FontWeight.w400,
                            text: "Restriction"),
                        Icon(Icons.arrow_forward)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
