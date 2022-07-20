import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:get/get.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mapbox_navigation/mapbox_controller.dart';
import 'package:mapbox_navigation/turn_by_turn.dart';

class MapBoxView extends GetView<MapBoxController> {
  const MapBoxView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GetBuilder<MapBoxController>(
          builder: (c) {
            return MapboxMap(
              accessToken: dotenv.env['MAPBOX_ACCESS_TOKEN'],
              initialCameraPosition: c.initialCameraPosition!,
              onMapCreated: (MapboxMapController ctrl) {
                c.mapBoxController = ctrl;
              },
              // myLocationTrackingMode: MyLocationTrackingMode.TrackingCompass,
              // minMaxZoomPreference: const MinMaxZoomPreference(11, 11),
              zoomGesturesEnabled: true,
              myLocationEnabled: true,
              // myLocationRenderMode: MyLocationRenderMode.COMPASS,
              compassEnabled: true,
              tiltGesturesEnabled: true,
              dragEnabled: true,
              doubleClickZoomEnabled: true,
              rotateGesturesEnabled: true,
              scrollGesturesEnabled: true,
              trackCameraPosition: true,
            );
          },
        ),
        Positioned(
          top: 50,
          right: 20,
          child: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              controller.moveCameraToCurrentPosition();
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(top: 0, left: 20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 7,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(
                Icons.location_searching_rounded,
                color: Colors.grey[800],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 50,
          right: 20,
          child: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const TurnByTurn()));
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(top: 0, left: 20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 7,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(
                Icons.navigation_rounded,
                color: Colors.grey[800],
              ),
            ),
          ),
        )
      ],
    );
  }
}
