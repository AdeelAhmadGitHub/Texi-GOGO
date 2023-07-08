import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' show cos, sqrt, asin;

const kGoogleApiKey = 'AIzaSyDe084ESzLxX0Pn2IHfmqAmDV96s19OVoU';

class NavigationScreen extends StatefulWidget {
  final double? lat;
  final double? long;

  const NavigationScreen({Key? key, this.lat, this.long}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  Completer<GoogleMapController?> _controller = Completer();
  Map<PolylineId, Polyline> polyLines = {};
  Location location = Location();
  Marker? sourcePosition, destinationPosition;
  loc.LocationData? _currentPosition;
  List<Marker> markers = [];
  List<LatLng> latLonList = [
    LatLng(30.040346042196376, 71.81190393941353),
    LatLng(30.19645091910742, 71.4236834952433),
    LatLng(29.40280823127107, 71.68216933753986),
  ];
  List<PolylineWayPoint> latLonP = [
    PolylineWayPoint(location: "Jahanian-Khanewal"),
    PolylineWayPoint(location: "Multan International Airport"),
    PolylineWayPoint(location: "Bahawalpur Zoo"),
  ];
  LatLng curLocation = LatLng(30.09697855707855, 71.85671899434175);
  StreamSubscription<loc.LocationData>? locationSubscription;

  @override
  void initState() {
    // TODO: implement initState
    addMarker();
    getNavigation();
    super.initState();
  }

  String _originPlaceId = "ORIGIN PLACE ID";
  String _destinationPlaceId = "DESTINATION PLACE ID";

  void _launchMapsUrl(String originPlaceId, String destinationPlaceId) async {
    String mapOptions = [
      'origin=$originPlaceId',
      'origin_place_id=$originPlaceId',
      'destination=$destinationPlaceId',
      'destination_place_id=$destinationPlaceId',
      'dir_action=navigate'
    ].join('&');
    var url = Uri.encodeFull(
        "https://maps.google.com/maps/dir/api=1?q=${widget.lat},${widget.long}");
    //final url = 'https://www.google.com/maps/dir/api=1&${widget.lat},${widget.long}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: sourcePosition == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                GoogleMap(
                  zoomControlsEnabled: true,
                  polylines: Set<Polyline>.of(polyLines.values),
                  initialCameraPosition:
                      CameraPosition(target: curLocation, zoom: 5),
                  markers: Set<Marker>.of(markers),
                  mapType: MapType.normal,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
                Center(
                  child: Container(
                    height: 50,
                    width: 50,
                    child: IconButton(
                      icon: Icon(Icons.navigation_outlined),
                      onPressed: () async {
                        // List<LatLng> latLng=[];
                        // latLng.add(LatLng(widget.lat!, widget.lat!));
                        // latLng.add(LatLng(curLocation.latitude, curLocation.longitude));
                        // await launchUrl(
                        //   Uri.parse()
                        // );
                        _launchMapsUrl(_originPlaceId, _destinationPlaceId);
                      },
                    ),
                  ),
                )
              ],
            ),
    );
  }

  void addMarker() {
    setState(() {
      sourcePosition = Marker(
          markerId: const MarkerId("Source"),
          position: curLocation,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          infoWindow: InfoWindow(title: "PickUp Address:chack 105/10.R"));
      destinationPosition = Marker(
          infoWindow: InfoWindow(title: "destination Address:Jahania"),
          markerId: const MarkerId("Destination"),
          position: LatLng(widget.lat!, widget.long!),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan));
      latLonList.forEach((element) {
        markers.add(Marker(
          markerId: const MarkerId("Stay"),
          position: element,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ));
      });
      markers.add(sourcePosition!);
      markers.add(destinationPosition!);
    });
  }

  Future<void> getNavigation() async {
    final GoogleMapController? controller = await _controller.future;
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
          //distanceFilter: 100,
          // timeLimit: Duration(minutes: 1),
          );
      StreamSubscription<Position> positionStream =
          Geolocator.getPositionStream(locationSettings: locationSetting)
              .listen(
        (Position? position) async {
          curLocation = LatLng(position!.latitude, position.longitude);
          controller?.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 14.0)));
          if (mounted) {
            controller?.showMarkerInfoWindow(
                MarkerId(sourcePosition!.markerId.value));
            setState(() {
              curLocation = LatLng(position.latitude, position.longitude);
              sourcePosition = Marker(
                  markerId: MarkerId(position.toString()),
                  position: LatLng(position.latitude, position.longitude),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueAzure),

                  // infoWindow: InfoWindow(
                  //     title: double.parse(
                  //             getDistance(LatLng(widget.lat!, widget.long!))
                  //                 .toStringAsFixed(2))
                  //         .toString(),
                  //     onTap: () {
                  //       print("Marker Id");
                  //     }));
                  infoWindow: InfoWindow(title: "Chack 105/10.r"));
            });
            getDirection(LatLng(widget.lat!, widget.long!));
          }
        },
      );
    } catch (e)
    // ignore: empty_catches
    {}
  }

  // Future<void> getNavigation() async {
  //   print(">>>>>>>>>>>>>>>>>>1<<<<<<<<<<<<<<<<<<");
  //   bool _servicesEnabled;
  //   PermissionStatus _permissionGranted;
  //   final GoogleMapController? controller = await _controller.future;
  //   print(">>>>>>>>>>>>>>>>>>2<<<<<<<<<<<<<<<<<<");
  //   location.changeSettings(accuracy: loc.LocationAccuracy.high);
  //   _servicesEnabled = await location.serviceEnabled();
  //   if (!_servicesEnabled) {
  //     print(">>>>>>>>>>>>>>>>>>3<<<<<<<<<<<<<<<<<<");
  //     _servicesEnabled = await location.requestService();
  //     if (!_servicesEnabled) {
  //       print(">>>>>>>>>>>>>>>>>>4<<<<<<<<<<<<<<<<<<");
  //       return;
  //     }
  //   }
  //   _permissionGranted = await location.hasPermission();
  //   print(">>>>>>>>>>>>>>>>>>5<<<<<<<<<<<<<<<<<<");
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await location.requestPermission();
  //     if (_permissionGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }
  //   if (_permissionGranted == loc.PermissionStatus.granted) {
  //     _currentPosition = await location.getLocation();
  //     curLocation =
  //         LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!);
  //     locationSubscription =
  //         location.onLocationChanged.listen((loc.LocationData currentLocation) {
  //       controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //           target:
  //               LatLng(currentLocation.latitude!, currentLocation.longitude!),
  //           zoom: 14.0)));
  //       if (mounted) {
  //         controller
  //             ?.showMarkerInfoWindow(MarkerId(sourcePosition!.markerId.value));
  //         setState(() {
  //           curLocation =
  //               LatLng(currentLocation.latitude!, currentLocation.longitude!);
  //           sourcePosition = Marker(
  //               markerId: MarkerId(currentLocation.toString()),
  //               position: LatLng(
  //                   currentLocation.latitude!, currentLocation.longitude!),
  //               icon: BitmapDescriptor.defaultMarkerWithHue(
  //                   BitmapDescriptor.hueAzure),
  //               infoWindow: InfoWindow(
  //                   title: double.parse(
  //                           getDistance(LatLng(widget.lat!, widget.long!))
  //                               .toStringAsFixed(2))
  //                       .toString(),
  //                   onTap: () {
  //                     print("Marker Id");
  //                   }));
  //         });
  //         getDirection(LatLng(widget.lat!, widget.long!));
  //       }
  //     });
  //   }
  // }

  Future<void> getDirection(LatLng latLng) async {
    List<LatLng> polyLineCoordinates = [];
    List<dynamic> points = [];
    PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
        "AIzaSyDe084ESzLxX0Pn2IHfmqAmDV96s19OVoU",
        PointLatLng(curLocation.latitude, curLocation.longitude),
        PointLatLng(latLng.latitude, latLng.longitude),
        travelMode: TravelMode.driving,
      wayPoints: latLonP
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
}
