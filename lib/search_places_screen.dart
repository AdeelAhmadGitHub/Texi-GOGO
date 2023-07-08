import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
// import 'Constants/Colors/constant_colors.dart';
// import 'Widgets/CustomButton/CustomButton.dart';

class SearchPlacesScreen extends StatefulWidget {
  const SearchPlacesScreen({Key? key}) : super(key: key);
  static const String id = "SearchPlacesScreen";

  @override
  State<SearchPlacesScreen> createState() => _SearchPlacesScreenState();
}

const kGoogleApiKey = 'AIzaSyDe084ESzLxX0Pn2IHfmqAmDV96s19OVoU';
// 'AIzaSyCxIcJsc1sU0qJKW_vqE1V9RWdyO1MpRHM';
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _SearchPlacesScreenState extends State<SearchPlacesScreen> {
  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(37.42796, -122.08574), zoom: 14.0);

  Set<Marker> markersList = {};

  late GoogleMapController googleMapController;

  final Mode _mode = Mode.overlay;
double latitude=0.0;
double longitude=0.0;
  LatLng? latLng;
  String address='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      appBar: AppBar(
        backgroundColor:Colors.black12,
        leading: IconButton(
          onPressed: () {
            Object? data = {"latlng": latLng};
            Navigator.pop(context, data);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Text("Search Places"),
        actions: [
          IconButton(
            onPressed: () {
              _handlePressButton();
            },
            icon: const Icon(Icons.search_outlined),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GoogleMap(
            initialCameraPosition: initialCameraPosition,
            markers: markersList,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              googleMapController = controller;
            },
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: SizedBox(
          //     height: 40.h,
          //     child: CustomButton(
          //       text:'Submit',
          //       onPressed: () async {
          //         print('latlng successfully');
          //         if (latLng != null) {
          //           //
          //           // Object? data = {"latlng": latLng};
          //           Navigator.pop(context, {
          //             'lat':latitude,
          //             'lng':longitude,
          //             'address':address
          //           });
          //         } else {
          //           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          //             content: Text('Select Place first.'),
          //           ));
          //         }
          //       },
          //     ),
          //   ),
          // ),
          // Positioned(
          //   top: 10.h,
          //   right: 10.w,
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: InkWell(
          //       onTap: () {
          //         getCurrentLocation();
          //         setState(() {});
          //       },
          //       child: Material(
          //         borderRadius: BorderRadius.circular(8.0),
          //         child: Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: Icon(
          //             Icons.my_location_outlined,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // ElevatedButton(
          //     onPressed: _handlePressButton, child: const Text("Search Places"))
        ],
      ),
    );
  }

  Future _handlePressButton() async {
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      onError: onError,
      mode: _mode,
      language: 'en',
      strictbounds: false,
      types: [""],
      decoration: InputDecoration(
        hintText: 'Search',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
      components: [
        // Component(Component.country, "pk"),
        // Component(Component.country, "usa")
      ],
    );

    displayPrediction(p!, homeScaffoldKey.currentState);
  }

  onError(PlacesAutocompleteResponse response) {
    // homeScaffoldKey.currentState!
    //     .showSnackBar(SnackBar(content: Text(response.errorMessage!)));
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(response.errorMessage!)));
  }

  Future displayPrediction(Prediction p, ScaffoldState? currentState) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
      apiKey: kGoogleApiKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);
    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;
    latitude=lat;
    longitude=lng;
     address = detail.result.formattedAddress??"";
    latLng = LatLng(lat, lng);
    markersList.clear();
    markersList.add(
      Marker(
        markerId: const MarkerId("001"),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: detail.result.name),
      ),
    );

    setState(() {});

    googleMapController
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));
  }
}
