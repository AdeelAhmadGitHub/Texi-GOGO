// class Data {
//   Data({
//     num? id,
//     String? referenceNo,
//     String? firstName,
//     String? lastName,
//     String? pickupDate,
//     String? pickupTime,
//     String? pickupAddress,
//     String? destinationAddress,
//     dynamic bookingPrice,
//     dynamic driverPrice,
//     dynamic rideStatus,
//     String? paymentStatus,
//     dynamic distance,
//     dynamic time,
//
//   }){
//     _id = id;
//     _referenceNo = referenceNo;
//     _firstName = firstName;
//     _lastName = lastName;
//     _pickupDate = pickupDate;
//     _pickupTime = pickupTime;
//     _pickupAddress = pickupAddress;
//     _destinationAddress = destinationAddress;
//     _bookingPrice = bookingPrice;
//     _driverPrice = driverPrice;
//     _rideStatus = rideStatus;
//     _paymentStatus = paymentStatus;
//     _distance = distance;
//     _time = time;
//   }
//
//   Data.fromJson(dynamic json) {
//     _id = json['id'];
//     _referenceNo = json['reference_no'];
//     _firstName = json['first_name'];
//     _lastName = json['last_name'];
//     _pickupDate = json['pickup_date'];
//     _pickupTime = json['pickup_time'];
//     _pickupAddress = json['pickup_address'];
//     _destinationAddress = json['destination_address'];
//     _bookingPrice = json['booking_price'];
//     _driverPrice = json['driver_price'];
//     _rideStatus = json['rideStatus'];
//     _paymentStatus = json['payment_status'];
//     _distance = json['distance'];
//     _time = json['time'];
//   }
//   num? _id;
//   String? _referenceNo;
//   String? _firstName;
//   String? _lastName;
//   String? _pickupDate;
//   String? _pickupTime;
//   String? _pickupAddress;
//   String? _destinationAddress;
//   dynamic _bookingPrice;
//   dynamic _driverPrice;
//   dynamic _rideStatus;
//   dynamic _paymentStatus;
//   dynamic _distance;
//   dynamic _time;
//   Data copyWith({  num? id,
//     String? referenceNo,
//     String? firstName,
//     String? lastName,
//     String? pickupDate,
//     String? pickupTime,
//     String? pickupAddress,
//     String? destinationAddress,
//     dynamic bookingPrice,
//     dynamic driverPrice,
//     dynamic rideStatus,
//     String? paymentStatus,
//     dynamic distance,
//     dynamic time,
//   }) => Data(  id: id ?? _id,
//     referenceNo: referenceNo ?? _referenceNo,
//     firstName: firstName ?? _firstName,
//     lastName: lastName ?? _lastName,
//     pickupDate: pickupDate ?? _pickupDate,
//     pickupTime: pickupTime ?? _pickupTime,
//     pickupAddress: pickupAddress ?? _pickupAddress,
//     destinationAddress: destinationAddress ?? _destinationAddress,
//     bookingPrice: bookingPrice ?? _bookingPrice,
//     driverPrice: driverPrice ?? _driverPrice,
//     rideStatus: rideStatus ?? _rideStatus,
//     paymentStatus: paymentStatus ?? _paymentStatus,
//     distance: distance ?? _distance,
//     time: time ?? _time,
//   );
//   num? get id => _id;
//   String? get referenceNo => _referenceNo;
//   String? get firstName => _firstName;
//   String? get lastName => _lastName;
//   String? get pickupDate => _pickupDate;
//   String? get pickupTime => _pickupTime;
//   String? get pickupAddress => _pickupAddress;
//   String? get destinationAddress => _destinationAddress;
//   dynamic get bookingPrice => _bookingPrice;
//   dynamic get driverPrice => _driverPrice;
//   dynamic get rideStatus => _rideStatus;
//   String? get paymentStatus => _paymentStatus;
//   dynamic get distance => _distance;
//   dynamic get time => _time;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['reference_no'] = _referenceNo;
//     map['first_name'] = _firstName;
//     map['last_name'] = _lastName;
//     map['pickup_date'] = _pickupDate;
//     map['pickup_time'] = _pickupTime;
//     map['pickup_address'] = _pickupAddress;
//     map['destination_address'] = _destinationAddress;
//     map['booking_price'] = _bookingPrice;
//     map['driver_price'] = _driverPrice;
//     map['rideStatus'] = _rideStatus;
//     map['payment_status'] = _paymentStatus;
//     map['distance'] = _distance;
//     map['time'] = _time;
//     return map;
//   }
//
// }

