import 'dart:convert';

import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:pickcar/DataClass/car.dart';
import 'package:pickcar/DataClass/rent.dart';
import 'package:pickcar/DataClass/rentdemand.dart';
import 'package:pickcar/DataClass/user.dart';
import 'package:pickcar/Tools/ApiMethode.dart';
import 'package:pickcar/Tools/Constants.dart';
import 'package:pickcar/view/MesDemande/MesDemande.dart';
import 'package:pickcar/view/MesDemande/bloc/bloc/mes_demande_bloc.dart';
import 'package:pickcar/view/MesLocation/MesLocation.dart';
import 'package:pickcar/view/MesLocation/bloc/bloc/mesvoiture_bloc.dart';
import 'package:pickcar/view/MesVoiture/MesVoiture.dart';
import 'package:pickcar/view/MesVoiture/bloc/bloc/mes_voiture_bloc.dart';
import 'package:pickcar/view/widgets/Filtre/flitre.dart';
import 'package:pickcar/view/widgets/button/AuthButtns.dart';
import 'package:pickcar/view/widgets/cashedImage/cashedImage.dart';
import 'package:pickcar/view/widgets/popups/Allpop.dart';
import 'package:pickcar/view/widgets/text/text.dart';

class DetailPage extends StatefulWidget {
  final User user;
  final Rent? rent;
  final RentDemand? demand;
  final Car? car;
  const DetailPage(
      {super.key, this.demand, this.rent, required this.user, this.car});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  String imgProfile = "";
  List<String> imgList = [];

