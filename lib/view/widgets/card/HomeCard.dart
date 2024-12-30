import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pickcar/DataClass/car.dart';
import 'package:pickcar/view/widgets/cashedImage/cashedImage.dart';
import 'package:pickcar/view/widgets/text/text.dart';

class HomeCard extends StatelessWidget {
  final Car car ; 
  const HomeCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: Colors.grey ,width: 0.3)),
      // width: double.infinity,
     child:  Row(children: [
        Container(
          width: 156,
        child:   CachedImage(img: 'https://www.mbusa.com/content/dam/mb-nafta/us/myco/my23/eqe-sedan/all-vehicles/2023-EQE350-SEDAN-AVP-DR.png',), 
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Container(
            width: 160,
            child: AllText.text(
              textAlign: TextAlign.start,
              fontsize: 16, color: Colors.black, FontWeight: FontWeight.w700, text: car.brand!)),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              color:Color(0xFFDFE1E2)  , 
            ),
            child: AllText.text(fontsize: 12, color: Color(0xFF74898C), FontWeight: FontWeight.w600, text: car.category!),
          ),
           Row(children: [
              SvgPicture.asset(
                height: 14,
                width: 14,
                  "assets/images/vitesse.svg",
                  fit: BoxFit.cover,
                ),

                AllText.text(fontsize: 10, color: Colors.black, FontWeight: FontWeight.w400, text: car.mileage!.toString()),


            ],),
            Container(
              width: 156,
             alignment: Alignment.center,
                    height: 16,
                    decoration: BoxDecoration(
                      color:  Color(0xFF5AAA85), 
                      borderRadius: BorderRadius.all(
                      Radius.circular(8)
                      )
                    ),
                    child:   AllText.text(fontsize: 12, color: Colors.white, FontWeight: FontWeight.w400, text: "Prix Total: "+car.pricePerHour.toString() +"TND")
                  )
           
        ],)
        
      ],)

    );
  }
}