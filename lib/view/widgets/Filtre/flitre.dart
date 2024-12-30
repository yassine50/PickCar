import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pickcar/DataClass/address.dart';
import 'package:pickcar/DataClass/user.dart';
import 'package:pickcar/view/Home/Map.dart';
import 'package:pickcar/view/Home/bloc/MapBloc/bloc/maps_blocc_bloc.dart';
import 'package:pickcar/view/Steps/Steps.dart';
import 'package:pickcar/view/widgets/Filtre/BoiteVitesse/BoiteVitesse.dart';
import 'package:pickcar/view/widgets/Filtre/Moteur/Moteur.dart';
import 'package:pickcar/view/widgets/Filtre/Marque/Marque.dart';
import 'package:pickcar/view/widgets/Filtre/Price/Price.dart';
import 'package:pickcar/view/widgets/Filtre/TypeCar/TypeCar.dart';
import 'package:pickcar/view/widgets/Filtre/Ville/Ville.dart';
import 'package:pickcar/view/widgets/Filtre/bloc/bloc/filter_bloc_bloc.dart';
import 'package:pickcar/view/widgets/Filtre/selectdateWidget.dart/Selectdate.dart';
import 'package:pickcar/view/widgets/bottomSheet/AllButtomSheet.dart';
import 'package:pickcar/view/widgets/form/SelectDate.dart';
import 'package:pickcar/view/widgets/form/search.dart';
import 'package:pickcar/view/widgets/text/text.dart';

class Filtre extends StatefulWidget {
  final User user;
  bool open;
  final bool MesVoiture;
  final bool MesDemmande;
  final bool MesLocation;
 static   Address addressSelected =Address() ;
    static FilterBlocBloc filtreBloc = FilterBlocBloc();
  Filtre({super.key, required this.open, this.MesVoiture = false, required this.user,  this.MesDemmande = false,  this.MesLocation = false});

  @override
  State<Filtre> createState() => FiltreState();
}

