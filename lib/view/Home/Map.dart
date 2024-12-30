import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:pickcar/DataClass/car.dart';
import 'package:pickcar/DataClass/user.dart';
import 'package:pickcar/Tools/ApiMethode.dart';
import 'package:pickcar/view/DetailPage/DetailPage.dart';
import 'package:pickcar/view/Home/bloc/MapBloc/bloc/maps_blocc_bloc.dart';
import 'package:pickcar/view/widgets/Filtre/flitre.dart';
import 'package:pickcar/view/widgets/Filtre/selectdateWidget.dart/Selectdate.dart';
import 'package:pickcar/view/widgets/bottomSheet/AllButtomSheet.dart';
import 'package:pickcar/view/widgets/text/text.dart';

class Mapss extends StatefulWidget {
  final User user;
  static MapsBloccBloc mapBloc = MapsBloccBloc();

  const Mapss({super.key, required this.user});

  @override
  State<Mapss> createState() => MapsState();
}

class MapsState extends State<Mapss> {
  MapController mapController = MapController();
  double currentZoom = 2.0; // Set a reasonable initial zoom level

  void _zoomIn() {
    setState(() {
      if (currentZoom < 19) {
        // Max zoom level
        currentZoom += 1;
        mapController.move(LatLng(33.5036797, 11.1097173), currentZoom);
      }
    });
    print("Zooming in to level $currentZoom");
  }

  void _zoomOut() {
    setState(() {
      if (currentZoom > 1) {
        // Min zoom level
        currentZoom -= 1;
        mapController.move(LatLng(33.5036797, 11.1097173), currentZoom);
      }
    });
    print("Zooming out to level $currentZoom");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<MapsBloccBloc, MapsBloccState>(
          bloc: Mapss.mapBloc,
          builder: (context, state) {
            if (state is MapsBloccInitial) {
              return Stack(
                children: [
                  FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                      initialCenter:
                          LatLng(33.5036797, 11.1097173), // Center the map
                      initialZoom: currentZoom,
                      onTap: (tapPosition, point) {
                        print("Map tapped at $point");
                      },
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // OSMF's Tile Server
                        userAgentPackageName: 'com.example.app',
                        maxNativeZoom: 19,
                      ),
                      MarkerLayer(
                        markers: [
                          // Marker(
                          //   width: 80,
                          //   // height: 80,
                          //   point: LatLng(33.5036797,
                          //       11.1097173), // Specify the marker position
                          //   child: GestureDetector(
                          //       onTap: () async {
                          //         // Trigger data load or another action here
                          //       },
                          //       child: Container(
                          //           decoration: BoxDecoration(
                          //             color: Color(0xFF2576B9),
                          //             borderRadius: BorderRadius.all(
                          //                 Radius.circular(15.0)),
                          //           ),
                          //           alignment: Alignment.center,
                          //           padding:
                          //               EdgeInsets.symmetric(horizontal: 12),
                          //           child: AllText.text(
                          //               fontsize: 14,
                          //               color: Colors.white,
                          //               FontWeight: FontWeight.normal,
                          //               text: "100 TND"))
                          //               ),
                          // ),
                        ],
                      ),
                      RichAttributionWidget(
                        attributions: [
                          TextSourceAttribution(
                            'OpenStreetMap contributors',
                          ),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Column(
                      children: [
                        FloatingActionButton(
                          onPressed: _zoomIn,
                          child: Icon(Icons.zoom_in),
                        ),
                        SizedBox(height: 10),
                        FloatingActionButton(
                          onPressed: _zoomOut,
                          child: Icon(Icons.zoom_out),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 12),
                    child: Filtre(
                      user: widget.user,
                      open: true,
                    ),
                  ),
                ],
              );
            } else if (state is Carsloaded) {
               WidgetsBinding.instance
        .addPostFrameCallback((_)  { 
          if(state.cars.isNotEmpty) {
          mapController.move(LatLng(state.cars[0].lat!, state.cars[0].lon!), 12);  
          }
        });
              return Stack(
                children: [
                  FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                      initialCenter:
                          LatLng(33.5036797, 11.1097173), // Center the map
                      initialZoom: 0.4,
                      onTap: (tapPosition, point) {
                        print("Map tapped at $point");
                      },
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // OSMF's Tile Server
                        userAgentPackageName: 'com.example.app',
                        maxNativeZoom: 19,
                      ),
                      MarkerLayer(
                        markers: [
                          // Marker(
                          //   width: 80,
                          //   height: 80,
                          //   point: LatLng(33.5036797, 11.1097173), // Specify the marker position
                          //   child: GestureDetector(
                          //     onTap: () async {
                          //       // Trigger data load or another action here
                          //     },
                          //     child: Image.network(
                          //       'https://www.outsystems.com/Forge_CW/_image.aspx/Q8LvY--6WakOw9afDCuuGe-t7X7L-vNg1x-YalsnXlg=/google-map-location-picker-web-sample-app-2023-01-04%2000-00-00-2024-06-05%2010-14-50',
                          //       width: 50,
                          //       height: 50,
                          //       fit: BoxFit.cover,
                          //     ),
                          //   ),
                          // ),
                          for (int i = 0; i < state.cars.length; i++)
                            Marker(
                              width: 50,
                              height: 30,
                              point: LatLng(
                                  state.cars[i].lat!,
                                  state.cars[i]
                                      .lon!), // Specify the marker position
                              child: GestureDetector(
                                onTap: () async {
                                   if(FiltreState.StartDate != null &&  FiltreState.DueDate != null &&  FiltreState.StartTime !=null && FiltreState.DueTime != null  ) {
                          Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>DetailPage(user: widget.user, car: state.cars[i],)),
  );
                          }else {
                             AllBottomSheet.FunBottomSheet(
                        context, SelectDateBottomSheet());
                          }
                                  // Trigger data load or another action here
                                },
                                child: Container(
                                 // height: 30,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF2576B9),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                    ),
                                    alignment: Alignment.center,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 6),
                                    child: AllText.text(
                                        fontsize: 12,
                                        color: Colors.white,
                                        FontWeight: FontWeight.normal,
                                        text: state.cars[i].pricePerHour.toString()+ "€/H"))
                              ),
                            ),
                        ],
                      ),
                      RichAttributionWidget(
                        attributions: [
                          TextSourceAttribution(
                            'OpenStreetMap contributors',
                          ),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Column(
                      children: [
                        FloatingActionButton(
                          onPressed: _zoomIn,
                          child: Icon(Icons.zoom_in),
                        ),
                        SizedBox(height: 10),
                        FloatingActionButton(
                          onPressed: _zoomOut,
                          child: Icon(Icons.zoom_out),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 12),
                    child: Filtre(
                      user: widget.user,
                      open: true,
                    ),
                  ),
                ],
              );
            }
            // Handle other states of the BLoC
            return Container();
          },
        ),
      ),
    );
  }
}
