import 'dart:convert';

import 'package:flutter/services.dart';

const MapBoxUrl =
    "https://api.mapbox.com/styles/v1/mohamed2001/cl57w8ym0000l14rt9d5b5yn3/tiles/256/{z}/{x}/{y}@2x?access_token=sk.eyJ1IjoibW9oYW1lZDIwMDEiLCJhIjoiY2w1ODFvazV2MGwzazNobnJnM3d0cGdldSJ9.XJYECsB-U2e7SeMH4oyRig";
const MapBoxToken =
    "pk.eyJ1IjoibW9oYW1lZDIwMDEiLCJhIjoiY2ttdGZoODl2MHIzYjJ2bzZoNjY1ZDRkbyJ9.ND2ExV1fwxQtUChZ-RaBvQ";

const String _CONFIG_FILE_PATH = 'assets/config.json';
Future<Map<String, dynamic>> loadConfigFile() async {
  String json = await rootBundle.loadString(_CONFIG_FILE_PATH);
  return jsonDecode(json) as Map<String, dynamic>;
}
