import 'package:flutter/material.dart';
import 'package:pickcar/DataClass/car.dart';
import 'package:pickcar/view/widgets/cashedImage/cashedImage.dart';
import 'package:pickcar/view/widgets/text/text.dart';

class MesVoitureProp extends StatelessWidget {
  final Car car;
  const MesVoitureProp({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return  Container(
        margin: EdgeInsets.only(top: 8),
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: Colors.grey, width: 0.3)),
        // width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 100,
             // color: Colors.amber,
              width: 120,
              child: CachedImage(
                box: BoxFit.cover,
                img:
                    'http://10.0.2.2:8080/uploads/'+car.carId!.toString()+'__0.png'+ '?v=${DateTime.now().millisecondsSinceEpoch}',
              ),
            ),
            SizedBox(width: 12,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: 160,
                    child: AllText.text(
                        textAlign: TextAlign.start,
                        fontsize: 12,
                        color: Colors.black,
                        FontWeight: FontWeight.w500,
                        text: car.brand! )),
                Row(
                  children: [
                    Icon(
                      Icons.speed_outlined,
                      color: Color(0xFF468ACE),
                    ),
                    SizedBox(width: 8,),
                    AllText.text(
                        fontsize: 12,
                        color: Colors.black,
                        FontWeight: FontWeight.w400,
                        text: car.mileage!.toString(),)
                  ],
                ),
                  SizedBox(
                      
                      height:4,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      width: MediaQuery.sizeOf(context).width*0.5,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color:Color(0xFF75A68D) ),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
                      ),
                      child: AllText.text(fontsize: 12, color: Color(0xFF2E805D), FontWeight: FontWeight.w400, text: "Prix/heure: " +car.pricePerHour!.toString()),
                    ),
                    Container(
                       padding: EdgeInsets.symmetric(vertical: 4),
                        width: MediaQuery.sizeOf(context).width*0.5,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xFF75A68D),
                        border: Border.all(color:Color(0xFF75A68D) ),
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12))
                      ),
                      child: AllText.text(fontsize: 12, color: Colors.white, FontWeight: FontWeight.w400, text: car.status =="CREATED" ? "Crée": car.status == "UPDATED"? "Modifiée":car.status == "FREE" ?"Libre":car.status=="NOT_FREE" ?"Non libre":car.status== "PROPOSED" ? "Proposée":car.status=="ACCEPTED"?"Acceptée":car.status=="CONFIRMED"?"Confirmée":car.status=="WAITING_FOR_RETRIEVAL"?"A récupérer":car.status=="IN_RENTING"?"En location":car.status=="COMPLETED"?"Complètée":car.status=="VALIDATED"?"Validée":car.status=="INVALIDATED"?"Non validée": car.status!),
                    )
               
              
               
              ],
            )
          ],
        ));
  }
}