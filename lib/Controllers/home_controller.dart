import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_gogo/components/custom_text.dart';
import 'package:taxi_gogo/models/DataModel.dart';
import '../api/api_client.dart';
import '../models/QrCodeModel.dart';
import '../models/RideDetails.dart';
import '../models/RideRequestModel.dart';
import '../models/RunningRideModels.dart';
import '../models/StatusUpdateModel.dart';
import '../models/UpcomingRidesModel.dart';
import '../utils/functions.dart';
import '../view/job_preview/job_preview_screen.dart';
import '../view/ride_details/ride_details_screen.dart';
import 'auth_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? time;

class HomeController extends GetxController {
  ApiClient api = ApiClient(appBaseUrl: baseUrl);
  RxList<Data> upcomingList = <Data>[].obs;
  RxList<Data> runningList = <Data>[].obs;
  RxList<Data> rideList = <Data>[].obs;
  RxList<Data> qrCodeList = <Data>[].obs;
  var auth = Get.find<AuthController>();
  UpcomingRidesModel? _upcomingRidesModel;
  RunningRideModels? _runningRidesModel;
  RideRequestModel? setRideRequestModel;
  QRCodeModel? _qRCodeModel;
  late SharedPreferences prefs;


  RideRequestModel? get rideRequestModel => setRideRequestModel;

  UpcomingRidesModel? get upcomingRidesModel => _upcomingRidesModel;

  QRCodeModel? get qRCodeModel => _qRCodeModel;

  RunningRideModels? get runningRidesModel => _runningRidesModel;
  Rx<RideDetails>? rideDetails;
  int? rideId;
  int pageUpcoming = 1;
  int pageQrCode = 1;
  int pageRunning = 1;
  int pageRide = 1;
  int screenType = 1;
  int? statusType;
  int? rideIdStatus;
  int? listIndex;
  RxBool loading = false.obs;
  bool isRefreshRide = false;
  bool isRefreshRunning = false;
  bool isRefreshUpcoming = false;
  bool isRefreshQrCode = false;
  bool isAcceptedRide = false;
  bool isAcceptedRunning = false;
  bool isAcceptedUpcoming = false;
  bool isAcceptedQrCode = false;
  final listTextTabToggle = ["Offline", "Online"];
  RxInt tabTextIndexSelected = 1.obs;
  RxBool noMoreUpcoming = true.obs;
  RxBool noMoreQrCode = true.obs;
  RxBool noMoreRunning = true.obs;
  RxBool noMoreRide = true.obs;
String startingPoint='';
String? endPoint='';
  toggle(int index) => tabTextIndexSelected.value = index;
  RxInt selectedIndex = 0.obs;
  RxInt selectedMenu = 0.obs;
  List<String> ridesList =
      ["Ride Request", "Running Rides", "Upcoming Rides", "QrCode Rides"].obs;
  RxBool setIsCollectedMoney = false.obs;

  RxBool get isCollectedMoney => setIsCollectedMoney;