class Data {
  int? id;
  String? referenceNo;
  String? firstName;
  String? lastName;
  String? pickupDate;
  String? pickupTime;
  String? pickupAddress;
  String? pickupLatitude;
  String? pickupLongitude;
  String? destinationAddress;
  String? destinationLatitude;
  String? destinationLongitude;
  String? navigation;
  String? latitude;
  String? longitude;
  int? bookingPrice;
  String? paymentType;
  String? driverPrice;
  String? driverDestinationAddressDistance;
  String? driverDestinationAddressTime;
  String? driverPickupDistance;
  String? driverPickupTime;
  List<DestinationVia>? destinationVia;
  String? calculativeDistance;
  String? calculativeTime;
  String? rideStatus;
  int? remainingSeconds;
  bool? isNavigate;
  int? time;

  Data(
      {this.id,
        this.referenceNo,
        this.firstName,
        this.lastName,
        this.pickupDate,
        this.pickupTime,
        this.pickupAddress,
        this.pickupLatitude,
        this.pickupLongitude,
        this.destinationAddress,
        this.destinationLatitude,
        this.destinationLongitude,
        this.navigation,
        this.latitude,
        this.longitude,
        this.bookingPrice,
        this.paymentType,
        this.driverPrice,
        this.driverDestinationAddressDistance,
        this.driverDestinationAddressTime,
        this.driverPickupDistance,
        this.driverPickupTime,
        this.destinationVia,
        this.calculativeDistance,
        this.calculativeTime,
        this.rideStatus,
        this.remainingSeconds,
        this.isNavigate,
        this.time,

      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referenceNo = json['reference_no'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    pickupDate = json['pickup_date'];
    pickupTime = json['pickup_time'];
    pickupAddress = json['pickup_address'];
    pickupLatitude = json['pickup_latitude'].toString();
    pickupLongitude = json['pickup_longitude'].toString();
    destinationAddress = json['destination_address'];
    destinationLatitude = json['destination_latitude'].toString();
    destinationLongitude = json['destination_longitude'].toString();
    navigation = json['navigation'];
    latitude = json['latitude'].toString();
    longitude = json['longitude'].toString();
    bookingPrice = json['booking_price'];
    paymentType = json['payment_type'];
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
    calculativeDistance = json['calculativeDistance'].toString();
    calculativeTime = json['calculativeTime'];
    rideStatus = json['rideStatus'];
    remainingSeconds = json['remainingSeconds'];
    isNavigate=true;
    time=0;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reference_no'] = this.referenceNo;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['pickup_date'] = this.pickupDate;
    data['pickup_time'] = this.pickupTime;
    data['pickup_address'] = this.pickupAddress;
    data['pickup_latitude'] = this.pickupLatitude;
    data['pickup_longitude'] = this.pickupLongitude;
    data['destination_address'] = this.destinationAddress;
    data['destination_latitude'] = this.destinationLatitude;
    data['destination_longitude'] = this.destinationLongitude;
    data['navigation'] = this.navigation;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['booking_price'] = this.bookingPrice;
    data['payment_type'] = this.paymentType;
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
    data['rideStatus'] = this.rideStatus;
    data['remainingSeconds'] = this.remainingSeconds;
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



// class Data {
//   int? id;
//   String? referenceNo;
//   String? firstName;
//   String? lastName;
//   String? pickupDate;
//   String? pickupTime;
//   String? pickupAddress;
//   String? navigation;
//   String? latitude;
//   String? longitude;
//   String? destinationAddress;
//   int? bookingPrice;
//   String? paymentType;
//   String? paymentStatus;
//   String? rideStatus;
//   dynamic driverPrice;
//   String? driverDestinationAddressDistance;
//   String? driverDestinationAddressTime;
//   int? remainingSeconds;
//   double? driverPickupDistance;
//   String? driverPickupTime;
//   List<DestinationVia>? destinationVia;
//
//   Data(
//       {this.id,
//         this.referenceNo,
//         this.firstName,
//         this.lastName,
//         this.pickupDate,
//         this.pickupTime,
//         this.pickupAddress,
//         this.navigation,
//         this.latitude,
//         this.longitude,
//         this.destinationAddress,
//         this.bookingPrice,
//         this.paymentType,
//         this.paymentStatus,
//         this.rideStatus,
//         this.driverPrice,
//         this.driverDestinationAddressDistance,
//         this.driverDestinationAddressTime,
//         this.remainingSeconds,
//         this.driverPickupDistance,
//         this.driverPickupTime,
//         this.destinationVia});
//
//   Data.fromJson(Map<String, dynamic> json) {
//
//     id = json['id'];
//     referenceNo = json['reference_no'];
//     firstName = json['first_name'];
//     lastName = json['last_name'];
//     pickupDate = json['pickup_date'];
//     pickupTime = json['pickup_time'];
//     pickupAddress = json['pickup_address'];
//     navigation = json['navigation'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     destinationAddress = json['destination_address'];
//     bookingPrice = json['booking_price'];
//     paymentType = json['payment_type'];
//     paymentStatus = json['payment_status'];
//     rideStatus = json['rideStatus'];
//     driverPrice = json['driver_price'];
//     driverDestinationAddressDistance =
//     json['driver_destination_address_distance'];
//     driverDestinationAddressTime = json['driver_destination_address_time'];
//     remainingSeconds = json['remainingSeconds'];
//     driverPickupDistance = json['driver_pickup_distance'];
//     driverPickupTime = json['driver_pickup_time'];
//     if (json['destination_via'] != null) {
//       destinationVia = <DestinationVia>[];
//       json['destination_via'].forEach((v) {
//         destinationVia!.add(new DestinationVia.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['reference_no'] = this.referenceNo;
//     data['first_name'] = this.firstName;
//     data['last_name'] = this.lastName;
//     data['pickup_date'] = this.pickupDate;
//     data['pickup_time'] = this.pickupTime;
//     data['pickup_address'] = this.pickupAddress;
//     data['navigation'] = this.navigation;
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     data['destination_address'] = this.destinationAddress;
//     data['booking_price'] = this.bookingPrice;
//     data['payment_type'] = this.paymentType;
//     data['payment_status'] = this.paymentStatus;
//     data['rideStatus'] = this.rideStatus;
//     data['driver_price'] = this.driverPrice;
//     data['driver_destination_address_distance'] =
//         this.driverDestinationAddressDistance;
//     data['driver_destination_address_time'] = this.driverDestinationAddressTime;
//     data['remainingSeconds'] = this.remainingSeconds;
//     data['driver_pickup_distance'] = this.driverPickupDistance;
//     data['driver_pickup_time'] = this.driverPickupTime;
//     if (this.destinationVia != null) {
//       data['destination_via'] =
//           this.destinationVia!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class DestinationVia {
//   int? id;
//   int? bookingId;
//   String? destinationAddressVia;
//   String? stayTime;
//   double? destinationViaDistance;
//   String? destinationViaTime;
//   String? createdAt;
//   String? updatedAt;
//
//   DestinationVia(
//       {this.id,
//         this.bookingId,
//         this.destinationAddressVia,
//         this.stayTime,
//         this.destinationViaDistance,
//         this.destinationViaTime,
//         this.createdAt,
//         this.updatedAt});
//
//   DestinationVia.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     bookingId = json['booking_id'];
//     destinationAddressVia = json['destination_address_via'];
//     stayTime = json['stay_time'];
//     destinationViaDistance = json['destination_via_distance'];
//     destinationViaTime = json['destination_via_time'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['booking_id'] = this.bookingId;
//     data['destination_address_via'] = this.destinationAddressVia;
//     data['stay_time'] = this.stayTime;
//     data['destination_via_distance'] = this.destinationViaDistance;
//     data['destination_via_time'] = this.destinationViaTime;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }


