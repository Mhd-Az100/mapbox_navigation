import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mapbox_navigation/helpers/mapbox_handler.dart';
import 'package:mapbox_navigation/helpers/shared_prefs.dart';
import 'package:mapbox_navigation/main.dart';

class MapBoxController extends GetxController {
  MapboxMapController? mapBoxController;
  CameraPosition? cameraposition;

  //*defaultCamera init when map open
  CameraPosition? initialCameraPosition = const CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(33.513955806825116, 36.27653013833866),
      zoom: 12);

  //*stream var
  StreamSubscription<Position>? ps;

  //* get permission for get current location
  Future getPermission() async {
    bool services;
    LocationPermission per;
    services = await Geolocator.isLocationServiceEnabled();
    if (services == false) {
      AwesomeDialog(context: Get.context!, title: 'please check the location')
          .show();
    }
    per = await Geolocator.checkPermission();
    if (per == LocationPermission.denied) {
      per = await Geolocator.requestPermission();
    }
    return per;
  }

  //*========== save current location in sharedprefrences method and call in movecamera
  Future<Position?> saveCurrentLatLng() async {
    //* current position variables
    Position? currentLocation;
    double? currentlat;
    double? currentlng;
    currentLocation =
        await Geolocator.getCurrentPosition().then((value) => value);
    LatLng currentlatlng =
        LatLng(currentLocation!.latitude, currentLocation.longitude);
    currentlat = currentLocation.latitude;
    currentlng = currentLocation.longitude;
    // Get the current user address
    String currentAddress =
        (await getParsedReverseGeocoding(currentlatlng))['place'];

    // Store the user location in sharedPreferences
    sharedPreferences.setDouble('latitude', currentlat);
    sharedPreferences.setDouble('longitude', currentlng);
    sharedPreferences.setString('current-address', currentAddress);
    //
    cameraposition =
        CameraPosition(target: LatLng(currentlat, currentlng), zoom: 16);
    mapBoxController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: currentlatlng, zoom: 15, tilt: 30.440717697143555),
      ),
    );
    update();
    return currentLocation;
  }

  moveCameraToCurrentPosition() {
    print(sharedPreferences.getString('current-address'));
    print(sharedPreferences.getDouble('latitude'));
    print(sharedPreferences.getDouble('longitude'));
    LatLng? currentlatlng;
    currentlatlng = getCurrentLatLngFromSharedPrefs();
    LatLng latLng = LatLng(currentlatlng.latitude, currentlatlng.longitude);

    mapBoxController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: 15, tilt: 50.440717697143555),
      ),
    );

    update();
  }

  @override
  void onInit() async {
    // setMarkerCustom(); //*---- set marker with custom shape
    await getPermission(); //* get per when init ctrl
    await saveCurrentLatLng(); //* get current location when init ctrl

    //!====required call stream in initiliing controller
    // ps = Geolocator.getPositionStream().listen((Position? position) {
    //! call change marker to give it new position with live stream calling
    // changeMarkerPostition(position?.latitude, position?.longitude);
    // });
    super.onInit();
  }

  //*====size marker lolipop animation
  var sizeMarker = 50.0.obs;
}
