import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pickcar/DataClass/user.dart';
import 'package:pickcar/Tools/Constants.dart';
import 'package:pickcar/view/Home/Home.dart';
import 'package:pickcar/view/Home/Map.dart';
import 'package:pickcar/view/MesDemande/MesDemande.dart';
import 'package:pickcar/view/MesLocation/MesLocation.dart';
import 'package:pickcar/view/MesVoiture/MesVoiture.dart';
import 'package:pickcar/view/Notification/Notification.dart';
import 'package:pickcar/view/profile/profile.dart';

class GoogleNavBar extends StatefulWidget {
  final User user ;
  const GoogleNavBar({super.key, required this.user});

  @override
  State<GoogleNavBar> createState() => GoogleNavBarState();
}

class GoogleNavBarState extends State<GoogleNavBar> {
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);




  @override
  Widget build(BuildContext context) {
     List<Widget> _widgetOptions =widget.user.currentMode == Constants.ModeProprietaire ?
   <Widget>[
    MesDemande(user: widget.user,),
  MesLocation(user: widget.user,),
   MesVoiture(user: widget.user,),
   Notif(),
    Profile(user: widget.user,)
  ]
   :  <Widget>[
    Mapss(user: widget.user,),
    //Home(user: widget.user,),
    MesLocation(user: widget.user),
    MesDemande(user: widget.user,),
    Notif(),
    Profile(user: widget.user,)
  ];
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft:Radius.circular(6) ,topRight: Radius.circular(6) ),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF2576B9),
                Color(0xFF592FAA),
              ],
            )
          
          
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: GNav(
              // hoverColor: Colors.white,
              // backgroundColor: Colors.white,
              // rippleColor: Colors.white,
              tabBackgroundColor: Colors.white,
              gap: 8,
              tabBorderRadius: 15,
              color: Colors.white,
              activeColor: Color(0xFF3F14A0),
              
              iconSize: 25,
              textStyle: GoogleFonts.firaSans(
                fontSize: 12,
                color: Color(0xFF3F14A0),
                fontWeight: FontWeight.w700,
              ),
              // tabBackgroundColor: Colors.grey[800]!,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16.5),
              duration: Duration(milliseconds: 800),
              tabs: [
                GButton(
                  icon:widget.user.currentMode == Constants.ModeProprietaire  ? _selectedIndex == 0 ?  Icons.directions_car
                      : Icons.directions_car_outlined : Icons.search,
                  text: widget.user.currentMode == Constants.ModeProprietaire  ?"Listes Demandes" : 'Recherche',
                ),
                GButton(
                  icon: _selectedIndex == 1
                      ? Icons.directions_car
                      : Icons.directions_car_outlined,
                  text: 'Mes locations',
                ),
                GButton(
                  icon: _selectedIndex == 2
                      ? Icons.directions_car
                      : Icons.directions_car_outlined,
                  text: widget.user.currentMode == Constants.ModeProprietaire ? "Mes voitures":'Mes demandes',
                ),
                GButton(
                  icon: _selectedIndex == 3
                      ? Icons.circle_notifications
                      : Icons.circle_notifications_outlined,
                  text: 'Notifications',
                ),
                GButton(
                  icon: _selectedIndex == 4
                      ? Icons.person_pin
                      : Icons.person_pin_circle_outlined,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (value) {
                setState(() {
                  _selectedIndex = value;
                });
                print(value);
                print(_selectedIndex);
              },
            ),
          ),
        ),
      ),
    );
  }
}
