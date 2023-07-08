import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:get/get.dart';

import 'Controllers/auth_controller.dart';
import 'Controllers/update_location_controller.dart';
import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class TimerSet extends StatefulWidget {
  TimerSet({Key? key}) : super(key: key);

  @override
  State<TimerSet> createState() => _TimerSetState();
}

class _TimerSetState extends State<TimerSet> {
  final auth = Get.find<AuthController>();
  double latitude = 0.0;
  double longitude = 0.0;
  int a = 0;

  @override
  void initState() {
    getLocation();
    // int a = 1;
    // // TODO: implement initState
    // Timer.periodic(Duration(seconds: 10), (timer) {
    //
    //   a = a + 1;
    //   print("???????????????????????????????????$a");
    // });
    super.initState();
  }

  Future<void> getLocation() async {
    print("auth.user?.userId");
    print(auth.user?.userId);
    String driver_id = auth.user?.userId.toString() ?? "";
    print(driver_id);
    LocationPermission permission;
    bool servicesEnabled;
    servicesEnabled = await Geolocator.isLocationServiceEnabled();
    if (!servicesEnabled) {
      return Future.error("Your location services are disabled");
    }
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
       // distanceFilter: 0,
        // timeLimit: Duration(seconds: 3),
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
          a++;
          setState(() {});
          await FirebaseFirestore.instance
              .collection('driver_location')
              .doc("10")
              .set({
            'latitude': latitude,
            'longitude': longitude,
            'id':"10",
          });
          print('firebase update location');
        },
      );
    } catch (e)
    // ignore: empty_catches
    {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Lat${latitude}"),
            Text("Lng${longitude}"),
            Text("A$a"),
          ],
        ),
      ),
      // body: ListView.builder(
      //     itemCount: 5,
      //     itemBuilder: (context,index){
      //   return TimerCountdown(
      //     format: CountDownTimerFormat.secondsOnly,
      //     enableDescriptions: false,
      //     endTime: DateTime.now().add(
      //    const   Duration(
      //         minutes: 1,
      //       ),
      //     ),
      //     onEnd: () {
      //       print("Timer finished");
      //     },
      //   );
      // }),
    );
  }
}
