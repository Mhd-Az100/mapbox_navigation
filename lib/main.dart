import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:get/get.dart';
import 'package:mapbox_navigation/bind.dart';
import 'package:mapbox_navigation/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await dotenv.load(fileName: "assets/config/.env");
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeView(),
      initialBinding: HomeBinding(),
      theme: ThemeData(
        primaryColor: Colors.black,
        textTheme: const TextTheme(
            button: TextStyle(fontSize: 15, fontFamily: 'UBERMOVETEXT')),
      ),
    ),
  );
}
