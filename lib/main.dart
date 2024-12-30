import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pickcar/DataClass/user.dart';
import 'package:pickcar/view/Home/Map.dart';
import 'package:pickcar/view/Steps/Steps.dart';
import 'package:pickcar/view/sign%20up/SignUp.dart';
import 'package:pickcar/view/widgets/GoogleNavBar/Navbar.dart';
import '/view/Login/login.dart';

Future<void> main() async {
 await Hive.initFlutter();
   await Hive.openBox("user"); 
       var box = Hive.box('user');
       box.clear();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner :false, 
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:Login()
    );
  }
}

