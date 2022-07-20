import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapbox_navigation/mapbox_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: Get.width,
      height: Get.height,
      child: const MapBoxView(),
    ));
  }
}