class FiltreState extends State<Filtre> {
  static DateTime? StartDate ;
  static DateTime? DueDate;
  static TimeOfDay? StartTime;
  static TimeOfDay? DueTime;

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: selectedDate= ?? DateTime.now(),
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2025),
  //   );
  //   if (picked != null && picked != selectedDate) {
  //     setState(() {
  //       selectedDate = picked;
  //     });
  //   }
  // }

  static  TextEditingController search = TextEditingController();
  static Address SelectedAdres = Address() ; 
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBlocBloc, FilterBlocState>(
          bloc: Filtre.filtreBloc,
          builder: (context, state) {
            if (state is FilterBlocInitial) {
              return   Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (widget.open) ...{
              const SizedBox(width: 8),
              Expanded(
                child: Search(
                  onChange: true,
                  controller: search,
                  hint: 'Local selection......',
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // _selectDate(context);
                    AllBottomSheet.FunBottomSheet(
                        context, SelectDateBottomSheet());
                  },
                  child: SelectDate(date: StartDate),
                ),
              ),
              SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  setState(() {
                    widget.open = !widget.open;
                  });
                },
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF2576B9),
                        Color(0xFF592FAA),
                      ],
                    ),
                  ),
                  child: Icon(
                    Icons.close,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            } else ...{
              if (widget.MesVoiture) ...{
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Steps(user: widget.user,)),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF2576B9), Color(0xFF592FAA)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AllText.text(
                            fontsize: 10,
                            color: Colors.white,
                            FontWeight: FontWeight.w500,
                            text: "Première voiture"),
                        SizedBox(
                          width: 8,
                        ),
                        Icon(Icons.add_circle_outline, color: Colors.white)
                      ],
                    ),
                  ),
                ),
              } else ...{
                Container(
                  height: 32,
                  width: 32,
                ),
              },
              GestureDetector(
                onTap: () {
                  setState(() {
                    widget.open = !widget.open;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 32,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF2576B9),
                        Color(0xFF592FAA),
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/images/setting.svg",
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 8),
                      AllText.text(
                        fontsize: 10,
                        color: Colors.white,
                        FontWeight: FontWeight.w400,
                        text: "Filtre",
                      ),
                    ],
                  ),
                ),
              ),
            }
          ],
        ),
     
        if (widget.open && widget.MesDemmande ==false && widget
        .MesLocation == false) ...{
          SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    AllBottomSheet.FunBottomSheet(context, Marque(user: widget.user,));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF3675B2)),
                      color: Color(0xFF3675B2).withOpacity(0.15),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: AllText.text(
                      fontsize: 12,
                      color: Color(0xFF3675B2),
                      FontWeight: FontWeight.w400,
                      text: "Marque voiture",
                    ),
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    AllBottomSheet.FunBottomSheet(context, Equipment(user: widget.user,));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF3675B2)),
                      
                       color: Color(0xFF3675B2).withOpacity(0.15),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: AllText.text(
                      fontsize: 12,
                      color: Color(0xFF3675B2),
                      FontWeight: FontWeight.w400,
                      text: "Moteurs",
                    ),
                  ),
                ),
                SizedBox(width: 8),
                
                GestureDetector(
                  onTap: () {
                    AllBottomSheet.FunBottomSheet(context, TypeCar(user: widget.user,));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF3675B2)),
                      color: Color(0xFF3675B2).withOpacity(0.15),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: AllText.text(
                      fontsize: 12,
                      color: Color(0xFF3675B2),
                      FontWeight: FontWeight.w400,
                      text: "Type de véhicule",
                    ),
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    AllBottomSheet.FunBottomSheet(context, Boitevitesse(user: widget.user,));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF3675B2)),
                       color: Color(0xFF3675B2).withOpacity(0.15),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: AllText.text(
                      fontsize: 12,
                      color: Color(0xFF3675B2),
                      FontWeight: FontWeight.w400,
                      text: "Boite vitesse",
                    ),
                  ),
                ),
                SizedBox(width: 8),
               
              ],
            ),
          ),
        },
      ],
    );
            }else if(state is DataLoaded) {
              
              return  Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (widget.open) ...{
              const SizedBox(width: 8),
              Expanded(
                child: Search(
                  onChange: true,
                  controller: search,
                  hint: 'Local selection......',
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // _selectDate(context);
                    AllBottomSheet.FunBottomSheet(
                        context, SelectDateBottomSheet());
                  },
                  child: SelectDate(date: StartDate),
                ),
              ),
              SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  setState(() {
                    widget.open = !widget.open;
                  });
                },
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF2576B9),
                        Color(0xFF592FAA),
                      ],
                    ),
                  ),
                  child: Icon(
                    Icons.close,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            } else ...{
              if (widget.MesVoiture) ...{
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Steps(user: widget.user,)),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF2576B9), Color(0xFF592FAA)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AllText.text(
                            fontsize: 10,
                            color: Colors.white,
                            FontWeight: FontWeight.w500,
                            text: "Première voiture"),
                        SizedBox(
                          width: 8,
                        ),
                        Icon(Icons.add_circle_outline, color: Colors.white)
                      ],
                    ),
                  ),
                ),
              } else ...{
                Container(
                  height: 32,
                  width: 32,
                ),
              },
              GestureDetector(
                onTap: () {
                  setState(() {
                    widget.open = !widget.open;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 32,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF2576B9),
                        Color(0xFF592FAA),
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/images/setting.svg",
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 8),
                      AllText.text(
                        fontsize: 10,
                        color: Colors.white,
                        FontWeight: FontWeight.w400,
                        text: "Filtre",
                      ),
                    ],
                  ),
                ),
              ),
            }
          ],
        ),
           SizedBox(height: 8,) , 
        for (int i = 0; i < state.adress.length; i++) ...{
          GestureDetector(
              onTap: () {
                setState(() {
                 search.text = state.adress[i].country!;
                 Filtre.addressSelected = state.adress[i];
                 Filtre.filtreBloc.emit(FilterBlocInitial()) ; 
                 SelectedAdres= state.adress[i] ; 
                 Mapss.mapBloc.add(getCars(state.adress[i],widget.user));
                });
              },
              child: Text(
               state.adress[i].country!,
                style: TextStyle(color: Colors.black),
              )),
          SizedBox(
            height: 8,
          ),
        },
        if (widget.open && widget.MesDemmande ==false && widget
        .MesLocation == false) ...{
          SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    AllBottomSheet.FunBottomSheet(context, Marque(user: widget.user,));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF3675B2)),
                      color: Color(0xFF3675B2).withOpacity(0.15),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: AllText.text(
                      fontsize: 12,
                      color: Color(0xFF3675B2),
                      FontWeight: FontWeight.w400,
                      text: "Marque voiture",
                    ),
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    AllBottomSheet.FunBottomSheet(context, Equipment(user: widget.user,));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF3675B2)),
                      
                       color: Color(0xFF3675B2).withOpacity(0.15),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: AllText.text(
                      fontsize: 12,
                      color: Color(0xFF3675B2),
                      FontWeight: FontWeight.w400,
                      text: "Moteurs",
                    ),
                  ),
                ),
                SizedBox(width: 8),
                
                GestureDetector(
                  onTap: () {
                    AllBottomSheet.FunBottomSheet(context, TypeCar(user: widget.user,));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF3675B2)),
                      color: Color(0xFF3675B2).withOpacity(0.15),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: AllText.text(
                      fontsize: 12,
                      color: Color(0xFF3675B2),
                      FontWeight: FontWeight.w400,
                      text: "Type de véhicule",
                    ),
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    AllBottomSheet.FunBottomSheet(context, Boitevitesse(user: widget.user,));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF3675B2)),
                       color: Color(0xFF3675B2).withOpacity(0.15),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: AllText.text(
                      fontsize: 12,
                      color: Color(0xFF3675B2),
                      FontWeight: FontWeight.w400,
                      text: "Boite vitesse",
                    ),
                  ),
                ),
                SizedBox(width: 8),
                
              ],
            ),
          ),
        },
      ],
    );
             
            }
            // Handle other states of the BLoC
            return Container();
          },
        );
   
  }
}
