class RideDetails {
  bool? status;
  DataRideDetails? data;
  GoogleMapPoints? googleMapPoints;

  RideDetails({this.status, this.data,this.googleMapPoints});

  RideDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new DataRideDetails.fromJson(json['data']) : null;
    googleMapPoints = json['googleMapPoints'] != null &&json['googleMapPoints'].isNotEmpty? new GoogleMapPoints.fromJson(json['googleMapPoints']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.googleMapPoints != null) {
      data['googleMapPoints'] = this.googleMapPoints!.toJson();
    }
    return data;
  }
}

class DataRideDetails {
  int? id;
  String? referenceNo;
  String? firstName;
  String? lastName;
  String? phone;
  String? pickupDate;
  String? pickupTime;
  String? passengers;
  String? luggage;
  String? pickupAddress;
  String? pickupLatitude;
  String? pickupLongitude;
  String? destinationAddress;
  String? destinationLatitude;
  String? destinationLongitude;
  String? driverDestinationAddressDistance;
  String? driverDestinationAddressTime;
  String? comments;
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
  String? driverPickupDistance;
  String? driverPickupTime;
  List<DestinationVia>? destinationVia;
  int? calculativeDistance;
  String? calculativeTime;

  DataRideDetails(
      {this.id,
        this.referenceNo,
        this.firstName,
        this.lastName,
        this.phone,
        this.pickupDate,
        this.pickupTime,
        this.passengers,
        this.luggage,
        this.pickupAddress,
        this.pickupLatitude,
        this.pickupLongitude,
        this.destinationAddress,
        this.destinationLatitude,
        this.destinationLongitude,
        this.driverDestinationAddressDistance,
        this.driverDestinationAddressTime,
        this.comments,
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
        this.driverPickupDistance,
        this.driverPickupTime,
        this.destinationVia,
        this.calculativeDistance,
        this.calculativeTime});

  DataRideDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referenceNo = json['reference_no'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    pickupDate = json['pickup_date'];
    pickupTime = json['pickup_time'];
    passengers = json['passengers'].toString();
    luggage = json['luggage'].toString();
    pickupAddress = json['pickup_address'];
    pickupLatitude = json['pickup_latitude'].toString();
    pickupLongitude = json['pickup_longitude'].toString();
    destinationAddress = json['destination_address'];
    destinationLatitude = json['destination_latitude'].toString();
    destinationLongitude = json['destination_longitude'].toString();
    driverDestinationAddressDistance =
    json['driver_destination_address_distance'].toString();
    driverDestinationAddressTime = json['driver_destination_address_time'];
    comments = json['comments'];
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
    data['pickup_address'] = this.pickupAddress;
    data['pickup_latitude'] = this.pickupLatitude;
    data['pickup_longitude'] = this.pickupLongitude;
    data['destination_address'] = this.destinationAddress;
    data['destination_latitude'] = this.destinationLatitude;
    data['destination_longitude'] = this.destinationLongitude;
    data['driver_destination_address_distance'] =
        this.driverDestinationAddressDistance;
    data['driver_destination_address_time'] = this.driverDestinationAddressTime;
    data['comments'] = this.comments;
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

class DestinationVia {
  int? id;
  int? bookingId;
  String? destinationAddressVia;
  String? destinationViaLatitude;
  String? destinationViaLongitude;
  String? stayTime;
  String? destinationViaDistance;
  String? destinationViaTime;
  String? createdAt;
  String? updatedAt;

  DestinationVia(
      {this.id,
        this.bookingId,
        this.destinationAddressVia,
        this.destinationViaLatitude,
        this.destinationViaLongitude,
        this.stayTime,
        this.destinationViaDistance,
        this.destinationViaTime,
        this.createdAt,
        this.updatedAt});

  DestinationVia.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    destinationAddressVia = json['destination_address_via'];
    destinationViaLatitude = json['destination_via_latitude'];
    destinationViaLongitude = json['destination_via_longitude'];
    stayTime = json['stay_time'];
    destinationViaDistance = json['destination_via_distance'].toString();
    destinationViaTime = json['destination_via_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_id'] = this.bookingId;
    data['destination_address_via'] = this.destinationAddressVia;
    data['destination_via_latitude'] = this.destinationViaLatitude;
    data['destination_via_longitude'] = this.destinationViaLongitude;
    data['stay_time'] = this.stayTime;
    data['destination_via_distance'] = this.destinationViaDistance;
    data['destination_via_time'] = this.destinationViaTime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
class GoogleMapPoints {
  String? startPointAddress;
  String? startPointLatitude;
  String? startPointLongitude;
  String? endPointAddress;
  String? endPointLatitude;
  String? endPointLongitude;

  GoogleMapPoints(
      {this.startPointAddress,
        this.startPointLatitude,
        this.startPointLongitude,
        this.endPointAddress,
        this.endPointLatitude,
        this.endPointLongitude});

  GoogleMapPoints.fromJson(Map<String, dynamic> json) {
    startPointAddress = json['start_point_address'];
    startPointLatitude = json['start_point_latitude'];
    startPointLongitude = json['start_point_longitude'];
    endPointAddress = json['end_point_address'];
    endPointLatitude = json['end_point_latitude'];
    endPointLongitude = json['end_point_longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_point_address'] = this.startPointAddress;
    data['start_point_latitude'] = this.startPointLatitude;
    data['start_point_longitude'] = this.startPointLongitude;
    data['end_point_address'] = this.endPointAddress;
    data['end_point_latitude'] = this.endPointLatitude;
    data['end_point_longitude'] = this.endPointLongitude;
    return data;
  }
}

