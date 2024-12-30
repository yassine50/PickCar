import 'package:flutter/material.dart';
import 'package:pickcar/view/widgets/card/NotifCard.dart';
import 'package:pickcar/view/widgets/text/text.dart';

class Notif extends StatelessWidget {
  const Notif({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AllText.text(
                      fontsize: 16,
                      color: Colors.black,
                      FontWeight: FontWeight.w600,
                      text: "Notifications"),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Color(0xFF2576B9)),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Row(
                        children: [
                          AllText.text(
                              fontsize: 10,
                              color: Color(0xFF2576B9),
                              FontWeight: FontWeight.w400,
                              text: "Aujourd’hui 12/06/2024"),
                          SizedBox(
                            width: 8,
                          ),
                          Icon(
                            Icons.calendar_month_outlined,
                            color: Color(0xFF2576B9),
                          )
                        ],
                      ))
                ],
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return NotifCard();
                },
              ))
            ],
          ),
        ),
      ),
    );
    ;
  }
}
