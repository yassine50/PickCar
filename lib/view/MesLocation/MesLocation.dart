import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pickcar/DataClass/rent.dart';
import 'package:pickcar/DataClass/rentdemand.dart';
import 'package:pickcar/DataClass/user.dart';
import 'package:pickcar/view/DetailPage/DetailPage.dart';
import 'package:pickcar/view/MesLocation/bloc/bloc/mesvoiture_bloc.dart';
import 'package:pickcar/view/widgets/Filtre/flitre.dart';
import 'package:pickcar/view/widgets/card/MesVoitureCard.dart';
import 'package:pickcar/view/widgets/shimmer/shimmer.dart';
import 'package:pickcar/view/widgets/text/text.dart';

class MesLocation extends StatefulWidget {
  final User user;
   static MesvoitureBloc MesVoitureController = MesvoitureBloc();
  const MesLocation({super.key, required this.user});

  @override
  State<MesLocation> createState() => _MesLocationState();
}

class _MesLocationState extends State<MesLocation> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
                MesLocation. MesVoitureController.add(getCars()) ; 

  }
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Filtre(
                MesLocation: true,
                user: widget.user,
                open: true,
              ),
              BlocBuilder<MesvoitureBloc, MesvoitureState>(
          bloc: MesLocation.MesVoitureController,
          builder: (context, state) {
            if (state is MesvoitureInitial) {
               MesLocation. MesVoitureController.add(getCars()) ; 
              return   Expanded(
                  child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Shimmers(widgts: MesVoitureCard() ,);
                },
              ));
            } else if(state is DataLoaded) {
              if(state.rents.isNotEmpty) {
 return   Expanded(
                  child: ListView.builder(
                itemCount: state.rents.length,
                itemBuilder: (context, index) {

                  return  GestureDetector(
                    onTap: () {
                        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  DetailPage(demand:null ,car: null,user: widget.user, rent: state.rents[index],)),
  );
                    },
                    child:   MesVoitureCard(rent: state.rents[index],),
                  );
                 
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
                        AllText.text(fontsize: 14, color: Color(0xFF75A68D), FontWeight: FontWeight.w700, text: "Aucun Location")
                      ],),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 24),
      width: MediaQuery.sizeOf(context).width,
     
      child: SvgPicture.asset("assets/images/noLocation.svg",
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