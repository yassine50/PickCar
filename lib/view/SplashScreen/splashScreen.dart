import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'dart:async';

import 'package:pickcar/view/Login/Login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin  {
 FlutterGifController? controller ;
     //FlutterGifController controller= FlutterGifController(vsync: this);
  @override
  void initState() {
    super.initState();
    controller = FlutterGifController(vsync: this);
    Timer(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Login()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GifImage(
          controller: controller!,
          image: AssetImage("assets/images/splash_animation.gif"),
        ),
      ),
    );
  }
}
