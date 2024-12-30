import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pickcar/DataClass/user.dart';
import 'package:pickcar/view/DetailPage/DetailPage.dart';
import 'package:pickcar/view/MesDemande/bloc/bloc/mes_demande_bloc.dart';
import 'package:pickcar/view/widgets/Filtre/flitre.dart';
import 'package:pickcar/view/widgets/card/MesVoitureCard.dart';
import 'package:pickcar/view/widgets/shimmer/shimmer.dart';
import 'package:pickcar/view/widgets/text/text.dart';

class MesDemande extends StatelessWidget {
  final User user;
   static MesDemandeBloc MesDemandeController = MesDemandeBloc();
  const MesDemande({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Filtre(
                MesDemmande: true,
                user: user,
                open: false,
              ),
              BlocBuilder<MesDemandeBloc, MesDemandeState>(
          bloc: MesDemandeController,
          builder: (context, state) {
            if (state is MesDemandeInitial) {
                    MesDemandeController.add(getCars()) ; 

              return   Expanded(
                  child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Shimmers(widgts: MesVoitureCard() ,);
                },
              ));
            } else if(state is DataLoaded) {
              if(state.rentDemands.isNotEmpty) {
return   Expanded(
                  child: ListView.builder(
                itemCount:state.rentDemands.length,
                itemBuilder: (context, index) {
                    print(state.rentDemands.length)  ; 
                  return
                    GestureDetector(
                      onTap: () {
                         Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  DetailPage(demand: state.rentDemands[index],user: user,)),
  );
                      },
                      child: MesVoitureCard(demand: state.rentDemands[index],)) ;
                },
              ));

              }else {
                return  Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 24,vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color:Color(0xFF75A68D)),
                        borderRadius: BorderRadius.all(Radius.circular(8))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Icon(Icons.info_outline,color: Color(0xFF75A68D),), 
                        SizedBox(width: 8,),
                        AllText.text(fontsize: 14, color: Color(0xFF75A68D), FontWeight: FontWeight.w700, text: "Aucun demande")
                      ],),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 24),
      width: MediaQuery.sizeOf(context).width,
     
      child: SvgPicture.asset("assets/images/noDemand.svg",
              fit: BoxFit.cover,
            ),
    )
                   
                  
                  ],),
                ); 
              }
           
              
            }
            return  Container();
          }),
            
            ],
          ),
        ),
      ),
    );
    }
  }