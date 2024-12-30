import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickcar/DataClass/user.dart';
import 'package:pickcar/view/profile/Bloc/bloc/profile_bloc_bloc.dart';
import 'package:pickcar/view/profile/widgets/Permis.dart';
import 'package:pickcar/view/profile/widgets/infoPersonel.dart';
import 'package:pickcar/view/profile/widgets/initialPage.dart';
import 'package:pickcar/view/profile/widgets/payment.dart';
import 'package:pickcar/view/widgets/ImageProfile/ImageProfile.dart';
import 'package:pickcar/view/widgets/button/ChangeMode.dart';
import 'package:pickcar/view/widgets/button/logout.dart';
import 'package:pickcar/view/widgets/card/ContactAdmin.dart';
import 'package:pickcar/view/widgets/card/ProfileNavCards.dart';
import 'package:pickcar/view/widgets/card/ProfileVerifCard.dart';
import 'package:pickcar/view/widgets/text/text.dart';

class Profile extends StatelessWidget {
  final  User user; 
   static ProfileBlocBloc ProfileController = ProfileBlocBloc();
  const Profile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      // bottomNavigationBar: const ContactAdmin(),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            child:   BlocBuilder<ProfileBlocBloc, ProfileBlocState>(
            bloc: ProfileController,
            builder: (context, state) {
              if (state is ProfileBlocInitial) {
               return   InitialPage(user: user,); 
              } else if(state is PaymentState) {
                return   PaymentPage(user: user,); 
              }else if(state is PermisConduite) {
                return   Permis(hasPermit: true,user: user,); 
              }else if(state is infoPersonel) {
                return  InfoPersonel(user: user,); 
              }
              return  Container();
            }),
            
           
          ),
        ),
      ),
    );
  }
}
