import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:taxi_gogo/Controllers/auth_controller.dart';
class UpdateLocationController extends GetxController {
  late double latitude;
  late double longitude;
final auth=Get.find<AuthController>();
  Future<void> getLocation() async {
    print("auth.user?.userId");
    print(auth.user?.userId);
    String driver_id = auth.user?.userId.toString()??"";
    print(driver_id);
    LocationPermission permission;
    bool servicesEnabled;
    servicesEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!servicesEnabled) {
    //   return Future.error("Your location services are disabled");
    // }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Your location permissions are denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          "Location permissions are permanently denied, we cannot request permissions.");
    }
    print('going to get the location');
    permission = await Geolocator.requestPermission();
    try {
      LocationSettings locationSetting = const LocationSettings(
        // accuracy: LocationAccuracy.bestForNavigation,
     distanceFilter: 3,
         timeLimit: Duration(seconds: 30),
      );
      StreamSubscription<Position> positionStream =
      Geolocator.getPositionStream(locationSettings: locationSetting)
          .listen(
            (Position? position) async {
          latitude = position!.latitude;
          longitude = position.longitude;
          print(latitude);
          print(longitude);
          print('going to firebase object >>>>>>>>>>>>>>>>');
          print(driver_id);
          await FirebaseFirestore.instance
              .collection('driver_location')
              .doc(driver_id)
              .set({
            'latitude': latitude,
            'longitude': longitude,
            'id':driver_id,
          });
          print('firebase update location');
        },
      );
    } catch (e)
    // ignore: empty_catches
        {}
  }
}
