import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:pickcar/DataClass/car.dart';
import 'package:pickcar/DataClass/user.dart';
import 'package:pickcar/view/DetailPageMesVoiture/DetailPageMesVoiture.dart';
import 'package:pickcar/view/MesVoiture/bloc/bloc/mes_voiture_bloc.dart';
import 'package:pickcar/view/widgets/Filtre/flitre.dart';
import 'package:pickcar/view/widgets/card/MesVoitureCard.dart';
import 'package:pickcar/view/widgets/card/MesVoitureProp.dart';
import 'package:pickcar/view/widgets/shimmer/shimmer.dart';
import 'package:pickcar/view/widgets/text/text.dart';

class MesVoiture extends StatelessWidget {
  final User user;
  static MesVoitureBloc MesVoitureController = MesVoitureBloc();
  const MesVoiture({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Filtre(
                user: user,
                MesVoiture: true,
                open: false,
              ),
              BlocBuilder<MesVoitureBloc, MesVoitureState>(
                  bloc: MesVoitureController,
                  builder: (context, state) {
                    if (state is MesVoitureInitial) {
                       MesVoitureController.add(getCars(user: user));
                      return Expanded(
                          child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Shimmers(
                            widgts: MesVoitureCard(),
                          );
                        },
                      ));
                    } else if (state is DataLoaded) {
                     
                      if (state.cars.isNotEmpty) {
                        return Expanded(
                            child: ListView.builder(
                          itemCount: state.cars.length,
                          itemBuilder: (context, index) {
                            print(state.cars.length);
                            return GestureDetector(
                                onTap: () {
                                                          Navigator.push(
                                     context,
                                     MaterialPageRoute(builder: (context) =>  DetailPageMesVoiture(car: state.cars[index],user: user,)),
                                   );
                                },
                                child: MesVoitureProp(car: state.cars[index]
                                  
                                 
                                ));
                          },
                        ));
                      } else {
                       //   MesVoitureController.add(getCars(user: user));
                        return Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 12),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xFF75A68D)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.info_outline,
                                      color: Color(0xFF75A68D),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    AllText.text(
                                        fontsize: 14,
                                        color: Color(0xFF75A68D),
                                        FontWeight: FontWeight.w700,
                                        text: "Aucun voiture")
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Card(
                                elevation: 12,
                                surfaceTintColor: Colors.white,
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 24, horizontal: 24),
                                    child: AllText.text(
                                        fontsize: 16,
                                        color: Colors.black,
                                        FontWeight: FontWeight.w400,
                                        text:
                                            "Pour soumettre votre première voiture, cliquez sur le bouton ci-dessous")),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              GestureDetector(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 16),
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF2576B9),
                                          Color(0xFF592FAA)
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AllText.text(
                                          fontsize: 16,
                                          color: Colors.white,
                                          FontWeight: FontWeight.w500,
                                          text: "Première voiture"),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Icon(Icons.add_circle_outline,
                                          color: Colors.white)
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 24),
                                width: MediaQuery.sizeOf(context).width,
                                child: SvgPicture.asset(
                                  "assets/images/noLocation.svg",
                                  fit: BoxFit.cover,
                                ),
                              )
                            ],
                          ),
                        );
                      }
                    }
                    return Container();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
