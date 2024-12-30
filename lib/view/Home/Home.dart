import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pickcar/DataClass/car.dart';
import 'package:pickcar/DataClass/user.dart';
import 'package:pickcar/view/DetailPage/DetailPage.dart';
import 'package:pickcar/view/Home/bloc/bloc/home_bloc.dart';
import 'package:pickcar/view/widgets/Filtre/flitre.dart';
import 'package:pickcar/view/widgets/Filtre/selectdateWidget.dart/Selectdate.dart';
import 'package:pickcar/view/widgets/bottomSheet/AllButtomSheet.dart';
import 'package:pickcar/view/widgets/card/HomeCard.dart';
import 'package:pickcar/view/widgets/shimmer/shimmer.dart';

class Home extends StatelessWidget {
  final User user;
  static HomeBloc HomeController = HomeBloc();
  const Home({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    // HomeController.add(getCars()) ; 
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: BlocBuilder<HomeBloc, HomeState>(
          bloc: HomeController,
          builder: (context, state) {
            if (state is HomeInitial) {
             return  Column(
               children: [
                  Filtre(
                    user: user,
                open: false,
              ),
                 Expanded(
                   child: Center(
                    child: Container(
                      height: 300,
                      // width: 200,
                      child: SvgPicture.asset("assets/images/home.svg",
                      
                                  ),
                    ),
                    ),
                 ),
               ],
             ) ; 
            } else if(state is DataLoaded) {
              return      Column(
            children: [
              Filtre(
                user: user,
                open: true,
              ),
              BlocBuilder<HomeBloc, HomeState>(
          bloc: HomeController,
          builder: (context, state) {
            if (state is HomeInitial) {
              return   Expanded(
                  child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Shimmers(widgts: HomeCard(car: Car(),) ,);
                },
              ));
            } else if(state is DataLoaded) {
              return   Expanded(
                  child: ListView.builder(
                itemCount: state.cars.length,
                itemBuilder: (context, index) {
                  return  
                  GestureDetector(
                    onTap: () {
                          if(FiltreState.StartDate != null &&  FiltreState.DueDate != null &&  FiltreState.StartTime !=null && FiltreState.DueTime != null  ) {
                          Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>DetailPage(user: user, car: state.cars[index],)),
  );
                          }else {
                             AllBottomSheet.FunBottomSheet(
                        context, SelectDateBottomSheet());
                          }
                       
                    },
                    child: HomeCard(car : state.cars[index])) ;
                },
              ));
            }
            return  Container();
          }),
            
            ],
          ); 
            }
            return  Container();
          }),
          
          
          
       
        ),
      ),
    );
  }
}
