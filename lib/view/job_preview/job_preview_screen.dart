import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi_gogo/Controllers/home_controller.dart';
import 'package:taxi_gogo/components/custom_card.dart';
import 'package:taxi_gogo/components/custom_text.dart';
import 'package:get/get.dart';
import '../../Controllers/auth_controller.dart';
import '../../const/app_color.dart';
import 'dart:async';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:location/location.dart';
import 'dart:math' show cos, sqrt, asin;
import 'dart:math' as Math;

class JobPreview extends StatefulWidget {
  JobPreview({Key? key}) : super(key: key);

  @override
  State<JobPreview> createState() => _JobPreviewState();
}
class _JobPreviewState extends State<JobPreview> {
  final homeCont = Get.put(HomeController());
  final aut = Get.put(AuthController());
  GoogleMapController? _controller;
  Map<PolylineId, Polyline> polyLines = {};
  Location location = Location();
  Marker? sourcePosition, destinationPosition;
  List<Marker> markers=[];
  loc.LocationData? _currentPosition;
  LatLng curLocation = LatLng(30.09697855707855, 71.85671899434175);
  StreamSubscription<loc.LocationData>? locationSubscription;
  List<PolylineWayPoint> polylineWayPointAddress = [];
  List<LatLng> latLonViaList = [];
  LatLngBounds? _bounds;
  double _zoom = 10.0;
  @override
  void initState() {
    // TODO: implement initState

    homeCont.rideDetails?.value.data?.destinationVia?.forEach((element) {
      polylineWayPointAddress.add(PolylineWayPoint(location: element.destinationAddressVia??""));
    });
    homeCont.rideDetails?.value.data?.destinationVia?.forEach((element) {
      latLonViaList.add(LatLng(
          double.parse(element.destinationViaLatitude??"30.09697855707855"),
          double.parse(element.destinationViaLongitude ?? "71.85671899434175")
      ));
    });
    curLocation = LatLng(
        double.parse(homeCont.rideDetails?.value.data?.pickupLatitude??"30.09697855707855"),
         double.parse(homeCont.rideDetails?.value.data?.pickupLongitude ?? "71.85671899434175")
        // double.parse("30.09697855707855"),
        // double.parse("71.85671899434175"));
    );
    addMarker();
    getNavigation();

    super.initState();
  }

  void addMarker() {
    markers.add(Marker(
        markerId: const MarkerId("Source"),
        position: curLocation,
        icon:
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        infoWindow: InfoWindow(
            title:
            "PickUp Address:${homeCont.rideDetails?.value.data?.pickupAddress}")));
    setState(() {
      latLonViaList.forEach((element) {
        markers.add(Marker(
          markerId: const MarkerId("Stay"),
          position: element,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ));
      });
      markers.add(Marker(
          infoWindow: InfoWindow(
              title:
              "Destination Address:${homeCont.rideDetails?.value.data?.destinationAddress}"),
          markerId: const MarkerId("Destination"),
          position: LatLng(
            // double.parse("30.09697855707855"),
            // double.parse("71.85671899434175")
              double.parse(homeCont.rideDetails?.value.data?.destinationLatitude ??
                  "30.09697855707855"),
              double.parse(homeCont.rideDetails?.value.data?.destinationLongitude ??
                  "71.85671899434175")
          ),
          icon:
          BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan)));
      sourcePosition = Marker(
          markerId: const MarkerId("Source"),
          position: curLocation,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          infoWindow: InfoWindow(
              title:
                  "PickUp Address:${homeCont.rideDetails?.value.data?.pickupAddress}"));
      destinationPosition = Marker(
          infoWindow: InfoWindow(
              title:
                  "Destination Address:${homeCont.rideDetails?.value.data?.destinationAddress}"),
          markerId: const MarkerId("Destination"),
          position: LatLng(
              // double.parse("30.09697855707855"),
              // double.parse("71.85671899434175")
                      double.parse(homeCont.rideDetails?.value.data?.destinationLatitude ??
                          "30.09697855707855"),
              double.parse(homeCont.rideDetails?.value.data?.destinationLongitude ??
                          "71.85671899434175")
              ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan));
    });
   _updateBounds();
  //  _updateZoom();
  }
  void _updateBounds() {
    double minLat = double.infinity;
    double maxLat = -double.infinity;
    double minLng = double.infinity;
    double maxLng = -double.infinity;

    for (Marker marker in markers) {
      double lat = marker.position.latitude;
      double lng = marker.position.longitude;

      if (lat < minLat) minLat = lat;
      if (lat > maxLat) maxLat = lat;
      if (lng < minLng) minLng = lng;
      if (lng > maxLng) maxLng = lng;
    }
print("????????????????????Bounds/////////////////////");
    _bounds = LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
    print("????????????????????Bounds1/////////////////////");
  }

  void _updateZoom() {
    if (_bounds != null&&_controller !=null) {
      print("??????????????????Good??????????????????");
      _controller?.animateCamera(CameraUpdate.newLatLngBounds(_bounds!, 70.0));
   setState(() {

   });
    }
  }
  // void _updateBounds() {
  //   _bounds = LatLngBounds.fromList(markers);
  // }
  // void _updateZoom() {
  //   if (_bounds != null && _controller != null) {
  //     _controller?.getVisibleRegion().then((visibleRegion) {
  //       double newZoom = _getBoundsZoomLevel(_bounds!, visibleRegion);
  //       setState(() {
  //         _zoom = newZoom;
  //       });
  //     });
  //   }
  // }
  // double _getBoundsZoomLevel(LatLngBounds bounds, LatLngBounds visibleRegion) {
  //   final double maxZoomLevel = 20.0;
  //   double zoomLevel = 0.0;
  //
  //   double westDiff = bounds.southwest.longitude - visibleRegion.southwest.longitude;
  //   double eastDiff = visibleRegion.northeast.longitude - bounds.northeast.longitude;
  //   double lonSpan = bounds.northeast.longitude - bounds.southwest.longitude;
  //
  //   double latFraction = (bounds.northeast.latitude - bounds.southwest.latitude) / 360.0;
  //   double lonFraction = (westDiff + eastDiff) / lonSpan;
  //
  //   double latZoom = _zoomLevel(Math.log(latFraction) / Math.log(2));
  //   double lonZoom = _zoomLevel(Math.log(lonFraction) / Math.log(2));
  //
  //   zoomLevel = Math.min(latZoom, lonZoom);
  //   return zoomLevel;
  // }
  //
  // double _zoomLevel(double fraction) {
  //   return (20.0 - fraction).clamp(0.0, 20.0);
  // }


  Future<void> getNavigation() async {
    final GoogleMapController? controller = await _controller;
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
        distanceFilter: 100,
        // timeLimit: Duration(minutes: 1),
      );
      //  Geolocator.getPositionStream(locationSettings: locationSetting)
      //         .listen(
      //   (Position? position) async {
      //     curLocation = LatLng(position!.latitude, position.longitude);
      //     controller?.animateCamera(CameraUpdate.newCameraPosition(
      //         CameraPosition(
      //             target: LatLng(position.latitude, position.longitude),
      //             zoom: 14.0)));
      //     if (mounted) {
      //       controller?.showMarkerInfoWindow(
      //           MarkerId(sourcePosition!.markerId.value));
      //       setState(() {
      //         curLocation = LatLng(position.latitude, position.longitude);
      //         sourcePosition = Marker(
      //             markerId: MarkerId(position.toString()),
      //             position: LatLng(position.latitude, position.longitude),
      //             icon: BitmapDescriptor.defaultMarkerWithHue(
      //                 BitmapDescriptor.hueAzure),
      //
      //             // infoWindow: InfoWindow(
      //             //     title: double.parse(
      //             //             getDistance(LatLng(widget.lat!, widget.long!))
      //             //                 .toStringAsFixed(2))
      //             //         .toString(),
      //             //     onTap: () {
      //             //       print("Marker Id");
      //             //     }));
      //             infoWindow: InfoWindow(title: "Chack 105/10.r"));
      //       });
      //
      //     }
      //   },
      // );
      getDirection(
        LatLng(
            double.parse(
                homeCont.rideDetails?.value.data?.destinationLatitude ??
                    "30.09697855707855"),
            double.parse(
                homeCont.rideDetails?.value.data?.destinationLongitude ??
                    "71.85671899434175")),
      );
    } catch (e)
    // ignore: empty_catches
    {}
  }

  Future<void> getDirection(LatLng latLng) async {
    List<LatLng> polyLineCoordinates = [];
    List<dynamic> points = [];
    PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
        "AIzaSyDe084ESzLxX0Pn2IHfmqAmDV96s19OVoU",
        PointLatLng(curLocation.latitude, curLocation.longitude),
        PointLatLng(latLng.latitude, latLng.longitude),
        travelMode: TravelMode.driving,
    wayPoints:polylineWayPointAddress
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        print("goooooood");
        polyLineCoordinates.add(LatLng(point.latitude, point.longitude));
        points.add({'lat': point.latitude, 'lng': point.longitude});
      });
    } else {
      print(result.errorMessage);
    }
    addPolyLine(polyLineCoordinates);
  }

  void addPolyLine(List<LatLng> polyLineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.red,
        points: polyLineCoordinates,
        width: 3);
    polyLines[id] = polyline;
    setState(() {});
  }

  double getDistance(LatLng latLng) {
    return calculateDistance(
        curLocation.latitude,
        curLocation.longitude,
        destinationPosition?.position.latitude,
        destinationPosition?.position.longitude);
  }

  double calculateDistance(double latitude, double longitude, double? latitude2,
      double? longitude2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((latitude2! - latitude) * p) / 2 +
        c(latitude * p) *
            c(latitude2 * p) *
            (1 - c((longitude2! - longitude) * p)) /
            2;
    return 12742 * asin(sqrt(a));
  }
