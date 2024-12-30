import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:pickcar/DataClass/rent.dart';
import 'package:pickcar/DataClass/rentdemand.dart';
import 'package:pickcar/view/widgets/cashedImage/cashedImage.dart';
import 'package:pickcar/view/widgets/text/text.dart';

class MesVoitureCard extends StatelessWidget {
  final Rent? rent;
  final RentDemand? demand;
  const MesVoitureCard({super.key,  this.demand, this.rent, });

  @override
  Widget build(BuildContext context) {
    return Container(
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
             height:110 ,
              width: 120,
              child: CachedImage(
                box: BoxFit.cover,
                img:
                 demand == null ? rent ==null? "":   'http://10.0.2.2:8080/uploads/'+rent!.rentDemand!.car!.carId!+'__0.png'+ '?v=${DateTime.now().millisecondsSinceEpoch}': 'http://10.0.2.2:8080/uploads/'+demand!.car!.carId!+'__0.png'+ '?v=${DateTime.now().millisecondsSinceEpoch}'   ,
              ),
            ),
            SizedBox(width:8,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: 160,
                    child: AllText.text(
                        textAlign: TextAlign.start,
                        fontsize: 16,
                        color: Colors.black,
                        FontWeight: FontWeight.w700,
                        text:demand == null ? rent ==null? "":rent!.rentDemand!.car!.brand!:  demand!.car!.brand!)),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month_outlined,
                      color: Color(0xFF468ACE),
                    ),
                    AllText.text(
                        fontsize: 12,
                        color: Colors.black,
                        FontWeight: FontWeight.w400,
                        text: demand == null ?rent== null?"" :"date début: " + DateFormat('dd-MM-yyyy').format(rent!.rentDemand!.dateBegin!) : "date début: " +DateFormat('dd-MM-yyyy').format(demand!.dateBegin!) )
                  ],
                ),
                  SizedBox(
                      
                      height:4,
                    ),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month_outlined,
                      color: Color(0xFF468ACE),
                    ),
                    AllText.text(
                        fontsize: 12,
                        color: Colors.black,
                        FontWeight: FontWeight.w400,
                        text: demand== null ? rent== null?"" :"date fin: " + DateFormat('dd-MM-yyyy').format(rent!.rentDemand!.dateEnd!): "date fin: " +  DateFormat('dd-MM-yyyy').format(demand!.dateEnd!))
                  ],
                ),
                SizedBox(
                      
                      height:4,
                    ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        alignment: Alignment.center,
                        height: 24,
                        decoration: BoxDecoration(
                            color: Color(0xFF5AAA85),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: AllText.text(
                            fontsize: 12,
                            color: Colors.white,
                            FontWeight: FontWeight.w400,
                            text: demand==null ? rent== null?"" :"Prix total: " + rent!.rentDemand!.price.toString()+ " €" : "Prix total: " + demand!.price.toString() + " €")),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        alignment: Alignment.center,
                        height: 24,
                        decoration: BoxDecoration(
                            color: Color(0xFFC00114),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: AllText.text(
                            fontsize: 12,
                            color: Colors.white,
                            FontWeight: FontWeight.w400,
                            text:demand == null ?rent== null?"" :rent!.status! =="CREATED" ? "Crée": rent!.status! == "UPDATED"? "Modifiée":rent!.status! == "FREE" ?"Libre":rent!.status! =="NOT_FREE" ?"Non libre":rent!.status! == "PROPOSED" ? "Proposée":rent!.status! =="ACCEPTED"?"Acceptée":rent!.status! =="CONFIRMED"?"Confirmée":rent!.status! =="WAITING_FOR_RETRIEVAL"?"A récupérer":rent!.status! =="RENTING"?"En location":rent!.status! =="COMPLETED"?"Complétée":rent!.status! =="VALIDATED"?"Validée":rent!.status! =="UNVALIDATED"?"Non validée": rent!.status! :  
                            
                            demand!.status! =="CREATED" ? "Crée":demand!.status! == "REFUSED"? "Refusée":demand!.status! == "CANCELED" ?"Annulée":demand!.status! =="Not_Free" ?"NOT_FREE":demand!.status! == "PROPOSED" ? "Proposée" :demand!.status! =="ACCEPTED"?"Acceptée":demand!.status! =="CONFIRMED"?"Confirmée":demand!.status! =="WAITING_FOR_RETRIEVAL"?"A récupérer":demand!.status! =="RENTING"?"En location":demand!.status! =="COMPLETED"?"Complétée":demand!.status! =="VALIDATED"?"Validée":demand!.status! =="UNVALIDATED"?"Non validée": demand!.status.toString())),
                  ],
                )
              ],
            )
          ],
        ));
  }
}
