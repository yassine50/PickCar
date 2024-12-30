import 'package:flutter/material.dart';
import 'package:pickcar/DataClass/payment.dart';
import 'package:pickcar/DataClass/user.dart';
import 'package:pickcar/view/profile/Bloc/bloc/profile_bloc_bloc.dart';
import 'package:pickcar/view/profile/profile.dart';
import 'package:pickcar/view/widgets/ImageProfile/ImageProfile.dart';
import 'package:pickcar/view/widgets/button/ChangeMode.dart';
import 'package:pickcar/view/widgets/button/logout.dart';
import 'package:pickcar/view/widgets/button/saveButton.dart';
import 'package:pickcar/view/widgets/card/ContactAdmin.dart';
import 'package:pickcar/view/widgets/card/ProfileNavCards.dart';
import 'package:pickcar/view/widgets/card/ProfileVerifCard.dart';
import 'package:pickcar/view/widgets/text/text.dart';

class InitialPage extends StatelessWidget {
  final User user;
  const InitialPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return  Column(
            children: [
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [ChangeMode(user: user,), Logout()],
              ),
              const SizedBox(
                height: 16,
              ),
               ImageProfile(user: user,),
              const SizedBox(
                height: 24,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: AllText.text(
                    fontsize: 16,
                    color: const Color(0xFF006C48),
                    FontWeight: FontWeight.w700,
                    text: "Profile complétion: 30%"),
              ),
              const SizedBox(
                height: 4,
              ),
              Container(
                height: 8,
                width: double.infinity,
                child: const LinearProgressIndicator(
                  color: Color(0xFF006C48),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  value: 0.3,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const ProfileVerifCard(),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                  
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.directions_car_outlined),
                          const SizedBox(
                            width: 4,
                          ),
                          AllText.text(
                              fontsize: 12,
                              color: const Color(0xFF00305B),
                              FontWeight: FontWeight.w400,
                              text: "Nombres de locations")
                        ],
                      ),
                     const SizedBox(height: 8,),
                   Container(
                        height: 40,
                    width: MediaQuery.sizeOf(context).width *0.4,
                    padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0062A2),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color:Colors.grey )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AllText.text(fontsize: 14, color: Colors.white, FontWeight: FontWeight.w400, text: user.rentCount.toString() + " véhicule"),
                        const Icon(Icons.arrow_forward_rounded, color: Colors.white,)
                    ],),
                   )
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.payment_rounded),
                          const SizedBox(
                            width: 4,
                          ),
                          AllText.text(
                              fontsize: 12,
                              color: const Color(0xFF00305B),
                              FontWeight: FontWeight.w400,
                              text: "Somme des locations")
                        ],
                      ),
                     const SizedBox(height: 8,),
                      Container(
                        height: 40,
                    width: MediaQuery.sizeOf(context).width *0.4,
                    padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color:Colors.grey )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AllText.text(fontsize: 14, color: const Color(0xFF2E805D), FontWeight: FontWeight.w400, text: user.totlaPrice == null ? '0 €':  user.totlaPrice.toString()+" €"),
                     
                    ],),
                   )
                    ],
                  )
                ],
              ),
                 const SizedBox(height: 8,),
              ProfileNavCards(hint: "Info personnelle", onTap: (){
                Profile.ProfileController.emit(infoPersonel());
              },),
              const SizedBox(height: 8,),
              ProfileNavCards(hint: "Paramètre de paiement", onTap: (){
                Profile.ProfileController.emit(PaymentState());
              },),
                 const SizedBox(height: 8,),
              ProfileNavCards(hint: "Permis de conduite", onTap: (){
                 Profile.ProfileController.emit(PermisConduite());
              },),
              // Expanded(child: Column(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //   ContactAdmin()
              // ],)),
               
              SizedBox(height: 12,)
            ],
          );
  }
}