@override
  void dispose() {
    // TODO: implement dispose
  _controller?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (cont) {
      return WillPopScope(
        onWillPop: () async {
          return await true;
        },
        child: Scaffold(
            body: Stack(
              children: [
                SizedBox(
                  height: 290.h,
                  width: double.infinity,
                  child: sourcePosition == null
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Stack(
                          children: [
                            GoogleMap(
                              zoomControlsEnabled: false,
                              polylines: Set<Polyline>.of(polyLines.values),
                              initialCameraPosition:
                                  CameraPosition(target: curLocation, zoom: _zoom),

                              markers:Set<Marker>.of(markers),
                              mapType: MapType.normal,
                              onMapCreated: (GoogleMapController controller) {
                                _controller=controller;
                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                 Timer(Duration(
                                   milliseconds: 500
                                 ), () { _updateZoom();});
                                                                  });

                              },
                            ),
                          ],
                        ),
                ),
                Positioned(
                  left: 20.w,
                  top: 40.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            Get.back();
                            },
                          child: const Icon(Icons.arrow_back_ios)),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 40.h),
                    child: cont.rideDetails?.value.data?.rideStatus == "Accepted"
                        ? CustomText(
                            text: "Ride Details",
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          )
                        : cont.rideDetails?.value.data?.rideStatus ==
                                "On route to customer"
                            ? CustomText(
                                text: "Ride Details",
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              )
                            : cont.rideDetails?.value.data?.rideStatus ==
                                    "Arrived"
                                ? CustomText(
                                    text: "Customer is coming",
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  )
                                : CustomText(
                                    text: "",
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                  ),
                ),
              ],
            ),
            bottomSheet: cont.rideDetails?.value.data?.rideStatus == "Accepted"
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () async {
                                if (cont.rideDetails?.value.data?.navigation !=
                                    "No") {
                                  var url = Uri.encodeFull(
                                      'https://www.google.com/maps/dir/?api=1&destination=${cont.rideDetails?.value.data?.pickupLatitude},${cont.rideDetails?.value.data?.pickupLongitude}');
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    print("Could not launch");
                                    throw 'Could not launch Maps';
                                  }
                                }
                              },
                              child: CustomCard(
                                height: 40.h,
                                width: 135.w,
                                cardColor: cont.rideDetails?.value.data?.navigation != "No"
                                    ? AppColors.kBlueColor
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(50.r),
                                cardChild: Padding(
                                  padding: EdgeInsets.all(10.r),
                                  child: Row(
                                    children: [
                                      Image.asset("assets/images/location.png"),
                                      SizedBox(width: 10.w),
                                      CustomText(
                                        text: "Navigate",
                                        fontSize: 16.sp,
                                        fontColor: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                final Uri phoneLaunchUri = Uri(
                                  scheme: 'tel',
                                  path: '${cont.rideDetails?.value.data?.phone}',
                                );
                                await launchUrl(phoneLaunchUri);
                              },
                              child: CircleAvatar(
                                backgroundColor: AppColors.kBlackColor,
                                radius: 20.r,
                                child: Icon(
                                  Icons.phone,
                                  size: 30.r,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      CustomCard(
                        height: 400.h,
                        width: double.maxFinite,
                        cardColor: Colors.white,
                        cardChild: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10.h),
                              Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(width: 70.w),
                                    CustomText(
                                      text: "Reference #",
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomText(
                                      text: cont.rideDetails?.value.data
                                              ?.referenceNo ??
                                          "N/A",
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      fontColor: AppColors.kGreenColor,
                                    ),
                                    SizedBox(width: 70.w),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: "Trip Price GBP : ${cont.rideDetails?.value.data?.bookingPrice ?? "N/A"}",
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w600,
                                        fontColor: AppColors.kRedColor,
                                      ),
                                      SizedBox(height: 5.h,),
                                      CustomText(
                                        text: "Driver amount GBP : ${cont.rideDetails?.value.data?.driverPrice ?? "N/A"}",
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w600,
                                        fontColor: AppColors.kBlueColor,
                                      ),

                                    ],
                                  ),
                                  Column(
                                    children: [
                                      CustomText(
                                        text: cont.rideDetails?.value.data
                                                ?.paymentStatus ??
                                            "N/A",
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        fontColor: AppColors.kGreenColor,
                                      ),
                                      CustomText(
                                        text: cont.rideDetails?.value.data
                                                ?.paymentType ??
                                            "N/A",
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        fontColor: AppColors.kGreenColor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text:
                                        "${cont.rideDetails?.value.data?.firstName} ${cont.rideDetails?.value.data?.lastName}",
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    fontColor: AppColors.kRedColor,
                                  ),
                                  CustomText(
                                    text: cont.rideDetails?.value.data?.phone ??
                                        "N/A",
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    fontColor: Colors.black.withOpacity(0.5),
                                  ),
                                ],
                              ),
                              Divider(height: 20.h, color: Colors.black),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: "Pickup Date",
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    fontColor: AppColors.kBlackColor,
                                  ),
                                  CustomText(
                                    text:
                                        "${cont.rideDetails?.value.data?.pickupDate}",
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    fontColor: Colors.black.withOpacity(0.5),
                                  ),
                                ],
                              ),
                              Divider(height: 20.h, color: Colors.black),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: "Pickup Time",
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    fontColor: AppColors.kBlackColor,
                                  ),
                                  CustomText(
                                    text: cont.rideDetails?.value.data
                                            ?.pickupTime ??
                                        "N/A",
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    fontColor: Colors.black.withOpacity(0.5),
                                  ),
                                ],
                              ),
                              Divider(height: 20.h, color: Colors.black),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: "Passengers:",
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    fontColor: AppColors.kBlackColor,
                                  ),
                                  CustomText(
                                    text: cont.rideDetails?.value.data?.passengers
                                            .toString() ??
                                        "N/A",
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    fontColor: Colors.black.withOpacity(0.5),
                                  ),
                                ],
                              ),
                              Divider(height: 20.h, color: Colors.black),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: "Luggage:",
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    fontColor: AppColors.kBlackColor,
                                  ),
                                  CustomText(
                                    text: cont.rideDetails?.value.data?.luggage
                                            .toString() ??
                                        "N/A",
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    fontColor: Colors.black.withOpacity(0.5),
                                  ),
                                ],
                              ),
                              Divider(height: 20.h, color: Colors.black),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: "Comments",
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    fontColor: AppColors.kBlackColor,
                                  ),
                                  SizedBox(height: 10.h),
                                  SizedBox(
                                    width: 335.w,
                                    child: CustomText(
                                      text: cont.rideDetails?.value.data
                                              ?.comments ??
                                          "N/A",
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      fontColor: AppColors.kBlackColor,
                                    ),
                                  ),
                                  SizedBox(height: 20.h),
                                  CustomCard(
                                    width: double.maxFinite,
                                    cardColor: Colors.white,
                                    borderRadius: BorderRadius.circular(20.r),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          spreadRadius: 0.2,
                                          blurRadius: 15)
                                    ],
                                    cardChild: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w, vertical: 25.h),
                                      child:  IntrinsicHeight(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  children: [
                                                    Padding(
                                                      padding:  EdgeInsets.only(right:4.0.w),
                                                      child: Icon(
                                                        Icons.location_on,
                                                        size: 20.r,
                                                        color: AppColors.kGreenColor,
                                                      ),
                                                    ),
                                                    SizedBox(height: 2.h,),
                                                    Column(
                                                      children: List.generate(
                                                        (((cont.rideDetails?.value.data?.pickupAddress?.length??0)*2)~/25)+5,
                                                            (i) => Padding(
                                                            padding: EdgeInsets.only(
                                                                left: 8.w,
                                                                right: 12.w,
                                                                top: 3.h
                                                            ),
                                                            child: Container(
                                                              height: 5.h,
                                                              width: 2.w,
                                                              color: Colors.grey,
                                                            )),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                      width: 250.w,
                                                      child: CustomText(
                                                        text: cont.rideDetails?.value.data?.pickupAddress ??
                                                            "N/A",
                                                        fontSize: 16.sp,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 250.w,
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          CustomText(
                                                            text: "Pickup Distance: ",
                                                            fontSize: 14.sp,
                                                            fontWeight: FontWeight.w600,
                                                            fontColor: const Color(0xff2E8FF7),
                                                          ),
                                                          SizedBox(
                                                            width: 138.w,
                                                            child: CustomText(
                                                              text: "${cont.rideDetails?.value.data?.driverPickupDistance??0} miles away",
                                                              fontSize: 14.sp,
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: List.generate(
                                                cont.rideDetails?.value.data?.destinationVia
                                                    ?.length ??
                                                    0,
                                                    (index) {
                                                  final waitData =   cont.rideDetails?.value.data?.destinationVia?[index];
                                                  return Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          SizedBox(height: 5.h,),
                                                          Padding(
                                                            padding:  EdgeInsets.only(right:3.0.w),
                                                            child: Image.asset(
                                                              "assets/images/waitLocation.png",
                                                              color: Colors.black,
                                                              height:18.h,
                                                              width: 18.w,
                                                            ),
                                                          ),
                                                          SizedBox(height: 2.h,),
                                                          Column(
                                                            children: List.generate(
                                                              (((waitData?.destinationAddressVia?.length??0)*2)~/25)+5,
                                                                  (i) => Padding(
                                                                  padding: EdgeInsets.only(
                                                                    left: 8.5.w,
                                                                    right: 12.w,
                                                                    top: 3.h,
                                                                  ),
                                                                  child: Container(
                                                                    height: 5.h,
                                                                    width: 2.w,
                                                                    color: Colors.grey,
                                                                  )),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          SizedBox(height: 5.h,),
                                                          SizedBox(
                                                            width: 250.w,
                                                            child: CustomText(
                                                              text: waitData
                                                                  ?.destinationAddressVia ??
                                                                  "N/A",
                                                              fontSize: 16.sp,
                                                              fontWeight: FontWeight.bold,
                                                              overflow: TextOverflow.visible,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 3.h,
                                                          ),
                                                          SizedBox(
                                                            width: 250.w,
                                                            child: CustomText(
                                                              text:
                                                              "Stay Time: ${waitData?.stayTime ?? "0"} minutes",
                                                              fontColor:
                                                              const Color(0xffF40D04),
                                                              fontSize: 13.sp,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10.h,
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  children: [
                                                    SizedBox(height: 5.h,),
                                                    Padding(
                                                      padding:  EdgeInsets.only(right:4.0.w),
                                                      child: Icon(
                                                        Icons.location_on,
                                                        size: 20.r,
                                                        color: Colors.black.withOpacity(0.5),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    SizedBox(height: 5.h,),
                                                    SizedBox(
                                                      width: 250.w,
                                                      child: CustomText(
                                                        text: cont.rideDetails?.value.data?.destinationAddress ??
                                                            "N/A",
                                                        fontSize: 16.sp,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 250.w,
                                                      child: Row(
                                                        children: [
                                                          CustomText(
                                                            text: "Drop Off Distance: ",
                                                            fontSize: 14.sp,
                                                            fontWeight: FontWeight.w600,
                                                            fontColor: const Color(0xff2E8FF7),
                                                          ),

                                                          CustomText(
                                                            text: "${cont.rideDetails?.value.data?.calculativeDistance.toString()} miles away",
                                                            fontSize: 14.sp,
                                                            fontWeight: FontWeight.w400,
                                                            overflow: TextOverflow.visible,
                                                          ),
                                                        ],
                                                      ),
                                                    ),


                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10.h),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 100.h),
                                  CustomButton(
                                      height: 40.h,
                                      width: double.maxFinite,
                                      buttonColor: AppColors.kPrimaryColor,
                                      borderRadius: BorderRadius.circular(10),
                                      onTap: () {
                                        cont.rideIdStatus =
                                            cont.rideDetails?.value.data?.id;
                                        cont.statusType = 2;
                                        print(cont.rideIdStatus);
                                        cont.updateRideStatus();
                                      },
                                      child: Center(
                                        child: CustomText(
                                          text: "On route to customer",
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                          fontColor: AppColors.kBlackColor,
                                        ),
                                      )),
                                  SizedBox(height: 10.h),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : cont.rideDetails?.value.data?.rideStatus ==
                        "On route to customer"
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    if (cont.rideDetails?.value.data
                                            ?.navigation !=
                                        "No") {
                                      var url = Uri.encodeFull(
                                          'https://www.google.com/maps/dir/?api=1&destination=${cont.rideDetails?.value.data?.pickupLatitude},${cont.rideDetails?.value.data?.pickupLongitude}');
                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      } else {
                                        print("Could not launch");
                                        throw 'Could not launch Maps';
                                      }
                                    }
                                  },
                                  child: CustomCard(
                                    height: 40.h,
                                    width: 135.w,
                                    cardColor: cont.rideDetails?.value.data?.navigation ! != "No"
                                        ? AppColors.kBlueColor
                                        : Colors.grey,
                                    borderRadius: BorderRadius.circular(50.r),
                                    cardChild: Padding(
                                      padding: EdgeInsets.all(10.r),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                              "assets/images/location.png"),
                                          SizedBox(width: 10.w),
                                          CustomText(
                                            text: "Navigate",
                                            fontSize: 16.sp,
                                            fontColor: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    final Uri phoneLaunchUri = Uri(
                                      scheme: 'tel',
                                      path:
                                          '${cont.rideDetails?.value.data?.phone}',
                                    );
                                    await launchUrl(phoneLaunchUri);
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.kBlackColor,
                                    radius: 20.r,
                                    child: Icon(
                                      Icons.phone,
                                      size: 30.r,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h),
                          CustomCard(
                            height: 400.h,
                            width: double.maxFinite,
                            cardColor: Colors.white,
                            cardChild: SingleChildScrollView(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // CustomText(
                                  //   text: "PickUp: 3.5km",
                                  //   fontSize: 12.sp,
                                  //   fontWeight: FontWeight.bold,
                                  // ),
                                  SizedBox(height: 10.h),
                                  Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(width: 70.w),
                                        CustomText(
                                          text: "Reference #",
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        CustomText(
                                          text: cont.rideDetails?.value.data
                                                  ?.referenceNo ??
                                              "N/A",
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                          fontColor: AppColors.kGreenColor,
                                        ),
                                        SizedBox(width: 70.w),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            text: "Trip Price GBP : ${cont.rideDetails?.value.data?.bookingPrice ?? "N/A"}",
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w600,
                                            fontColor: AppColors.kRedColor,
                                          ),
                                          SizedBox(height: 5.h,),
                                          CustomText(
                                            text: "Driver amount GBP : ${cont.rideDetails?.value.data?.driverPrice ?? "N/A"}",
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w600,
                                            fontColor: AppColors.kBlueColor,
                                          ),

                                        ],
                                      ),
                                      Column(
                                        children: [
                                          CustomText(
                                            text: cont.rideDetails?.value.data
                                                    ?.paymentStatus ??
                                                "N/A",
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                            fontColor: AppColors.kGreenColor,
                                          ),
                                          CustomText(
                                            text: cont.rideDetails?.value.data
                                                    ?.paymentType ??
                                                "N/A",
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                            fontColor: AppColors.kGreenColor,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        text:
                                            "${cont.rideDetails?.value.data?.firstName} ${cont.rideDetails?.value.data?.lastName}",
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        fontColor: AppColors.kRedColor,
                                      ),
                                      CustomText(
                                        text:
                                            cont.rideDetails?.value.data?.phone ??
                                                "N/A",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        fontColor: Colors.black.withOpacity(0.5),
                                      ),
                                    ],
                                  ),
                                  Divider(height: 20.h, color: Colors.black),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        text: "Pickup Date",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        fontColor: AppColors.kBlackColor,
                                      ),
                                      CustomText(
                                        text:
                                            "${cont.rideDetails!.value.data?.pickupDate}",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        fontColor: Colors.black.withOpacity(0.5),
                                      ),
                                    ],
                                  ),
                                  Divider(height: 20.h, color: Colors.black),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        text: "Pickup Time",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        fontColor: AppColors.kBlackColor,
                                      ),
                                      CustomText(
                                        text: cont.rideDetails?.value.data
                                                ?.pickupTime ??
                                            "N/A",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        fontColor: Colors.black.withOpacity(0.5),
                                      ),
                                    ],
                                  ),
                                  Divider(height: 20.h, color: Colors.black),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        text: "Passengers:",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        fontColor: AppColors.kBlackColor,
                                      ),
                                      CustomText(
                                        text: cont.rideDetails?.value.data
                                                ?.passengers
                                                .toString() ??
                                            "N/A",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        fontColor: Colors.black.withOpacity(0.5),
                                      ),
                                    ],
                                  ),
                                  Divider(height: 20.h, color: Colors.black),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        text: "Luggage:",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        fontColor: AppColors.kBlackColor,
                                      ),
                                      CustomText(
                                        text: cont
                                                .rideDetails?.value.data?.luggage
                                                .toString() ??
                                            "N/A",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        fontColor: Colors.black.withOpacity(0.5),
                                      ),
                                    ],
                                  ),
                                  Divider(height: 20.h, color: Colors.black),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: "Comments",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        fontColor: AppColors.kBlackColor,
                                      ),
                                      SizedBox(height: 10.h),
                                      SizedBox(
                                        width: 335.w,
                                        child: CustomText(
                                          text: cont.rideDetails?.value.data
                                                  ?.comments ??
                                              "N/A",
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                          fontColor: AppColors.kBlackColor,
                                        ),
                                      ),
                                      SizedBox(height: 20.h),
                                      CustomCard(
                                        width: double.maxFinite,
                                        cardColor: Colors.white,
                                        borderRadius: BorderRadius.circular(20.r),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black.withOpacity(0.2),
                                              spreadRadius: 0.2,
                                              blurRadius: 15)
                                        ],
                                        cardChild: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.w, vertical: 25.h),
                                          child:  IntrinsicHeight(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Padding(
                                                          padding:  EdgeInsets.only(right:4.0.w),
                                                          child: Icon(
                                                            Icons.location_on,
                                                            size: 20.r,
                                                            color: AppColors.kGreenColor,
                                                          ),
                                                        ),
                                                        SizedBox(height: 2.h,),
                                                        Column(
                                                          children: List.generate(
                                                            (((cont.rideDetails?.value.data?.pickupAddress?.length??0)*2)~/25)+5,
                                                                (i) => Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: 8.w,
                                                                    right: 12.w,
                                                                    top: 3.h
                                                                ),
                                                                child: Container(
                                                                  height: 5.h,
                                                                  width: 2.w,
                                                                  color: Colors.grey,
                                                                )),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        SizedBox(
                                                          width: 250.w,
                                                          child: CustomText(
                                                            text: cont.rideDetails?.value.data?.pickupAddress ??
                                                                "N/A",
                                                            fontSize: 16.sp,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 250.w,
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              CustomText(
                                                                text: "Pickup Distance: ",
                                                                fontSize: 14.sp,
                                                                fontWeight: FontWeight.w600,
                                                                fontColor: const Color(0xff2E8FF7),
                                                              ),
                                                              SizedBox(
                                                                width: 138.w,
                                                                child: CustomText(
                                                                  text: "${cont.rideDetails?.value.data?.driverPickupDistance??0} miles away",
                                                                  fontSize: 14.sp,
                                                                  fontWeight: FontWeight.w400,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: List.generate(
                                                    cont.rideDetails?.value.data?.destinationVia
                                                        ?.length ??
                                                        0,
                                                        (index) {
                                                      final waitData =   cont.rideDetails?.value.data?.destinationVia?[index];
                                                      return Row(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              SizedBox(height: 5.h,),
                                                              Padding(
                                                                padding:  EdgeInsets.only(right:3.0.w),
                                                                child: Image.asset(
                                                                  "assets/images/waitLocation.png",
                                                                  color: Colors.black,
                                                                  height:18.h,
                                                                  width: 18.w,
                                                                ),
                                                              ),
                                                              SizedBox(height: 2.h,),
                                                              Column(
                                                                children: List.generate(
                                                                  (((waitData?.destinationAddressVia?.length??0)*2)~/25)+5,
                                                                      (i) => Padding(
                                                                      padding: EdgeInsets.only(
                                                                        left: 8.5.w,
                                                                        right: 12.w,
                                                                        top: 3.h,
                                                                      ),
                                                                      child: Container(
                                                                        height: 5.h,
                                                                        width: 2.w,
                                                                        color: Colors.grey,
                                                                      )),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            children: [
                                                              SizedBox(height: 5.h,),
                                                              SizedBox(
                                                                width: 250.w,
                                                                child: CustomText(
                                                                  text: waitData
                                                                      ?.destinationAddressVia ??
                                                                      "N/A",
                                                                  fontSize: 16.sp,
                                                                  fontWeight: FontWeight.bold,
                                                                  overflow: TextOverflow.visible,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 3.h,
                                                              ),
                                                              SizedBox(
                                                                width: 250.w,
                                                                child: CustomText(
                                                                  text:
                                                                  "Stay Time: ${waitData?.stayTime ?? "0"} minutes",
                                                                  fontColor:
                                                                  const Color(0xffF40D04),
                                                                  fontSize: 13.sp,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 10.h,
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                ),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        SizedBox(height: 5.h,),
                                                        Padding(
                                                          padding:  EdgeInsets.only(right:4.0.w),
                                                          child: Icon(
                                                            Icons.location_on,
                                                            size: 20.r,
                                                            color: Colors.black.withOpacity(0.5),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        SizedBox(height: 5.h,),
                                                        SizedBox(
                                                          width: 250.w,
                                                          child: CustomText(
                                                            text: cont.rideDetails?.value.data?.destinationAddress ??
                                                                "N/A",
                                                            fontSize: 16.sp,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 250.w,
                                                          child: Row(
                                                            children: [
                                                              CustomText(
                                                                text: "Drop Off Distance: ",
                                                                fontSize: 14.sp,
                                                                fontWeight: FontWeight.w600,
                                                                fontColor: const Color(0xff2E8FF7),
                                                              ),

                                                              CustomText(
                                                                text: "${cont.rideDetails?.value.data?.calculativeDistance.toString()} miles away"??
                                                                    "0 Km",
                                                                fontSize: 14.sp,
                                                                fontWeight: FontWeight.w400,
                                                                overflow: TextOverflow.visible,
                                                              ),
                                                            ],
                                                          ),
                                                        ),


                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10.h),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 100.h),
                                      CustomButton(
                                          height: 40.h,
                                          width: double.maxFinite,
                                          buttonColor: AppColors.kPrimaryColor,
                                          borderRadius: BorderRadius.circular(10),
                                          onTap: () {
                                            cont.rideIdStatus =
                                                cont.rideDetails?.value.data?.id;
                                            cont.statusType = 3;
                                            print(cont.rideIdStatus);
                                            cont.updateRideStatus();
                                          },
                                          child: Center(
                                            child: CustomText(
                                              text: "I’ve arrived",
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                              fontColor: AppColors.kBlackColor,
                                            ),
                                          )),
                                      SizedBox(height: 10.h),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : cont.rideDetails?.value.data?.rideStatus == "Arrived" &&
                            cont.rideDetails?.value.data?.paymentStatus ==
                                "Unpaid"
                        ? Container(
                            height: 475.h,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  const CustomText(
                                    text: "Have you Collected\nthe money?",
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  CustomText(
                                    text:
                                        "GBP:${homeCont.rideDetails?.value.data?.bookingPrice}",
                                    fontSize: 32,
                                    fontWeight: FontWeight.w600,
                                    fontColor: const Color(0xffF40D04),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  CustomText(
                                    text:
                                        "${homeCont.rideDetails?.value.data?.paymentType}",
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    fontColor: const Color(0xff2E8FF7),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.0.w),
                                    child:   CustomCard(
                                      width: double.maxFinite,
                                      cardColor: Colors.white,
                                      borderRadius: BorderRadius.circular(20.r),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black.withOpacity(0.2),
                                            spreadRadius: 0.2,
                                            blurRadius: 15)
                                      ],
                                      cardChild: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.w, vertical: 25.h),
                                        child:  IntrinsicHeight(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Padding(
                                                        padding:  EdgeInsets.only(right:4.0.w),
                                                        child: Icon(
                                                          Icons.location_on,
                                                          size: 20.r,
                                                          color: AppColors.kGreenColor,
                                                        ),
                                                      ),
                                                      SizedBox(height: 2.h,),
                                                      Column(
                                                        children: List.generate(
                                                          (((cont.rideDetails?.value.data?.pickupAddress?.length??0)*2)~/25)+5,
                                                              (i) => Padding(
                                                              padding: EdgeInsets.only(
                                                                  left: 8.w,
                                                                  right: 12.w,
                                                                  top: 3.h
                                                              ),
                                                              child: Container(
                                                                height: 5.h,
                                                                width: 2.w,
                                                                color: Colors.grey,
                                                              )),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      SizedBox(
                                                        width: 250.w,
                                                        child: CustomText(
                                                          text: cont.rideDetails?.value.data?.pickupAddress ??
                                                              "N/A",
                                                          fontSize: 16.sp,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 250.w,
                                                        child: Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            CustomText(
                                                              text: "Pickup Distance: ",
                                                              fontSize: 14.sp,
                                                              fontWeight: FontWeight.w600,
                                                              fontColor: const Color(0xff2E8FF7),
                                                            ),
                                                            SizedBox(
                                                              width: 138.w,
                                                              child: CustomText(
                                                                text: "${cont.rideDetails?.value.data?.driverPickupDistance??0} miles away",
                                                                fontSize: 14.sp,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: List.generate(
                                                  cont.rideDetails?.value.data?.destinationVia
                                                      ?.length ??
                                                      0,
                                                      (index) {
                                                    final waitData =   cont.rideDetails?.value.data?.destinationVia?[index];
                                                    return Row(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            SizedBox(height: 5.h,),
                                                            Padding(
                                                              padding:  EdgeInsets.only(right:3.0.w),
                                                              child: Image.asset(
                                                                "assets/images/waitLocation.png",
                                                                color: Colors.black,
                                                                height:18.h,
                                                                width: 18.w,
                                                              ),
                                                            ),
                                                            SizedBox(height: 2.h,),
                                                            Column(
                                                              children: List.generate(
                                                                (((waitData?.destinationAddressVia?.length??0)*2)~/25)+5,
                                                                    (i) => Padding(
                                                                    padding: EdgeInsets.only(
                                                                      left: 8.5.w,
                                                                      right: 12.w,
                                                                      top: 3.h,
                                                                    ),
                                                                    child: Container(
                                                                      height: 5.h,
                                                                      width: 2.w,
                                                                      color: Colors.grey,
                                                                    )),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            SizedBox(height: 5.h,),
                                                            SizedBox(
                                                              width: 250.w,
                                                              child: CustomText(
                                                                text: waitData
                                                                    ?.destinationAddressVia ??
                                                                    "N/A",
                                                                fontSize: 16.sp,
                                                                fontWeight: FontWeight.bold,
                                                                overflow: TextOverflow.visible,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 3.h,
                                                            ),
                                                            SizedBox(
                                                              width: 250.w,
                                                              child: CustomText(
                                                                text:
                                                                "Stay Time: ${waitData?.stayTime ?? "0"} minutes",
                                                                fontColor:
                                                                const Color(0xffF40D04),
                                                                fontSize: 13.sp,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 10.h,
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ),
                                              ),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    children: [
                                                      SizedBox(height: 5.h,),
                                                      Padding(
                                                        padding:  EdgeInsets.only(right:4.0.w),
                                                        child: Icon(
                                                          Icons.location_on,
                                                          size: 20.r,
                                                          color: Colors.black.withOpacity(0.5),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      SizedBox(height: 5.h,),
                                                      SizedBox(
                                                        width: 250.w,
                                                        child: CustomText(
                                                          text: cont.rideDetails?.value.data?.destinationAddress ??
                                                              "N/A",
                                                          fontSize: 16.sp,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 250.w,
                                                        child: Row(
                                                          children: [
                                                            CustomText(
                                                              text: "Drop Off Distance: ",
                                                              fontSize: 14.sp,
                                                              fontWeight: FontWeight.w600,
                                                              fontColor: const Color(0xff2E8FF7),
                                                            ),

                                                            CustomText(
                                                              text: "${cont.rideDetails?.value.data?.calculativeDistance.toString()} miles away"??
                                                                  "0 Km",
                                                              fontSize: 14.sp,
                                                              fontWeight: FontWeight.w400,
                                                              overflow: TextOverflow.visible,
                                                            ),
                                                          ],
                                                        ),
                                                      ),


                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10.h),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50.h,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.0.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomButton(
                                            height: 40.h,
                                            width: 150.w,
                                            buttonColor: AppColors.kPrimaryColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            onTap: () {
                                              homeCont.collectRidePayment();
                                            },
                                            child: Center(
                                              child: CustomText(
                                                text: "Collected",
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                fontColor: AppColors.kBlackColor,
                                              ),
                                            )),
                                        CustomButton(
                                            height: 40.h,
                                            width: 150.w,
                                            buttonColor: const Color(0xff01AED9),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder: (context) {
                                                    return Dialog(
                                                      child: SizedBox(
                                                        height: 85.h,
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      20.0.w,
                                                                  vertical: 10.h),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const CustomText(
                                                                text:
                                                                    "Are you sure you want to cancel this\nride?",
                                                              ),
                                                              SizedBox(
                                                                height: 10.w,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  InkWell(
                                                                    onTap: () {
                                                                      cont.rideId = homeCont
                                                                          .rideDetails
                                                                          ?.value
                                                                          .data
                                                                          ?.id;
                                                                      cont.cancelRide();
                                                                    },
                                                                    child:
                                                                        const CustomText(
                                                                      text: "Yes",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontColor:
                                                                          Color(
                                                                              0xff01AED9),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10.w,
                                                                  ),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      Get.back();
                                                                    },
                                                                    child:
                                                                        CustomText(
                                                                      text: "No",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontColor:
                                                                          Colors
                                                                              .black,
                                                                    ),
                                                                  )
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            },
                                            child: Center(
                                              child: CustomText(
                                                text: "No",
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                fontColor: Colors.white,
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : cont.rideDetails?.value.data?.rideStatus == "Arrived"
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            if (cont.rideDetails?.value.data
                                                    ?.navigation !=
                                                "No") {
                                              var url = Uri.encodeFull(
                                                  'https://www.google.com/maps/dir/?api=1&destination=${cont.rideDetails?.value.data?.destinationLatitude},${cont.rideDetails?.value.data?.destinationLongitude}');
                                              if (await canLaunch(url)) {
                                                await launch(url);
                                              } else {
                                                print("Could not launch");
                                                throw 'Could not launch Maps';
                                              }
                                            }
                                          },
                                          child: CustomCard(
                                            height: 40.h,
                                            width: 135.w,
                                            cardColor:
                                            cont.rideDetails?.value.data?.navigation != "No"
                                                    ? AppColors.kBlueColor
                                                    : Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(50.r),
                                            cardChild: Padding(
                                              padding: EdgeInsets.all(10.r),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                      "assets/images/location.png"),
                                                  SizedBox(width: 10.w),
                                                  CustomText(
                                                    text: "Navigate",
                                                    fontSize: 16.sp,
                                                    fontColor: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            final Uri phoneLaunchUri = Uri(
                                              scheme: 'tel',
                                              path:
                                              '${cont.rideDetails?.value.data?.phone}',
                                            );
                                            await launchUrl(phoneLaunchUri);
                                          },
                                          child: CircleAvatar(
                                            backgroundColor:
                                            AppColors.kBlackColor,
                                            radius: 20.r,
                                            child: Icon(
                                              Icons.phone,
                                              size: 30.r,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  CustomCard(
                                    height: 400.h,
                                    width: double.maxFinite,
                                    cardColor: Colors.white,
                                    cardChild: SingleChildScrollView(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 30.h,
                                          ),
                                          CustomCard(
                                            width: double.maxFinite,
                                            cardColor: Colors.white,
                                            borderRadius: BorderRadius.circular(20.r),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black.withOpacity(0.2),
                                                  spreadRadius: 0.2,
                                                  blurRadius: 15)
                                            ],
                                            cardChild: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.w, vertical: 25.h),
                                              child:  IntrinsicHeight(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Padding(
                                                              padding:  EdgeInsets.only(right:4.0.w),
                                                              child: Icon(
                                                                Icons.location_on,
                                                                size: 20.r,
                                                                color: AppColors.kGreenColor,
                                                              ),
                                                            ),
                                                            SizedBox(height: 2.h,),
                                                            Column(
                                                              children: List.generate(
                                                                (((cont.rideDetails?.value.data?.pickupAddress?.length??0)*2)~/25)+5,
                                                                    (i) => Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left: 8.w,
                                                                        right: 12.w,
                                                                        top: 3.h
                                                                    ),
                                                                    child: Container(
                                                                      height: 5.h,
                                                                      width: 2.w,
                                                                      color: Colors.grey,
                                                                    )),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            SizedBox(
                                                              width: 250.w,
                                                              child: CustomText(
                                                                text: cont.rideDetails?.value.data?.pickupAddress ??
                                                                    "N/A",
                                                                fontSize: 16.sp,
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 250.w,
                                                              child: Row(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  CustomText(
                                                                    text: "Pickup Distance: ",
                                                                    fontSize: 14.sp,
                                                                    fontWeight: FontWeight.w600,
                                                                    fontColor: const Color(0xff2E8FF7),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 138.w,
                                                                    child: CustomText(
                                                                      text: "${cont.rideDetails?.value.data?.driverPickupDistance??0} miles away",
                                                                      fontSize: 14.sp,
                                                                      fontWeight: FontWeight.w400,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: List.generate(
                                                        cont.rideDetails?.value.data?.destinationVia
                                                            ?.length ??
                                                            0,
                                                            (index) {
                                                          final waitData =   cont.rideDetails?.value.data?.destinationVia?[index];
                                                          return Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  SizedBox(height: 5.h,),
                                                                  Padding(
                                                                    padding:  EdgeInsets.only(right:3.0.w),
                                                                    child: Image.asset(
                                                                      "assets/images/waitLocation.png",
                                                                      color: Colors.black,
                                                                      height:18.h,
                                                                      width: 18.w,
                                                                    ),
                                                                  ),
                                                                  SizedBox(height: 2.h,),
                                                                  Column(
                                                                    children: List.generate(
                                                                      (((waitData?.destinationAddressVia?.length??0)*2)~/25)+5,
                                                                          (i) => Padding(
                                                                          padding: EdgeInsets.only(
                                                                            left: 8.5.w,
                                                                            right: 12.w,
                                                                            top: 3.h,
                                                                          ),
                                                                          child: Container(
                                                                            height: 5.h,
                                                                            width: 2.w,
                                                                            color: Colors.grey,
                                                                          )),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                children: [
                                                                  SizedBox(height: 5.h,),
                                                                  SizedBox(
                                                                    width: 250.w,
                                                                    child: CustomText(
                                                                      text: waitData
                                                                          ?.destinationAddressVia ??
                                                                          "N/A",
                                                                      fontSize: 16.sp,
                                                                      fontWeight: FontWeight.bold,
                                                                      overflow: TextOverflow.visible,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 3.h,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 250.w,
                                                                    child: CustomText(
                                                                      text:
                                                                      "Stay Time: ${waitData?.stayTime ?? "0"} minutes",
                                                                      fontColor:
                                                                      const Color(0xffF40D04),
                                                                      fontSize: 13.sp,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 10.h,
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            SizedBox(height: 5.h,),
                                                            Padding(
                                                              padding:  EdgeInsets.only(right:4.0.w),
                                                              child: Icon(
                                                                Icons.location_on,
                                                                size: 20.r,
                                                                color: Colors.black.withOpacity(0.5),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            SizedBox(height: 5.h,),
                                                            SizedBox(
                                                              width: 250.w,
                                                              child: CustomText(
                                                                text: cont.rideDetails?.value.data?.destinationAddress ??
                                                                    "N/A",
                                                                fontSize: 16.sp,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 250.w,
                                                              child: Row(
                                                                children: [
                                                                  CustomText(
                                                                    text: "Drop Off Distance: ",
                                                                    fontSize: 14.sp,
                                                                    fontWeight: FontWeight.w600,
                                                                    fontColor: const Color(0xff2E8FF7),
                                                                  ),

                                                                  CustomText(
                                                                    text: "${cont.rideDetails?.value.data?.calculativeDistance.toString()} miles away",
                                                                    fontSize: 14.sp,
                                                                    fontWeight: FontWeight.w400,
                                                                    overflow: TextOverflow.visible,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),


                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 10.h),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 100.h),
                                          CustomButton(
                                              height: 40.h,
                                              width: double.maxFinite,
                                              buttonColor:
                                                  AppColors.kPrimaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              onTap: () {
                                                cont.rideIdStatus = cont
                                                    .rideDetails?.value.data?.id;
                                                cont.statusType = 4;
                                                cont.startingPoint=cont
                                                    .rideDetails?.value.googleMapPoints?.startPointAddress??"";
                                                cont.endPoint=cont
                                                    .rideDetails?.value.googleMapPoints?.endPointAddress??"";
                                                print(cont.rideIdStatus);
                                                cont.updateRideStatus();
                                              },
                                              child: Center(
                                                child: CustomText(
                                                  text: "Start Trip",
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold,
                                                  fontColor:
                                                      AppColors.kBlackColor,
                                                ),
                                              )),
                                          SizedBox(height: 10.h),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            if (cont.rideDetails?.value.data
                                                    ?.navigation !=
                                                "No") {
                                              // String googleMapsUrl = 'https://www.google.com/maps/dir/?api=1&destination=${cont.rideDetails?.value.data?.destinationLatitude},${cont.rideDetails?.value.data?.destinationLongitude}';
                                              var url = Uri.encodeFull(
                                                  'https://www.google.com/maps/dir/?api=1&destination=${cont.rideDetails?.value.googleMapPoints?.startPointLatitude},${cont.rideDetails?.value.googleMapPoints?.startPointLongitude}');
                                              // var url = Uri.encodeFull(
                                              //     "https://www.google.com/maps/dir/api=1?q=${cont.rideDetails?.value.data?.destinationAddress}:${cont.rideDetails?.value.data?.destinationLatitude},${cont.rideDetails?.value.data?.destinationLongitude}");
                                               if (await canLaunch(url)) {
                                                await launch(url);
                                              } else {
                                                print("Could not launch");
                                                throw 'Could not launch Maps';
                                              }
                                            }
                                          },
                                          child: CustomCard(
                                            height: 40.h,
                                            width: 135.w,
                                            cardColor:
                                            cont.rideDetails?.value.data?.navigation  != "No"
                                                    ? AppColors.kBlueColor
                                                    : Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(50.r),
                                            cardChild: Padding(
                                              padding: EdgeInsets.all(10.r),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                      "assets/images/location.png"),
                                                  SizedBox(width: 10.w),
                                                  CustomText(
                                                    text: "Navigate",
                                                    fontSize: 16.sp,
                                                    fontColor: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            final Uri phoneLaunchUri = Uri(
                                              scheme: 'tel',
                                              path:
                                              '${cont.rideDetails?.value.data?.phone}',
                                            );
                                            await launchUrl(phoneLaunchUri);
                                          },
                                          child: CircleAvatar(
                                            backgroundColor:
                                            AppColors.kPrimaryColor,
                                            radius: 20.r,
                                            child: Icon(
                                              Icons.phone,
                                              size: 30.r,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  CustomCard(
                                    height: 400.h,
                                    width: double.maxFinite,
                                    cardColor: Colors.white,
                                    cardChild: SingleChildScrollView(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 30.h,
                                          ),
                                          CustomCard(
                                            width: double.maxFinite,
                                            cardColor: Colors.white,
                                            borderRadius: BorderRadius.circular(20.r),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black.withOpacity(0.2),
                                                  spreadRadius: 0.2,
                                                  blurRadius: 15)
                                            ],
                                            cardChild: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.w, vertical: 25.h),
                                              child:  IntrinsicHeight(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Padding(
                                                              padding:  EdgeInsets.only(right:4.0.w),
                                                              child: Icon(
                                                                Icons.location_on,
                                                                size: 20.r,
                                                                color: AppColors.kGreenColor,
                                                              ),
                                                            ),
                                                            SizedBox(height: 2.h,),
                                                            Column(
                                                              children: List.generate(
                                                                (((cont.rideDetails?.value.data?.pickupAddress?.length??0)*2)~/25)+5,
                                                                    (i) => Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left: 8.w,
                                                                        right: 12.w,
                                                                        top: 3.h
                                                                    ),
                                                                    child: Container(
                                                                      height: 5.h,
                                                                      width: 2.w,
                                                                      color: Colors.grey,
                                                                    )),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            SizedBox(
                                                              width: 250.w,
                                                              child: CustomText(
                                                                text: cont.rideDetails?.value.data?.pickupAddress ??
                                                                    "N/A",
                                                                fontSize: 16.sp,
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 250.w,
                                                              child: Row(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  CustomText(
                                                                    text: "Pickup Distance: ",
                                                                    fontSize: 14.sp,
                                                                    fontWeight: FontWeight.w600,
                                                                    fontColor: const Color(0xff2E8FF7),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 138.w,
                                                                    child: CustomText(
                                                                      text: "${cont.rideDetails?.value.data?.driverPickupDistance??0} miles away",
                                                                      fontSize: 14.sp,
                                                                      fontWeight: FontWeight.w400,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: List.generate(
                                                        cont.rideDetails?.value.data?.destinationVia
                                                            ?.length ??
                                                            0,
                                                            (index) {
                                                          final waitData =   cont.rideDetails?.value.data?.destinationVia?[index];
                                                          return Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  SizedBox(height: 5.h,),
                                                                  Padding(
                                                                    padding:  EdgeInsets.only(right:3.0.w),
                                                                    child: Image.asset(
                                                                      "assets/images/waitLocation.png",
                                                                      color: Colors.black,
                                                                      height:18.h,
                                                                      width: 18.w,
                                                                    ),
                                                                  ),
                                                                  SizedBox(height: 2.h,),
                                                                  Column(
                                                                    children: List.generate(
                                                                      (((waitData?.destinationAddressVia?.length??0)*2)~/25)+5,
                                                                          (i) => Padding(
                                                                          padding: EdgeInsets.only(
                                                                            left: 8.5.w,
                                                                            right: 12.w,
                                                                            top: 3.h,
                                                                          ),
                                                                          child: Container(
                                                                            height: 5.h,
                                                                            width: 2.w,
                                                                            color: Colors.grey,
                                                                          )),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                children: [
                                                                  SizedBox(height: 5.h,),
                                                                  SizedBox(
                                                                    width: 250.w,
                                                                    child: CustomText(
                                                                      text: waitData
                                                                          ?.destinationAddressVia ??
                                                                          "N/A",
                                                                      fontSize: 16.sp,
                                                                      fontWeight: FontWeight.bold,
                                                                      overflow: TextOverflow.visible,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 3.h,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 250.w,
                                                                    child: CustomText(
                                                                      text:
                                                                      "Stay Time: ${waitData?.stayTime ?? "0"} minutes",
                                                                      fontColor:
                                                                      const Color(0xffF40D04),
                                                                      fontSize: 13.sp,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 10.h,
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            SizedBox(height: 5.h,),
                                                            Padding(
                                                              padding:  EdgeInsets.only(right:4.0.w),
                                                              child: Icon(
                                                                Icons.location_on,
                                                                size: 20.r,
                                                                color: Colors.black.withOpacity(0.5),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            SizedBox(height: 5.h,),
                                                            SizedBox(
                                                              width: 250.w,
                                                              child: CustomText(
                                                                text: cont.rideDetails?.value.data?.destinationAddress ??
                                                                    "N/A",
                                                                fontSize: 16.sp,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 250.w,
                                                              child: Row(
                                                                children: [
                                                                  CustomText(
                                                                    text: "Drop Off Distance: ",
                                                                    fontSize: 14.sp,
                                                                    fontWeight: FontWeight.w600,
                                                                    fontColor: const Color(0xff2E8FF7),
                                                                  ),

                                                                  CustomText(
                                                                    text: "${cont.rideDetails?.value.data?.calculativeDistance.toString()} miles away"??
                                                                        "0 Km",
                                                                    fontSize: 14.sp,
                                                                    fontWeight: FontWeight.w400,
                                                                    overflow: TextOverflow.visible,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),


                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 10.h),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 100.h),
                                          CustomButton(
                                              height: 40.h,
                                              width: double.maxFinite,
                                              buttonColor:
                                                  AppColors.kPrimaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              onTap: () {
                                                cont.startingPoint=cont
                                                    .rideDetails?.value.googleMapPoints?.startPointAddress??"";
                                                cont.endPoint=cont
                                                    .rideDetails?.value.googleMapPoints?.endPointAddress??"";
                                                cont.rideIdStatus = cont
                                                    .rideDetails?.value.data?.id;
                                                cont
                                                    .rideDetails?.value.data?.destinationAddress == cont.rideDetails?.value.data?.completedEndingPoint?cont.statusType = 5:cont.statusType = 4;
                                                print("${cont.startingPoint}??????????????????${cont.endPoint}????????${cont.statusType}");


                                                print(cont.rideIdStatus);
                                                cont.updateRideStatus();
                                              },
                                              child: Center(
                                                child: CustomText(
                                                  text:  cont
                                                      .rideDetails?.value.data?.destinationAddress == cont.rideDetails?.value.data?.completedEndingPoint?"Finish trip":"Navigation Status Update",
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold,
                                                  fontColor:
                                                      AppColors.kBlackColor,
                                                ),
                                              )),
                                          SizedBox(height: 10.h),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )),
      );
    });
  }
}
// CustomCard(
// width: double.maxFinite,
// cardColor: Colors.white,
// borderRadius:
// BorderRadius.circular(20.r),
// boxShadow: [
// BoxShadow(
// color: Colors.black
//     .withOpacity(0.2),
// spreadRadius: 0.2,
// blurRadius: 15)
// ],
// cardChild: Padding(
// padding: EdgeInsets.symmetric(
// horizontal: 20.w,
// vertical: 25.h),
// child: IntrinsicHeight(
// child: Column(
// crossAxisAlignment:
// CrossAxisAlignment.start,
// children: [
// Row(
// crossAxisAlignment:
// CrossAxisAlignment
//     .start,
// children: [
// Column(
// children: [
// Padding(
// padding:
// EdgeInsets.only(
// right:
// 4.0.w),
// child: Icon(
// Icons.location_on,
// size: 20.r,
// color: AppColors
//     .kGreenColor,
// ),
// ),
// Column(
// children:
// List.generate(
// ((cont.rideDetails?.value.data?.pickupAddress
//     ?.length ??
// 0) ~/
// 25) +
// 1,
// (i) => Padding(
// padding: EdgeInsets.only(
// left: 8.w,
// right:
// 12.w,
// top: 5.h,
// bottom:
// 5.h),
// child:
// Container(
// height: 5.h,
// width: 2.w,
// color: Colors
//     .grey,
// )),
// ),
// ),
// ],
// ),
// SizedBox(
// width: 250.w,
// child: CustomText(
// text: cont
//     .rideDetails
//     ?.value
//     .data
//     ?.pickupAddress ??
// "N/A",
// fontSize: 16.sp,
// fontWeight:
// FontWeight.w600,
// ),
// ),
// ],
// ),
// Column(
// children: List.generate(
// cont
//     .rideDetails
//     ?.value
//     .data
//     ?.destinationVia
//     ?.length ??
// 0,
// (index) {
// final waitData = cont
//     .rideDetails
//     ?.value
//     .data
//     ?.destinationVia?[
// index];
// return Row(
// crossAxisAlignment:
// CrossAxisAlignment
//     .start,
// children: [
// Column(
// children: [
// Column(
// children: [
// Padding(
// padding: EdgeInsets.only(
// left: 8
//     .w,
// right: 12
//     .w,
// top: 5
//     .h,
// bottom: 5
//     .h),
// child:
// Container(
// height:
// 5,
// width:
// 2,
// color:
// Colors.grey,
// )),
// Padding(
// padding: EdgeInsets.only(
// left: 8
//     .w,
// right: 12
//     .w,
// top: 5
//     .h,
// bottom: 5
//     .h),
// child:
// Container(
// height:
// 5,
// width:
// 2,
// color:
// Colors.grey,
// )),
// Padding(
// padding: EdgeInsets.only(
// right:
// 3.0.w),
// child: Image
//     .asset(
// "assets/images/waitLocation.png",
// color: Colors
//     .black,
// height:
// 18.h,
// width:
// 18.w,
// ),
// ),
// ],
// ),
// Column(
// children: List
//     .generate(
// ((waitData?.destinationAddressVia?.length ??
// 0) ~/
// 25) +
// 2,
// (i) => Padding(
// padding: EdgeInsets.only(left: 8.w, right: 12.w, top: 5.h, bottom: 5.h),
// child: Container(
// height:
// 5,
// width:
// 2,
// color:
// Colors.grey,
// )),
// ),
// ),
// ],
// ),
// Column(
// children: [
// SizedBox(
// width: 250.w,
// child: Row(
// children: [
// CustomText(
// text:
// "Drop Off Distance: ",
// fontSize:
// 16.sp,
// fontWeight:
// FontWeight.w600,
// fontColor:
// const Color(0xff2E8FF7),
// ),
// CustomText(
// text: "${waitData?.destinationViaDistance.toString()} km" ??
// "0 Km",
// fontSize:
// 16.sp,
// fontWeight:
// FontWeight.w400,
// overflow:
// TextOverflow.visible,
// ),
// ],
// ),
// ),
// SizedBox(
// height: 8.h,
// ),
// SizedBox(
// width: 250.w,
// child:
// CustomText(
// text: waitData
//     ?.destinationAddressVia ??
// "N/A",
// fontSize:
// 16.sp,
// fontWeight:
// FontWeight
//     .bold,
// overflow:
// TextOverflow
//     .visible,
// ),
// ),
// SizedBox(
// height: 3.h,
// ),
// SizedBox(
// width: 250.w,
// child:
// CustomText(
// text:
// "Stay Time: ${waitData?.stayTime ?? "N/A"} minutes",
// fontColor:
// const Color(
// 0xffF40D04),
// fontSize:
// 13.sp,
// ),
// ),
// SizedBox(
// height: 10.h,
// )
// ],
// ),
// ],
// );
// },
// ),
// ),
// Row(
// crossAxisAlignment:
// CrossAxisAlignment
//     .start,
// children: [
// Column(
// children: [
// Padding(
// padding: EdgeInsets
//     .only(
// left: 8.w,
// right: 12.5
// .w,
// top: 5.h,
// bottom:
// 5.h),
// child: Container(
// height: 5,
// width: 2,
// color:
// Colors.grey,
// )),
// Padding(
// padding: EdgeInsets
//     .only(
// left: 8.w,
// right: 12.5
// .w,
// top: 5.h,
// bottom:
// 5.h),
// child: Container(
// height: 5,
// width: 2,
// color:
// Colors.grey,
// )),
// Padding(
// padding:
// EdgeInsets.only(
// right:
// 4.0.w),
// child: Icon(
// Icons.location_on,
// size: 20.r,
// color: Colors
//     .black
//     .withOpacity(
// 0.5),
// ),
// ),
// ],
// ),
// Column(
// children: [
// SizedBox(
// width: 250.w,
// child: Row(
// children: [
// CustomText(
// text:
// "Drop Off Distance: ",
// fontSize:
// 16.sp,
// fontWeight:
// FontWeight
//     .w600,
// fontColor:
// const Color(
// 0xff2E8FF7),
// ),
// CustomText(
// text:
// "${cont.rideDetails?.value.data?.driverDestinationAddressDistance.toString()} km" ??
// "0 Km",
// fontSize:
// 16.sp,
// fontWeight:
// FontWeight
//     .w400,
// overflow:
// TextOverflow
//     .visible,
// ),
// ],
// ),
// ),
// SizedBox(
// height: 10.h,
// ),
// SizedBox(
// width: 250.w,
// child: CustomText(
// text: cont
//     .rideDetails
//     ?.value
//     .data
//     ?.destinationAddress ??
// "N/A",
// fontSize: 16.sp,
// fontWeight:
// FontWeight
//     .bold,
// ),
// ),
// ],
// ),
// ],
// ),
// SizedBox(height: 10.h),
// ],
// ),
// ),
// ),
// ),