  @override
  void initState() {
    imgList = widget.rent != null
        ? [
            'http://10.0.2.2:8080/uploads/' +
                widget.rent!.rentDemand!.car!.carId! +
                '__0.png' +
                '?v=${DateTime.now().millisecondsSinceEpoch}',
            'http://10.0.2.2:8080/uploads/' +
                widget.rent!.rentDemand!.car!.carId! +
                '__1.png' +
                '?v=${DateTime.now().millisecondsSinceEpoch}',
            'http://10.0.2.2:8080/uploads/' +
                widget.rent!.rentDemand!.car!.carId! +
                '__2.png' +
                '?v=${DateTime.now().millisecondsSinceEpoch}',
            'http://10.0.2.2:8080/uploads/' +
                widget.rent!.rentDemand!.car!.carId! +
                '__3.png' +
                '?v=${DateTime.now().millisecondsSinceEpoch}',
          ]
        : widget.demand != null
            ? [
                'http://10.0.2.2:8080/uploads/' +
                    widget.demand!.car!.carId!.toString() +
                    '__0.png' +
                    '?v=${DateTime.now().millisecondsSinceEpoch}',
                'http://10.0.2.2:8080/uploads/' +
                    widget.demand!.car!.carId!.toString() +
                    '__1.png' +
                    '?v=${DateTime.now().millisecondsSinceEpoch}',
                'http://10.0.2.2:8080/uploads/' +
                    widget.demand!.car!.carId!.toString() +
                    '__2.png' +
                    '?v=${DateTime.now().millisecondsSinceEpoch}',
                'http://10.0.2.2:8080/uploads/' +
                    widget.demand!.car!.carId!.toString() +
                    '__3.png' +
                    '?v=${DateTime.now().millisecondsSinceEpoch}',
              ]
            : widget.car != null
                ? [
                    'http://10.0.2.2:8080/uploads/' +
                        widget.car!.carId!.toString() +
                        '__0.png',
                    'http://10.0.2.2:8080/uploads/' +
                        widget.car!.carId!.toString() +
                        '__1.png',
                    'http://10.0.2.2:8080/uploads/' +
                        widget.car!.carId!.toString() +
                        '__2.png',
                    'http://10.0.2.2:8080/uploads/' +
                        widget.car!.carId!.toString() +
                        '__3.png',
                  ]
                : [];

    imgProfile = widget.rent != null
        ? 'http://10.0.2.2:8080/uploads/' +
            widget.rent!.rentDemand!.customer!.user!.userIdentifier!
                .toString() +
            '.png' +
            '?v=${DateTime.now().millisecondsSinceEpoch}'
        : widget.demand != null
            ? 'http://10.0.2.2:8080/uploads/' +
                widget.demand!.customer!.user!.userIdentifier!.toString() +
                '.png' +
                '?v=${DateTime.now().millisecondsSinceEpoch}'
            : widget.car != null
                ? 'http://10.0.2.2:8080/uploads/' +
                    widget.car!.renter!.userIdentifier!.toString() +
                    '.png' +
                    '?v=${DateTime.now().millisecondsSinceEpoch}'
                : "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = imgList
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.network(item, fit: BoxFit.cover, width: 1000.0),
                      ],
                    )),
              ),
            ))
        .toList();

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CarouselSlider(
                            items: imageSliders,
                            // carouselController: _controller,
                            options: CarouselOptions(
                                viewportFraction: 1,
                                autoPlay: true,
                                enlargeCenterPage: false,
                                aspectRatio: 2.0,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _current = index;
                                  });
                                }),
                          ),
                          Positioned(
                            bottom: 8,
                            left: MediaQuery.sizeOf(context).width * 0.27,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: imgList.asMap().entries.map((entry) {
                                return GestureDetector(
                                  onTap: () =>
                                      _controller.animateToPage(entry.key),
                                  child: Container(
                                    width: 12.0,
                                    height: 12.0,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 4.0),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: (Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : _current == entry.key
                                                ? Color(0xFF519374)
                                                : Colors.grey)),
                                  ),
                                );
                              }).toList(),
                            ),
                          )
                        ],
                      ),
                      // margin: EdgeInsets.symmetric(horizontal: 24),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AllText.text(
                                      fontsize: 14,
                                      color: Colors.black,
                                      FontWeight: FontWeight.w500,
                                      text: widget.demand == null
                                          ? widget.car == null
                                              ? widget.rent == null
                                                  ? ''
                                                  : widget.rent!.rentDemand!
                                                      .car!.brand!
                                              : widget.car!.brand!
                                          : widget.demand!.car!.brand
                                              .toString()),
                                  Container(
                                    alignment: Alignment.center,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    decoration: BoxDecoration(
                                        color:
                                            Color(0xFF2E805D).withOpacity(0.2),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        border: Border.all(
                                            color: Color(0xFF2E805D))),
                                    child: AllText.text(
                                        fontsize: 14,
                                        color: Color(0xFF2E805D),
                                        FontWeight: FontWeight.w400,
                                        text: widget.demand == null
                                            ? widget.car == null
                                                ? widget.rent == null
                                                    ? ''
                                                    : "Prix total: " +
                                                        widget.rent!.rentDemand!
                                                            .price!
                                                            .toString()
                                                : "Prix/heure: " +
                                                    widget.car!.pricePerHour!
                                                        .toString()
                                            : "Prix total: " +
                                                widget.demand!.price
                                                    .toString()),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              decoration: BoxDecoration(
                                  color: Color(0xFF2E805D).withOpacity(0.2),
                                  border: Border.all(color: Color(0xFF2E805D)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
                              child: AllText.text(
                                  fontsize: 14,
                                  color: Color(0xFF2E805D),
                                  FontWeight: FontWeight.w500,
                                  text: widget.car == null
                                      ? widget.demand == null
                                          ? widget.rent == null
                                              ? ''
                                              : widget.rent!.status! =="CREATED" ? "Crée": widget.rent!.status! == "UPDATED"? "Modifiée":widget.rent!.status! == "FREE" ?"Libre":widget.rent!.status! =="NOT_FREE" ?"Non libre":widget.rent!.status! == "PROPOSED" ? "Proposée":widget.rent!.status! =="ACCEPTED"?"Acceptée":widget.rent!.status! =="CONFIRMED"?"Confirmée":widget.rent!.status! =="WAITING_FOR_RETRIEVAL"?"A récupérer":widget.rent!.status! =="RENTING"?"En location":widget.rent!.status! =="COMPLETED"?"Complétée":widget.rent!.status! =="VALIDATED"?"Validée":widget.rent!.status! =="UNVALIDATED"?"Non validée":widget.rent!.status! :  
                                              widget.demand!.status! =="CREATED" ? "Crée":widget.demand!.status! == "REFUSED"? "Refusée":widget.demand!.status! == "CANCELED" ?"Annulée":widget.demand!.status! =="NOT_FREE" ?"Non libre":widget.demand!.status! == "PROPOSED" ? "Proposée" :widget.demand!.status! =="ACCEPTED"?"Acceptée":widget.demand!.status! =="CONFIRMED"?"Confirmée":widget.demand!.status! =="WAITING_FOR_RETRIEVAL"?"A récupérer":widget.demand!.status! =="RENTING"?"En location":widget.demand!.status! =="COMPLETED"?"Complètée":widget.demand!.status! =="VALIDATED"?"Validée":widget.demand!.status! =="INVALIDATED"?"Non validée": widget.demand!.status!.toString()
                 
                                          :widget.car!.status! =="CREATED" ? "Crée": widget.car!.status!  == "UPDATED"? "Modifiée":widget.car!.status!  == "FREE" ?"Libre":widget.car!.status!  =="NOT_FREE" ?"Non libre":widget.car!.status! == "PROPOSED" ? "Proposée":widget.car!.status! =="ACCEPTED"?"Acceptée":widget.car!.status! =="CONFIRMED"?"Confirmée":widget.car!.status! =="WAITING_FOR_RETRIEVAL"?"A récupérer":widget.car!.status! =="IN_RENTING"?"En location":widget.car!.status! =="COMPLETED"?"Complétée":widget.car!.status! =="VALIDATED"?"Validée":widget.car!.status! =="INVALIDATED"?"Non validée": widget.car!.status! ),
                    
                        
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            if (widget.car == null) ...{
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                        Border.all(color: Color(0xFF2E805D)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AllText.text(
                                            fontsize: 14,
                                            color: Colors.black,
                                            FontWeight: FontWeight.w700,
                                            text: widget.demand == null
                                                ? widget.rent == null
                                                    ? ''
                                                    : "Date de début location : " +
                                                        DateFormat('yyyy/MM/dd')
                                                            .format(widget
                                                                .rent!
                                                                .rentDemand!
                                                                .dateBegin!)
                                                            .toString()
                                                : "Date de début location : " +
                                                    DateFormat('yyyy/MM/dd')
                                                        .format(widget
                                                            .demand!.dateBegin!)
                                                        .toString()),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.access_time,
                                              color: Color(0xFF468ACE),
                                            ),
                                            AllText.text(
                                                fontsize: 10,
                                                color: Colors.black,
                                                FontWeight: FontWeight.w400,
                                                text: widget.demand == null
                                                    ? widget.rent == null
                                                        ? ''
                                                        : DateFormat('hh:mm a')
                                                            .format(widget
                                                                .rent!
                                                                .rentDemand!
                                                                .dateBegin!)
                                                    : DateFormat('hh:mm a')
                                                        .format(widget.demand!
                                                            .dateBegin!)),
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AllText.text(
                                            fontsize: 14,
                                            color: Colors.black,
                                            FontWeight: FontWeight.w700,
                                            text: widget.demand == null
                                                ? widget.rent == null
                                                    ? ''
                                                    : "Date de fin location :" +
                                                        DateFormat('yyyy/MM/dd')
                                                            .format(widget
                                                                .rent!
                                                                .rentDemand!
                                                                .dateEnd!)
                                                            .toString()
                                                : "Date de fin location :" +
                                                    DateFormat('yyyy/MM/dd')
                                                        .format(widget
                                                            .demand!.dateEnd!)
                                                        .toString()),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.access_time,
                                              color: Color(0xFF468ACE),
                                            ),
                                            AllText.text(
                                                fontsize: 10,
                                                color: Colors.black,
                                                FontWeight: FontWeight.w400,
                                                text: widget.demand == null
                                                    ? widget.rent == null
                                                        ? ''
                                                        : DateFormat('hh:mm a')
                                                            .format(widget
                                                                .rent!
                                                                .rentDemand!
                                                                .dateEnd!)
                                                    : DateFormat('hh:mm a')
                                                        .format(widget
                                                            .demand!.dateEnd!)),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                            },
                            Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 15),
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 8),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border:
                                          Border.all(color: Color(0xFF2E805D)),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4))),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            height: 68,
                                            width: 68,
                                            child: CachedImage(img: imgProfile),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          AnimatedRatingStars(
                                            initialRating: 3.5,
                                            minRating: 0.0,
                                            maxRating: 5.0,
                                            filledColor: Colors.amber,
                                            emptyColor: Colors.grey,
                                            filledIcon: Icons.star,
                                            halfFilledIcon: Icons.star_half,
                                            emptyIcon: Icons.star_border,
                                            onChanged: (double rating) {
                                              // Handle the rating change here
                                              print('Rating: $rating');
                                            },
                                            displayRatingValue: true,
                                            interactiveTooltips: true,
                                            customFilledIcon: Icons.star,
                                            customHalfFilledIcon:
                                                Icons.star_half,
                                            customEmptyIcon: Icons.star_border,
                                            starSize: 10,
                                            animationDuration:
                                                Duration(milliseconds: 300),
                                            animationCurve: Curves.easeInOut,
                                            readOnly: true,
                                          )
                                        ],
                                      ),
                                      SizedBox(width: 8),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AllText.text(
                                              fontsize: 14,
                                              color: Colors.black,
                                              FontWeight: FontWeight.w700,
                                              text: widget.demand == null
                                                  ? widget.car == null
                                                      ? widget.rent == null
                                                          ? ''
                                                          : widget
                                                                  .rent!
                                                                  .rentDemand!
                                                                  .car!
                                                                  .renter!
                                                                  .firstName
                                                                  .toString() +
                                                              " " +
                                                              widget
                                                                  .rent!
                                                                  .rentDemand!
                                                                  .car!
                                                                  .renter!
                                                                  .lastName
                                                                  .toString()
                                                      : widget.car!.renter!
                                                              .firstName
                                                              .toString() +
                                                          " " +
                                                          widget.car!.renter!
                                                              .lastName
                                                              .toString()
                                                  : widget.demand!.customer!
                                                          .user!.firstName
                                                          .toString() +
                                                      widget.demand!.customer!
                                                          .user!.lastName
                                                          .toString()),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.phone,
                                                  color: Color(0xFF468ACE)),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              AllText.text(
                                                  fontsize: 10,
                                                  color: Colors.black,
                                                  FontWeight: FontWeight.w400,
                                                  text: widget.demand == null
                                                      ? widget.car == null
                                                          ? widget.rent == null
                                                              ? ''
                                                              : widget
                                                                  .rent!
                                                                  .rentDemand!
                                                                  .car!
                                                                  .renter!
                                                                  .phone
                                                                  .toString()
                                                          : "Téléphone: " +
                                                              widget.car!
                                                                  .renter!.phone
                                                                  .toString()
                                                      : "Téléphone: " +
                                                          widget
                                                              .demand!
                                                              .customer!
                                                              .user!
                                                              .phone
                                                              .toString()),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.email,
                                                  color: Color(0xFF468ACE)),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.53,
                                                child: AllText.text(
                                                    fontsize: 10,
                                                    textAlign: TextAlign.start,
                                                    color: Colors.black,
                                                    FontWeight: FontWeight.w400,
                                                    text: widget.demand == null
                                                        ? widget.car == null
                                                            ? widget.rent ==
                                                                    null
                                                                ? ''
                                                                : "E-mail: " +
                                                                    widget
                                                                        .rent!
                                                                        .rentDemand!
                                                                        .car!
                                                                        .renter!
                                                                        .email
                                                                        .toString()
                                                            : "E-mail: " +
                                                                widget
                                                                    .car!
                                                                    .renter!
                                                                    .email
                                                                    .toString()
                                                        : "E-mail: " +
                                                            widget
                                                                .demand!
                                                                .customer!
                                                                .user!
                                                                .email
                                                                .toString()),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 18),
                                    decoration: BoxDecoration(
                                        color: Color(0xFF75A68D),
                                        border: Border.all(
                                            color: Color(0xFF2E805D)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: AllText.text(
                                        fontsize: 14,
                                        color: Colors.white,
                                        FontWeight: FontWeight.w700,
                                        text: "Pro"),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Color(0xFF2E805D)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AllText.text(
                                      fontsize: 14,
                                      color: Colors.black,
                                      FontWeight: FontWeight.w700,
                                      text: "Type véhicule"),
                                  Row(
                                    children: [
                                      Container(
                                        width: 24,
                                        height: 24,
                                        child: SvgPicture.asset(
                                          "assets/images/car.svg",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      AllText.text(
                                          fontsize: 10,
                                          color: Colors.black,
                                          FontWeight: FontWeight.w400,
                                          text: widget.demand == null
                                              ? widget.car == null
                                                  ? widget.rent == null
                                                      ? ''
                                                      : widget.rent!.rentDemand!
                                                          .car!.category
                                                          .toString()
                                                  : widget.car!.category
                                                      .toString()
                                              : widget.demand!.car!.category
                                                  .toString()),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Color(0xFF2E805D)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AllText.text(
                                      fontsize: 14,
                                      color: Colors.black,
                                      FontWeight: FontWeight.w700,
                                      text: "Adresse  Pick-up"),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.place_outlined,
                                        color: Color(0xFF468ACE),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        //alignment: al,

                                        margin: EdgeInsets.symmetric(
                                            horizontal: 12),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.64,
                                        child: AllText.text(
                                          textAlign: TextAlign.left,
                                          fontsize: 14,
                                          color: Colors.black,
                                          FontWeight: FontWeight.w400,
                                          text: widget.demand == null
                                              ? widget.car == null
                                                  ? widget.rent == null
                                                      ? ''
                                                      : widget
                                                          .rent!
                                                          .rentDemand!
                                                          .car!
                                                          .address!
                                                          .country!
                                                  : widget
                                                      .car!.address!.country!
                                                      .toString()
                                              : widget.demand!.car!.address!
                                                  .country!
                                                  .toString(),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                        Border.all(color: Color(0xFF2E805D)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.calendar_month,
                                              color: Color(0xFF468ACE),
                                            ),
                                            Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6,
                                                child: AllText.text(
                                                    fontsize: 10,
                                                    color: Colors.black,
                                                    FontWeight: FontWeight.w400,
                                                    text: widget.demand == null
                                                        ? widget.car == null
                                                            ? widget.rent ==
                                                                    null
                                                                ? ''
                                                                : "Date premiere  immatriculatione: " +
                                                                    widget
                                                                        .rent!
                                                                        .rentDemand!
                                                                        .car!
                                                                        .dateFirstFabrication
                                                                        .toString()
                                                            : "Date premiere  immatriculatione: " +
                                                                widget.car!
                                                                    .dateFirstFabrication
                                                                    .toString()
                                                        : "Date premiere  immatriculatione: " +
                                                            widget.demand!.car!
                                                                .dateFirstFabrication
                                                                .toString(),
                                                    textAlign: TextAlign.start))
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.settings,
                                              color: Color(0xFF468ACE),
                                            ),
                                            AllText.text(
                                                fontsize: 10,
                                                color: Colors.black,
                                                FontWeight: FontWeight.w400,
                                                text: widget.demand == null
                                                    ? widget.car == null
                                                        ? widget.rent == null
                                                            ? ''
                                                            : widget
                                                                .rent!
                                                                .rentDemand!
                                                                .car!
                                                                .motor
                                                                .toString()
                                                        : widget.car!.motor
                                                            .toString()
                                                    : widget.demand!.car!.motor
                                                        .toString()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 20,
                                              height: 20,
                                              child: SvgPicture.asset(
                                                "assets/images/settingBlue.svg",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            AllText.text(
                                                fontsize: 10,
                                                color: Colors.black,
                                                FontWeight: FontWeight.w400,
                                                text: widget.demand == null
                                                    ? widget.car == null
                                                        ? widget.rent == null
                                                            ? ''
                                                            : widget
                                                                .rent!
                                                                .rentDemand!
                                                                .car!
                                                                .gearboxType
                                                                .toString()
                                                        : widget
                                                            .car!.gearboxType
                                                            .toString()
                                                    : widget.demand!.car!
                                                        .gearboxType
                                                        .toString()),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 20,
                                              height: 20,
                                              child: Image.asset(
                                                "assets/images/porte.png",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            AllText.text(
                                                fontsize: 10,
                                                color: Colors.black,
                                                FontWeight: FontWeight.w400,
                                                text: widget.demand == null
                                                    ? widget.car == null
                                                        ? widget.rent == null
                                                            ? ''
                                                            : widget
                                                                .rent!
                                                                .rentDemand!
                                                                .car!
                                                                .doorsNumber
                                                                .toString()
                                                        : widget
                                                            .car!.doorsNumber
                                                            .toString()
                                                    : widget.demand!.car!
                                                        .doorsNumber
                                                        .toString()),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 20,
                                              height: 20,
                                              child: SvgPicture.asset(
                                                "assets/images/place.svg",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            AllText.text(
                                                fontsize: 10,
                                                color: Colors.black,
                                                FontWeight: FontWeight.w400,
                                                text: widget.demand == null
                                                    ? widget.car == null
                                                        ? widget.rent == null
                                                            ? ''
                                                            : widget
                                                                .rent!
                                                                .rentDemand!
                                                                .car!
                                                                .seatsNumber
                                                                .toString()
                                                        : widget
                                                            .car!.seatsNumber
                                                            .toString()
                                                    : widget.demand!.car!
                                                        .seatsNumber
                                                        .toString()),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 20,
                                              height: 20,
                                              child: SvgPicture.asset(
                                                "assets/images/vitesseBlue.svg",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            AllText.text(
                                                fontsize: 10,
                                                color: Colors.black,
                                                FontWeight: FontWeight.w400,
                                                text: widget.demand == null
                                                    ? widget.car == null
                                                        ? widget.rent == null
                                                            ? ''
                                                            : widget
                                                                .rent!
                                                                .rentDemand!
                                                                .car!
                                                                .mileage
                                                                .toString()
                                                        : widget.car!.mileage
                                                            .toString()
                                                    : widget
                                                        .demand!.car!.mileage
                                                        .toString()),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                        Border.all(color: Color(0xFF2E805D)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: AllText.text(
                                          fontsize: 14,
                                          color: Colors.black,
                                          FontWeight: FontWeight.w700,
                                          text: "Équipements  et les options"),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Wrap(
                                      alignment: WrapAlignment.center,
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: [
                                        if (widget.car != null) ...{
                                          for (int i = 0;
                                              i <
                                                  widget
                                                      .car!
                                                      .equipmentAndOptions!
                                                      .length;
                                              i++) ...{
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8, horizontal: 8),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Color(0xFF468ACE)),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              child: AllText.text(
                                                  fontsize: 14,
                                                  color: Color(0xFF468ACE),
                                                  FontWeight: FontWeight.w500,
                                                  text: widget.demand == null
                                                      ? widget.car == null
                                                          ? widget.rent == null
                                                              ? ''
                                                              : widget
                                                                  .rent!
                                                                  .rentDemand!
                                                                  .car!
                                                                  .equipmentAndOptions![
                                                                      i]
                                                                  .toString()
                                                          : widget
                                                              .car!
                                                              .equipmentAndOptions![
                                                                  i]
                                                              .toString()
                                                      : widget
                                                          .demand!
                                                          .car!
                                                          .equipmentAndOptions![
                                                              i]
                                                          .toString()),
                                            ),
                                          }
                                        } else if (widget.demand != null) ...{
                                          for (int i = 0;
                                              i <
                                                  widget
                                                      .demand!
                                                      .car!
                                                      .equipmentAndOptions!
                                                      .length;
                                              i++) ...{
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8, horizontal: 8),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Color(0xFF468ACE)),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              child: AllText.text(
                                                  fontsize: 14,
                                                  color: Color(0xFF468ACE),
                                                  FontWeight: FontWeight.w500,
                                                  text: widget.demand == null
                                                      ? widget.car == null
                                                          ? widget.rent == null
                                                              ? ''
                                                              : widget
                                                                  .rent!
                                                                  .rentDemand!
                                                                  .car!
                                                                  .equipmentAndOptions![
                                                                      i]
                                                                  .toString()
                                                          : widget
                                                              .car!
                                                              .equipmentAndOptions![
                                                                  i]
                                                              .toString()
                                                      : widget
                                                          .demand!
                                                          .car!
                                                          .equipmentAndOptions![
                                                              i]
                                                          .toString()),
                                            ),
                                          }
                                        } else if (widget.rent != null) ...{
                                          for (int i = 0;
                                              i <
                                                  widget
                                                      .rent!
                                                      .rentDemand!
                                                      .car!
                                                      .equipmentAndOptions!
                                                      .length;
                                              i++) ...{
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8, horizontal: 8),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Color(0xFF468ACE)),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              child: AllText.text(
                                                  fontsize: 14,
                                                  color: Color(0xFF468ACE),
                                                  FontWeight: FontWeight.w500,
                                                  text: widget.demand == null
                                                      ? widget.car == null
                                                          ? widget.rent == null
                                                              ? ''
                                                              : widget
                                                                  .rent!
                                                                  .rentDemand!
                                                                  .car!
                                                                  .equipmentAndOptions![
                                                                      i]
                                                                  .toString()
                                                          : widget
                                                              .car!
                                                              .equipmentAndOptions![
                                                                  i]
                                                              .toString()
                                                      : widget
                                                          .demand!
                                                          .car!
                                                          .equipmentAndOptions![
                                                              i]
                                                          .toString()),
                                            ),
                                          }
                                        },
                                      ],
                                    ),
                                  ],
                                )),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: AllText.text(
                                          fontsize: 14,
                                          color: Colors.black,
                                          FontWeight: FontWeight.w700,
                                          text: "Restriction"),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Color(0xFFEBF6F0),
                                          border: Border.all(
                                              color: Color(0xFF2E805D)),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4))),
                                      child: AllText.text(
                                          fontsize: 12,
                                          color: Colors.black,
                                          FontWeight: FontWeight.w400,
                                          text: widget.demand == null
                                              ? widget.car == null
                                                  ? widget.rent == null
                                                      ? ''
                                                      : widget.rent!.rentDemand!
                                                          .car!.restriction
                                                          .toString()
                                                  : widget.car!.restriction
                                                      .toString()
                                              : widget.demand!.car!.restriction
                                                  .toString()),
                                    )
                                  ],
                                )),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: AllText.text(
                                          fontsize: 14,
                                          color: Colors.black,
                                          FontWeight: FontWeight.w700,
                                          text: "Description"),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Color(0xFFEDE7F6),
                                          border: Border.all(
                                              color: Color(0xFF2E805D)),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4))),
                                      child: AllText.text(
                                          fontsize: 12,
                                          color: Colors.black,
                                          FontWeight: FontWeight.w400,
                                          text: widget.demand == null
                                              ? widget.car == null
                                                  ? widget.rent == null
                                                      ? ''
                                                      : widget.rent!.rentDemand!
                                                          .car!.description
                                                          .toString()
                                                  : widget.car!.description
                                                      .toString()
                                              : widget.demand!.car!.description
                                                  .toString()),
                                    )
                                  ],
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              if (widget.rent != null) ...{
                if ((widget.user.currentMode == Constants.ModeProprietaire &&
                        widget.rent!.status == "Crée") ||
                    (widget.user.currentMode == Constants.ModeLocataire &&
                        widget.rent!.status == "Acceptée")) ...{
// status : acc or reject

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 8),
                            decoration: BoxDecoration(
                                color: Color(0xFF5AAA85),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: AllText.text(
                                fontsize: 12,
                                color: Colors.white,
                                FontWeight: FontWeight.w700,
                                text: (widget.demand!.status == "Crée"
                                    ? "Accepter"
                                    : "Confirmer"))),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 8),
                            decoration: BoxDecoration(
                                color: Color(0xFFD62F41),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: AllText.text(
                              fontsize: 12,
                              color: Colors.white,
                              FontWeight: FontWeight.w700,
                              text: (widget.demand!.status == "Crée"
                                  ? "Refuser"
                                  : "Annuler"),
                            ))
                      ],
                    ),
                  ),
                } else if (widget.user.currentMode ==
                        Constants.ModeProprietaire &&
                    widget.rent!.status == "COMPLETED") ...{
                  // status : valider ou nn

                  Column(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(
                            color: Color(0xFF0062A2).withOpacity(0.2),
                            border: Border.all(color: Color(0xFF0062A2)),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Color(0xFF0062A2),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.62,
                                child: AllText.text(
                                    textAlign: TextAlign.start,
                                    fontsize: 14,
                                    color: Color(0xFF0062A2),
                                    FontWeight: FontWeight.w400,
                                    text:
                                        "Validation pour la récupération de votre voiture. Vous avez le choix de validation ou de refuser cette récupération."))
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                if (widget.user.currentMode ==
                                    Constants.ModeProprietaire) {
                                  final response =
                                      await ApiMethode.RequestMethode(
                                    endPoint:
                                        "http://10.0.2.2:8080/rent/"+widget.rent!.id!+"/status",
                                    body: {},
                                    jwt: widget.user.jwtToken!,
                                    para: 'status=VALIDATED' ,
                                       
                                    type: "PATCH",
                                  );
                                  MesLocation.MesVoitureController.emit(MesvoitureInitial()) ; 
                                  Navigator.pop(context);
                                    Allpups.succsess(context, "Validation avec succés") ;
                                //  MesDemande.MesDemandeController.emit(MesDemandeInitial());
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 8),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xFF288331)),
                                    color: Color(0xFF288331).withOpacity(0.2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                child: AllText.text(
                                    fontsize: 12,
                                    color: Color(0xFF288331),
                                    FontWeight: FontWeight.w700,
                                    text: "Valider"),
                              ),
                            ),

                            GestureDetector(
                              onTap: ()async {
                                  if (widget.user.currentMode ==
                                    Constants.ModeProprietaire) {
                                  final response =
                                      await ApiMethode.RequestMethode(
                                    endPoint:
                                        "http://10.0.2.2:8080/rent/"+widget.rent!.id!+"/status",
                                    body: {},
                                    jwt: widget.user.jwtToken!,
                                    para: 'status=UNVALIDATED' ,
                                       
                                    type: "PATCH",
                                  );
                                }
                              
                                MesLocation.MesVoitureController.emit(MesvoitureInitial()) ; 
                                  Navigator.pop(context);
                                    Allpups.succsess(context, "Invalidation") ; 
                                //  MesDemande.MesDemandeController.emit(MesDemandeInitial());
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 8),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xFFD62F41)),
                                    color: Color(0xFFD62F41).withOpacity(0.2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                child: AllText.text(
                                    fontsize: 12,
                                    color: Color(0xFFD62F41),
                                    FontWeight: FontWeight.w700,
                                    text: "Non Valider"),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                } else if (widget.user.currentMode == Constants.ModeLocataire &&
                    widget.rent!.status == "CREATED") ...{
                  // status: payment
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(color: Color(0xFFFBC02D)),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline_rounded,
                                color: Color(0xFFFBC02D),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: AllText.text(
                                  fontsize: 14,
                                  color: Color(0xFFFBC02D),
                                  FontWeight: FontWeight.w400,
                                  text:
                                      "N'oubliez pas de transférer le paiement au propriétaire, s'il vous plaît.",
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height:
                              8, // Add a height for the SizedBox to properly space elements
                        ),
                        GestureDetector(
                          onTap: () async {
                            await ApiMethode.RequestMethode(
                              endPoint: "http://10.0.2.2:8080/payments/pay/" +
                                  widget.rent!.id!,
                              body: {},
                              jwt: widget.user.jwtToken!,
                              para: "amount=" +
                                  widget.rent!.rentDemand!.price.toString(),
                              type: "POST",
                            );
                           MesVoiture.MesVoitureController.emit(MesVoitureInitial());
                            Navigator.pop(context);
                            Allpups.succsess(
                                context, 'Paiement fait avec succès');
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            decoration: BoxDecoration(
                              color: Color(0xFF75A68D),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              border: Border.all(color: Color(0xFF75A68D)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: AllText.text(
                                    fontsize: 14,
                                    color: Colors.white,
                                    FontWeight: FontWeight.w400,
                                    text: "Paiement",
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Icon(
                                  Icons.notification_important_outlined,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                },
              } else if (widget.demand != null) ...{
                if ((widget.user.currentMode == Constants.ModeProprietaire &&
                        widget.demand!.status == "Crée") ||
                    (widget.user.currentMode == Constants.ModeLocataire &&
                        widget.demand!.status == "Acceptée")) ...{
// status : acc or reject
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            if (widget.user.currentMode ==
                                Constants.ModeProprietaire) {
                              final response = await ApiMethode.RequestMethode(
                                endPoint:
                                    "http://10.0.2.2:8080/api/rentdemands/status",
                                body: {},
                                jwt: widget.user.jwtToken!,
                                para: 'rendemandId=' +
                                    widget.demand!.rentDemandIdentifier
                                        .toString() +
                                    '&event=ACCEPTE',
                                type: "PATCH",
                              );

                              MesDemande.MesDemandeController.emit(
                                  MesDemandeInitial());
                              Navigator.pop(context);
                              Allpups.succsess(
                                  context, 'Demande acceptée avec succès');
                            } else if (widget.user.currentMode ==
                                Constants.ModeLocataire) {
                              final response = await ApiMethode.RequestMethode(
                                endPoint:
                                    "http://10.0.2.2:8080/api/rentdemands/status",
                                body: {},
                                jwt: widget.user.jwtToken!,
                                para: 'rendemandId=' +
                                    widget.demand!.rentDemandIdentifier
                                        .toString() +
                                    '&event=CONFIRME',
                                type: "PATCH",
                              );
                              MesLocation.MesVoitureController.emit(
                                  MesvoitureInitial());
                              // MesDemande.MesDemandeController.emit( MesDemandeInitial() );
                              Navigator.pop(context);
                              Allpups.succsess(
                                  context, 'Demande confirmée avec succès');
                            }
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 8),
                              decoration: BoxDecoration(
                                  color: Color(0xFF5AAA85),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: AllText.text(
                                  fontsize: 12,
                                  color: Colors.white,
                                  FontWeight: FontWeight.w700,
                                  text: (widget.demand!.status == "Crée"
                                      ? "Accepter"
                                      : "Confirmer"))),
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (widget.user.currentMode ==
                                Constants.ModeProprietaire) {
                              final response = await ApiMethode.RequestMethode(
                                endPoint:
                                    "http://10.0.2.2:8080/api/rentdemands/status",
                                body: {},
                                jwt: widget.user.jwtToken!,
                                para: 'rendemandId=' +
                                    widget.demand!.rentDemandIdentifier
                                        .toString() +
                                    '&event=REFUSE',
                                type: "PATCH",
                              );
                              MesDemande.MesDemandeController.emit(
                                  MesDemandeInitial());
                              Navigator.pop(context);
                              Allpups.succsess(
                                  context, 'Demande refusée');
                            } else if (widget.user.currentMode ==
                                Constants.ModeLocataire) {
                              final response = await ApiMethode.RequestMethode(
                                endPoint:
                                    "http://10.0.2.2:8080/api/rentdemands/status",
                                body: {},
                                jwt: widget.user.jwtToken!,
                                para: 'rendemandId=' +
                                    widget.demand!.rentDemandIdentifier
                                        .toString() +
                                    '&event=CANCEL',
                                type: "PATCH",
                              );
                              MesDemande.MesDemandeController.emit(
                                  MesDemandeInitial());
                              Navigator.pop(context);
                              Allpups.succsess(
                                  context, 'Demande refusée');
                            }
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 8),
                              decoration: BoxDecoration(
                                  color: Color(0xFFD62F41),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: AllText.text(
                                fontsize: 12,
                                color: Colors.white,
                                FontWeight: FontWeight.w700,
                                text: (widget.demand!.status == "Crée"
                                    ? "Refuser"
                                    : "Annuler"),
                              )),
                        )
                      ],
                    ),
                  ),
                } else if (widget.user.currentMode ==
                        Constants.ModeProprietaire &&
                    widget.demand!.status == "COMPLETED") ...{
                  // status : valider ou nn

                  Column(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(
                            color: Color(0xFF0062A2).withOpacity(0.2),
                            border: Border.all(color: Color(0xFF0062A2)),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Color(0xFF0062A2),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.62,
                                child: AllText.text(
                                    textAlign: TextAlign.start,
                                    fontsize: 14,
                                    color: Color(0xFF0062A2),
                                    FontWeight: FontWeight.w400,
                                    text:
                                        "Validation pour la récupération de votre voiture. Vous avez le choix de validation ou de refuser cette récupération."))
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 8),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFF288331)),
                                  color: Color(0xFF288331).withOpacity(0.2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: AllText.text(
                                  fontsize: 12,
                                  color: Color(0xFF288331),
                                  FontWeight: FontWeight.w700,
                                  text: "Valider"),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 8),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFFD62F41)),
                                  color: Color(0xFFD62F41).withOpacity(0.2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: AllText.text(
                                  fontsize: 12,
                                  color: Color(0xFFD62F41),
                                  FontWeight: FontWeight.w700,
                                  text: "Non Valider"),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                } else if (widget.user.currentMode == Constants.ModeLocataire &&
                    (widget.demand!.status == "CREATED" ||
                        widget.demand!.status == "UPDATED")) ...{
                  // status : resreve
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        AuthButtons(
                          radius: 6,
                          firstColor: Color(0xFF2576B9),
                          onTap: () {},
                          text: 'Réserver',
                          width: double.infinity,
                          outlinedButton: false,
                          secondColor: Color(0xFF592FAA),
                        )
                      ],
                    ),
                  ),
                } else if (widget.user.currentMode == Constants.ModeLocataire &&
                    widget.demand!.status == "CREATED") ...{
                  // status: payment

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(color: Color(0xFFFBC02D)),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline_rounded,
                                color: Color(0xFFFBC02D),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: AllText.text(
                                  fontsize: 14,
                                  color: Color(0xFFFBC02D),
                                  FontWeight: FontWeight.w400,
                                  text:
                                      "N'oubliez pas de transférer le paiement au propriétaire, s'il vous plaît.",
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height:
                              8, // Add a height for the SizedBox to properly space elements
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          decoration: BoxDecoration(
                            color: Color(0xFF75A68D),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(color: Color(0xFF75A68D)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: AllText.text(
                                  fontsize: 14,
                                  color: Colors.white,
                                  FontWeight: FontWeight.w400,
                                  text: "Paiement",
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Icon(
                                Icons.notification_important_outlined,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                },
              } else if (widget.car != null) ...{
                if ((widget.user.currentMode == Constants.ModeProprietaire &&
                        widget.car!.status == "Crée") ||
                    (widget.user.currentMode == Constants.ModeLocataire &&
                        widget.car!.status == "Acceptée")) ...{
// status : acc or reject
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 8),
                            decoration: BoxDecoration(
                                color: Color(0xFF5AAA85),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: AllText.text(
                                fontsize: 12,
                                color: Colors.white,
                                FontWeight: FontWeight.w700,
                                text: (widget.car!.status == "Crée"
                                    ? "Accepter"
                                    : "Confirmer"))),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 8),
                            decoration: BoxDecoration(
                                color: Color(0xFFD62F41),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: AllText.text(
                              fontsize: 12,
                              color: Colors.white,
                              FontWeight: FontWeight.w700,
                              text: (widget.car!.status == "Crée"
                                  ? "Refuser"
                                  : "Annuler"),
                            ))
                      ],
                    ),
                  ),
                } else if (widget.user.currentMode ==
                        Constants.ModeProprietaire &&
                    widget.car!.status == "COMPLETED") ...{
                  // status : valider ou nn

                  Column(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(
                            color: Color(0xFF0062A2).withOpacity(0.2),
                            border: Border.all(color: Color(0xFF0062A2)),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Color(0xFF0062A2),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.62,
                                child: AllText.text(
                                    textAlign: TextAlign.start,
                                    fontsize: 14,
                                    color: Color(0xFF0062A2),
                                    FontWeight: FontWeight.w400,
                                    text:
                                        "Validation pour la récupération de votre voiture. Vous avez le choix de validation ou de refuser cette récupération."))
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                if (widget.user.currentMode ==
                                    Constants.ModeProprietaire) {
                                  final response =
                                      await ApiMethode.RequestMethode(
                                    endPoint:
                                        "http://10.0.2.2:8080/api/rentdemands/status",
                                    body: {},
                                    jwt: widget.user.jwtToken!,
                                    para: 'rendemandId=' +
                                        widget.demand!.rentDemandIdentifier
                                            .toString() +
                                        '&event=REFUSE',
                                    type: "PATCH",
                                  );
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 8),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xFF288331)),
                                    color: Color(0xFF288331).withOpacity(0.2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                child: AllText.text(
                                    fontsize: 12,
                                    color: Color(0xFF288331),
                                    FontWeight: FontWeight.w700,
                                    text: "Valider"),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 8),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFFD62F41)),
                                  color: Color(0xFFD62F41).withOpacity(0.2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: AllText.text(
                                  fontsize: 12,
                                  color: Color(0xFFD62F41),
                                  FontWeight: FontWeight.w700,
                                  text: "Non Valider"),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                } else if (widget.user.currentMode == Constants.ModeLocataire &&
                    (widget.car!.status == "CREATED" ||
                        widget.car!.status == "UPDATED")) ...{
                  // status : resreve

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        AuthButtons(
                          radius: 6,
                          firstColor: Color(0xFF2576B9),
                          onTap: () async {
                            final response = await ApiMethode.RequestMethode(
                              endPoint:
                                  "http://10.0.2.2:8080/api/rentdemands/details",
                              body: {},
                              jwt: widget.user.jwtToken!,
                              para: 'carId=' + widget.car!.carId.toString(),
                              type: "GET",
                            );
                            if (response != "") {
                              Map<String, dynamic> result =
                                  json.decode(response);

                              DateTime combinedDateTimeStart = DateTime(
                                  FiltreState.StartDate!.year,
                                  FiltreState.StartDate!.month,
                                  FiltreState.StartDate!.day,
                                  FiltreState.StartTime!.hour,
                                  FiltreState.StartTime!.minute,
                                  53);
                              DateTime combinedDateTimeEnd = DateTime(
                                  FiltreState.DueDate!.year,
                                  FiltreState.DueDate!.month,
                                  FiltreState.DueDate!.day,
                                  FiltreState.DueTime!.hour,
                                  FiltreState.DueTime!.minute,
                                  17);
                                    print(result['rentDemandIdentifier']+"this is the rent id ") ;
                                     print( DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(combinedDateTimeEnd)) ;
                                    print(DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(combinedDateTimeStart)) ;

                              final respons = await ApiMethode.RequestMethode(
                                endPoint:
                                    "http://10.0.2.2:8080/api/rentdemands/propose",
                                body: {
                                 "begin": DateFormat("yyyy-MM-dd'T'HH:mm").format(combinedDateTimeStart)+":40.215Z",
                                 "end": DateFormat("yyyy-MM-dd'T'HH:mm").format(combinedDateTimeEnd)+":40.215Z"
                                  // "begin": "2024-09-30T12:37:40.215Z",
 // "end": "2024-10-01T12:37:40.215Z"
                                },
                                jwt: widget.user.jwtToken!,
                                para: 'rentDemandIdentifier=' +
                                    result['rentDemandIdentifier'],
                                type: "PATCH",
                              );
                            }
                            FiltreState.search.text = "" ; 
                            FiltreState.StartTime = null ; 
                            FiltreState.DueTime = null ; 
                            FiltreState.StartDate =null ; 
                            FiltreState.DueDate = null ; 
                            MesDemande.MesDemandeController.emit(
                                MesDemandeInitial());
                            Navigator.pop(context);
                            Allpups.succsess(
                                context, 'Voiture reservée avec succès');
                          },
                          text: 'Réserver',
                          width: double.infinity,
                          outlinedButton: false,
                          secondColor: Color(0xFF592FAA),
                        )
                      ],
                    ),
                  ),
                } else if (widget.user.currentMode == Constants.ModeLocataire &&
                    widget.car!.status == "CREATED") ...{
                  // status: payment

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(color: Color(0xFFFBC02D)),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline_rounded,
                                color: Color(0xFFFBC02D),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: AllText.text(
                                  fontsize: 14,
                                  color: Color(0xFFFBC02D),
                                  FontWeight: FontWeight.w400,
                                  text:
                                      "N'oubliez pas de transférer le paiement au propriétaire, s'il vous plaît.",
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height:
                              8, // Add a height for the SizedBox to properly space elements
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          decoration: BoxDecoration(
                            color: Color(0xFF75A68D),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(color: Color(0xFF75A68D)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: AllText.text(
                                  fontsize: 14,
                                  color: Colors.white,
                                  FontWeight: FontWeight.w400,
                                  text: "Paiement",
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Icon(
                                Icons.notification_important_outlined,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                },
              },
              SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
