import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pickcar/view/widgets/cashedImage/cashedImage.dart';
import 'package:pickcar/view/widgets/text/text.dart';

class NotifCard extends StatelessWidget {
  const NotifCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Container(
              width: 80,
              child: CachedImage(
                img:
                    'https://www.mbusa.com/content/dam/mb-nafta/us/myco/my23/eqe-sedan/all-vehicles/2023-EQE350-SEDAN-AVP-DR.png',
              ),
            ),
          Container(
               width: MediaQuery.sizeOf(context).width *0.62,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AllText.text(
                        fontsize: 14,
                        color: Colors.black,
                        FontWeight: FontWeight.w500,
                        text: "Titre notifications 01",
                        textAlign: TextAlign.left),
                    Icon(Icons.more_vert_outlined),
                 
                  ],
                ),
                   Container(
                  
                    child: AllText.text(
                        fontsize: 12,
                        color: Color(0xFF49454F),
                        FontWeight: FontWeight.w400,
                        text:
                            "Supporting line text lorem ipsum dolor sit amet, consectetur Supporting line text lorem ipsum dolor sit amet, consectetur",
                        textAlign: TextAlign.left))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