  @override
  Future<void> onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    tabTextIndexSelected.value = prefs.getInt("onlineStatus") ?? 1;
    await getUpcomingRides();
    await getRunningRides();
    await getRideRequest();
    await getQrCodeRides();
  }

  Future<void> getUpcomingRides() async {
    Response response = await api.postData(
        "api/upcomingRides?page=${pageUpcoming.toString()}", {},
        showdialog: false);
    if (response == null) {
      errorAlert('Check your internet connection.');
    } else if (response.statusCode == 200) {
      var json = response.body;
      _upcomingRidesModel = UpcomingRidesModel.fromJson(json);
      if (json['data']['data'] != null) {
        if (isRefreshUpcoming) {
          upcomingList = <Data>[].obs;
        }
        if (isAcceptedUpcoming) {
          upcomingList = <Data>[].obs;
        }
        json['data']['data'].forEach((v) {
          upcomingList.add(Data.fromJson(v));
        });
      }
      isRefreshUpcoming = false;
      isAcceptedUpcoming = false;
    } else {
      errorAlert('Something went wrong\nPlease try again!');
    }
    update();
  }

  Future<void> getQrCodeRides() async {
    print("QrCode");
    Response response = await api.postData(
        "api/qrCodeRide?page=${pageQrCode.toString()}", {},
        showdialog: false);
    if (response == null) {
      errorAlert('Check your internet connection.');
    } else if (response.statusCode == 200) {
      var json = response.body;
      _qRCodeModel = QRCodeModel.fromJson(json);
      if (json['data']['data'] != null) {
        if (isRefreshQrCode) {
          qrCodeList = <Data>[].obs;
        }
        if (isAcceptedQrCode) {
          qrCodeList = <Data>[].obs;
        }
        json['data']['data'].forEach((v) {
          qrCodeList.add(Data.fromJson(v));
        });
      }
      isRefreshQrCode = false;
      isAcceptedQrCode = false;
    } else {
      errorAlert('Something went wrong\nPlease try again!');
    }
    update();
  }

  Future<void> getRunningRides() async {
    Response response = await api
        .postData("api/runningRides?page=$pageRunning", {}, showdialog: false);
    if (response == null) {
      errorAlert('Check your internet connection.');
    } else if (response.statusCode == 200) {
      var json = response.body;
      _runningRidesModel = RunningRideModels.fromJson(json);
      if (json['data']['data'] != null) {
        if (isRefreshRunning) {
          runningList = <Data>[].obs;
        }
        if (isAcceptedRunning) {
          runningList = <Data>[].obs;
        }
        json['data']['data'].forEach((v) {
          runningList.add(Data.fromJson(v));
        });
        isRefreshRunning = false;
        isAcceptedRunning = false;
      }
    } else {
      errorAlert('Something went wrong\nPlease try again!');
    }
    update();
  }

  Future<void> getRideRequest() async {
    print("Ride");

    Response response = await api.postData("api/rideRequest?page=$pageRide", {},
        showdialog: false);
    if (response == null) {
      errorAlert('Check your internet connection.');
    } else if (response.statusCode == 200) {
      var json = response.body;
      setRideRequestModel = RideRequestModel.fromJson(json);
      if (json['data']['data'] != null) {
        if (isRefreshRide) {
          rideList = <Data>[].obs;
        }
        if (isAcceptedRide) {
          rideList = <Data>[].obs;
        }
        json['data']['data'].forEach((v) {
          rideList.add(Data.fromJson(v));
        });
        isRefreshRide = false;
        isAcceptedRide = false;
      }
    } else {
      errorAlert('Something went wrong\nPlease try again!');
    }
    update();
  }

  Future<void> getRideDetails() async {
    loading.value = true;
    Response response = await api
        .postData("api/getRideDetail", {'ride_id': rideId}, showdialog: true);
    if (response == null) {
      errorAlert('Check your internet connection.');
    } else if (response.statusCode == 200) {
      var json = response.body;
      rideDetails = RideDetails
          .fromJson(json)
          .obs;
      if (screenType == 0 || screenType == 2 || screenType == 3 ||
          screenType == 4) {
        Get.to(RideDetailsScreen(
          showOnlyDetails: screenType == 4 ? false : true, time: time,
        ));
      } else {
        Get.to(JobPreview(), transition: Transition.cupertino);
      }
      update();
    } else {
      errorAlert('Something went wrong\nPlease try again!');
    }
    loading.value = false;
    update();
  }

  Future<void> rideAcceptReject(int status) async {
    loading.value = true;
    Response response = await api.postData(
        "api/rideAcceptReject", {'ride_id': rideId, 'status': status},
        showdialog: true);
    if (response == null) {
      errorAlert('Check your internet connection.');
    } else if (response.statusCode == 200) {
      var json = response.body;
      if (selectedIndex.value == 0) {
        isAcceptedRide = true;
        isAcceptedRunning = true;
        getRideRequest();
        getRunningRides();
      } else if (selectedIndex.value == 2) {
        isAcceptedUpcoming = true;
        isAcceptedRunning = true;
        getUpcomingRides();
        getRunningRides();
      } else {
        isAcceptedQrCode = true;
        isAcceptedRunning = true;
        getQrCodeRides();
        getRunningRides();
      }

      Get.back();
      print("Successfulsfsew");
    } else {
      errorAlert('Something went wrong\nPlease try again!');
    }
    loading.value = false;
    update();
  }

  Future<void> updateOnlineStatus(int onlineStatus) async {
    loading.value = true;
    Response response = await api.postData(
        "api/updateOnlineStatus", {'online_status': onlineStatus},
        showdialog: true);
    if (response == null) {
      errorAlert('Check your internet connection.');
    } else if (response.statusCode == 200) {
      var json = response.body;
      prefs.setInt("onlineStatus", onlineStatus);
      print("Successhsduinwaljmckfakw;plfcoml;a");
    } else {
      errorAlert('Something went wrong\nPlease try again!');
    }
    loading.value = false;
    update();
  }

  Future<void> collectRidePayment() async {
    Response response = await api.postData(
        "api/collectRidePayment", {'ride_id': rideId, 'status': 1},
        showdialog: true);
    if (response == null) {
      errorAlert('Check your internet connection.');
    } else if (response.statusCode == 200) {
      var json = response.body;
      setIsCollectedMoney = true.obs;
      await getRideDetails();
      //  getRunningRides();
      customsnackbar("Success", "${json['message']}");
      // Get.defaultDialog(
      //   title: '',
      //   titlePadding: EdgeInsets.zero,
      //   content: Column(
      //     children: [
      //       SizedBox(
      //         width: 200,
      //         child: Text(
      //           json['message'],
      //           textAlign: TextAlign.center,
      //           // style: AppTextStyle.mediumBlack14,
      //         ),
      //       ),
      //     ],
      //   ),
      // );
    } else {
      errorAlert('Something went wrong\nPlease try again!');
    }
    update();
  }

  StatusUpdateModel? statusUpdateModel;

  Future<void> updateRideStatus() async {
    Response response = await api.postData(
        "api/updateRideStatus", {'ride_id': rideIdStatus, 'status': statusType,
      "starting_point":startingPoint,
      "ending_point":endPoint
    },
        showdialog: true);
    if (response == null) {
      errorAlert('Check your internet connection.');
    } else if (response.statusCode == 200) {
      var json = response.body;
      if (statusType == 5) {
        statusUpdateModel = StatusUpdateModel.fromJson(json);
        isRefreshRunning = true;
        rideDetails = RideDetails(
            status: true,
            data: DataRideDetails(
                id: statusUpdateModel?.dataSUM?.id,
                referenceNo: statusUpdateModel?.dataSUM?.referenceNo,
                firstName: statusUpdateModel?.dataSUM?.firstName,
                lastName: statusUpdateModel?.dataSUM?.lastName,
                phone: statusUpdateModel?.dataSUM?.phone,
                pickupDate: statusUpdateModel?.dataSUM?.pickupDate,
                pickupTime: statusUpdateModel?.dataSUM?.pickupTime,
                passengers: statusUpdateModel?.dataSUM?.passengers,
                luggage: statusUpdateModel?.dataSUM?.luggage,
                pickupAddress: statusUpdateModel?.dataSUM?.pickupAddress,
                destinationAddress: statusUpdateModel?.dataSUM
                    ?.destinationAddress,
                comments: statusUpdateModel?.dataSUM?.comments,
                rideStatus: statusUpdateModel?.dataSUM?.rideStatus,
                paymentStatus: statusUpdateModel?.dataSUM?.paymentStatus,
                destinationLatitude: statusUpdateModel?.dataSUM
                    ?.destinationLatitude,
                destinationLongitude: statusUpdateModel?.dataSUM
                    ?.destinationLongitude,
                driverDestinationAddressDistance: statusUpdateModel?.dataSUM
                    ?.driverDestinationAddressDistance,
                driverDestinationAddressTime: statusUpdateModel?.dataSUM
                    ?.driverDestinationAddressTime,
                driverPickupDistance: statusUpdateModel?.dataSUM
                    ?.driverPickupDistance,
                driverPickupTime: statusUpdateModel?.dataSUM?.driverPickupTime,
                driverPrice: statusUpdateModel?.dataSUM?.driverPrice,
                destinationVia: statusUpdateModel?.dataSUM?.destinationVia,
                paymentType: statusUpdateModel?.dataSUM?.paymentType,
                pickupLatitude: statusUpdateModel?.dataSUM?.pickupLatitude,
                pickupLongitude: statusUpdateModel?.dataSUM?.pickupLongitude,
                bookingType: statusUpdateModel?.dataSUM?.bookingType,
                navigation: statusUpdateModel?.dataSUM?.navigation,
                latitude: statusUpdateModel?.dataSUM?.latitude,
                longitude: statusUpdateModel?.dataSUM?.longitude,
                bookingPrice: statusUpdateModel?.dataSUM?.bookingPrice,
                calculativeDistance: statusUpdateModel?.dataSUM
                    ?.calculativeDistance,
                calculativeTime: statusUpdateModel?.dataSUM?.calculativeTime,
                completedStartingPoint: statusUpdateModel?.dataSUM?.completedStartingPoint,
                completedEndingPoint: statusUpdateModel?.dataSUM?.completedEndingPoint,

            ),
            googleMapPoints: statusUpdateModel?.googleMapPoints
        ).obs;
        Get.close(1);
        getRunningRides();
      } else {
        statusUpdateModel = StatusUpdateModel.fromJson(json);
        isRefreshRunning = true;
        rideDetails = RideDetails(
            status: true,
            data: DataRideDetails(
              id: statusUpdateModel?.dataSUM?.id,
              referenceNo: statusUpdateModel?.dataSUM?.referenceNo,
              firstName: statusUpdateModel?.dataSUM?.firstName,
              lastName: statusUpdateModel?.dataSUM?.lastName,
              phone: statusUpdateModel?.dataSUM?.phone,
              pickupDate: statusUpdateModel?.dataSUM?.pickupDate,
              pickupTime: statusUpdateModel?.dataSUM?.pickupTime,
              passengers: statusUpdateModel?.dataSUM?.passengers,
              luggage: statusUpdateModel?.dataSUM?.luggage,
              pickupAddress: statusUpdateModel?.dataSUM?.pickupAddress,
              destinationAddress: statusUpdateModel?.dataSUM
                  ?.destinationAddress,
              comments: statusUpdateModel?.dataSUM?.comments,
              rideStatus: statusUpdateModel?.dataSUM?.rideStatus,
              paymentStatus: statusUpdateModel?.dataSUM?.paymentStatus,
              destinationLatitude: statusUpdateModel?.dataSUM
                  ?.destinationLatitude,
              destinationLongitude: statusUpdateModel?.dataSUM
                  ?.destinationLongitude,
              driverDestinationAddressDistance: statusUpdateModel?.dataSUM
                  ?.driverDestinationAddressDistance,
              driverDestinationAddressTime: statusUpdateModel?.dataSUM
                  ?.driverDestinationAddressTime,
              driverPickupDistance: statusUpdateModel?.dataSUM
                  ?.driverPickupDistance,
              driverPickupTime: statusUpdateModel?.dataSUM?.driverPickupTime,
              driverPrice: statusUpdateModel?.dataSUM?.driverPrice,
              destinationVia: statusUpdateModel?.dataSUM?.destinationVia,
              paymentType: statusUpdateModel?.dataSUM?.paymentType,
              pickupLatitude: statusUpdateModel?.dataSUM?.pickupLatitude,
              pickupLongitude: statusUpdateModel?.dataSUM?.pickupLongitude,
              bookingType: statusUpdateModel?.dataSUM?.bookingType,
              navigation: statusUpdateModel?.dataSUM?.navigation,
              latitude: statusUpdateModel?.dataSUM?.latitude,
              longitude: statusUpdateModel?.dataSUM?.longitude,
              bookingPrice: statusUpdateModel?.dataSUM?.bookingPrice,
              calculativeDistance: statusUpdateModel?.dataSUM
                  ?.calculativeDistance,
              calculativeTime: statusUpdateModel?.dataSUM?.calculativeTime,
              completedStartingPoint: statusUpdateModel?.dataSUM?.completedStartingPoint,
              completedEndingPoint: statusUpdateModel?.dataSUM?.completedEndingPoint,

            ),
            googleMapPoints: statusUpdateModel?.googleMapPoints
        ).obs;
        getRunningRides();
        customsnackbar("Success", "Ride Status Update Successfully");
      }
    } else {
      errorAlert('Something went wrong\nPlease try again!');
    }
    update();
  }

  Future<void> cancelRide() async {
    Response response = await api.postData(
        "api/cancelRide", {'ride_id': rideId},
        showdialog: true);
    if (response == null) {
      errorAlert('Check your internet connection.');
    } else if (response.statusCode == 200) {
      var json = response.body;
      isAcceptedRunning = true;
      await getRunningRides();
      Get.close(2);
      Get.defaultDialog(
        title: '',
        titlePadding: EdgeInsets.zero,
        content: Column(
          children: [
            SizedBox(
              width: 200,
              child: Text(
                json['message'],
                textAlign: TextAlign.center,
                // style: AppTextStyle.mediumBlack14,
              ),
            ),
          ],
        ),
      );
    } else {
      errorAlert('Something went wrong\nPlease try again!');
    }
    update();
  }
}
