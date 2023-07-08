import 'package:taxi_gogo/models/RideDetails.dart';

class StatusUpdateModel {
  bool? status;
  String? message;
  DataStatusUpdate? dataSUM;
  GoogleMapPoints? googleMapPoints;

  StatusUpdateModel(
      {this.status, this.message, this.dataSUM, this.googleMapPoints});

  StatusUpdateModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    dataSUM = json['data'] != null
        ? new DataStatusUpdate.fromJson(json['data'])
        : null;
    googleMapPoints =
        json['googleMapPoints'] != null && json['googleMapPoints'].isNotEmpty
            ? new GoogleMapPoints.fromJson(json['googleMapPoints'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.dataSUM != null) {
      data['data'] = this.dataSUM!.toJson();
    }
    if (this.googleMapPoints != null) {
      data['googleMapPoints'] = this.googleMapPoints!.toJson();
    }
    return data;
  }
}

class DataStatusUpdate {
  int? id;
  String? referenceNo;
  String? firstName;
  String? lastName;
  String? phone;
  String? pickupDate;
  String? pickupTime;
  String? luggage;
  String? comments;
  String? passengers;
  String? pickupAddress;
  String? pickupLatitude;
  String? pickupLongitude;
  String? destinationAddress;
  String? destinationLatitude;
  String? destinationLongitude;
  String? bookingType;
  String? navigation;
  String? latitude;
  String? longitude;
  String? completedStartingPoint;
  String? completedEndingPoint;
  String? bookingPrice;
  String? paymentType;
  String? paymentStatus;
  String? rideStatus;
  String? driverPrice;
  String? driverDestinationAddressDistance;
  String? driverDestinationAddressTime;
  String? driverPickupDistance;
  String? driverPickupTime;
  List<DestinationVia>? destinationVia;
  int? calculativeDistance;
  String? calculativeTime;

  DataStatusUpdate(
      {this.id,
      this.referenceNo,
      this.firstName,
      this.lastName,
      this.phone,
      this.pickupDate,
      this.pickupTime,
      this.passengers,
      this.luggage,
      this.comments,
      this.pickupAddress,
      this.pickupLatitude,
      this.pickupLongitude,
      this.destinationAddress,
      this.destinationLatitude,
      this.destinationLongitude,
      this.bookingType,
      this.navigation,
      this.latitude,
      this.longitude,
      this.completedStartingPoint,
      this.completedEndingPoint,
      this.bookingPrice,
      this.paymentType,
      this.paymentStatus,
      this.rideStatus,
      this.driverPrice,
      this.driverDestinationAddressDistance,
      this.driverDestinationAddressTime,
      this.driverPickupDistance,
      this.driverPickupTime,
      this.destinationVia,
      this.calculativeDistance,
      this.calculativeTime});

  DataStatusUpdate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referenceNo = json['reference_no'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    pickupDate = json['pickup_date'];
    pickupTime = json['pickup_time'];
    passengers = json['passengers'].toString();
    luggage = json['luggage'].toString();
    comments = json['comments'];
    pickupAddress = json['pickup_address'];
    pickupLatitude = json['pickup_latitude'].toString();
    pickupLongitude = json['pickup_longitude'].toString();
    destinationAddress = json['destination_address'];
    destinationLatitude = json['destination_latitude'].toString();
    destinationLongitude = json['destination_longitude'].toString();
    bookingType = json['booking_type'];
    navigation = json['navigation'];
    latitude = json['latitude'].toString();
    longitude = json['longitude'].toString();
    completedStartingPoint = json['completed_starting_point'].toString();
    completedEndingPoint = json['completed_ending_point'].toString();
    bookingPrice = json['booking_price'].toString();
    paymentType = json['payment_type'];
    paymentStatus = json['payment_status'];
    rideStatus = json['rideStatus'];
    driverPrice = json['driver_price'].toString();
    driverDestinationAddressDistance =
        json['driver_destination_address_distance'].toString();
    driverDestinationAddressTime = json['driver_destination_address_time'];
    driverPickupDistance = json['driver_pickup_distance'].toString();
    driverPickupTime = json['driver_pickup_time'];
    if (json['destination_via'] != null) {
      destinationVia = <DestinationVia>[];
      json['destination_via'].forEach((v) {
        destinationVia!.add(new DestinationVia.fromJson(v));
      });
    }
    calculativeDistance = json['calculativeDistance'];
    calculativeTime = json['calculativeTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reference_no'] = this.referenceNo;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    data['pickup_date'] = this.pickupDate;
    data['pickup_time'] = this.pickupTime;
    data['passengers'] = this.passengers;
    data['luggage'] = this.luggage;
    data['comments'] = this.comments;
    data['pickup_address'] = this.pickupAddress;
    data['pickup_latitude'] = this.pickupLatitude;
    data['pickup_longitude'] = this.pickupLongitude;
    data['destination_address'] = this.destinationAddress;
    data['destination_latitude'] = this.destinationLatitude;
    data['destination_longitude'] = this.destinationLongitude;
    data['booking_type'] = this.bookingType;
    data['navigation'] = this.navigation;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['completed_starting_point'] = this.completedStartingPoint;
    data['completed_ending_point'] = this.completedEndingPoint;
    data['booking_price'] = this.bookingPrice;
    data['payment_type'] = this.paymentType;
    data['payment_status'] = this.paymentStatus;
    data['rideStatus'] = this.rideStatus;
    data['driver_price'] = this.driverPrice;
    data['driver_destination_address_distance'] =
        this.driverDestinationAddressDistance;
    data['driver_destination_address_time'] = this.driverDestinationAddressTime;
    data['driver_pickup_distance'] = this.driverPickupDistance;
    data['driver_pickup_time'] = this.driverPickupTime;
    if (this.destinationVia != null) {
      data['destination_via'] =
          this.destinationVia!.map((v) => v.toJson()).toList();
    }
    data['calculativeDistance'] = this.calculativeDistance;
    data['calculativeTime'] = this.calculativeTime;
    return data;
  }
}
