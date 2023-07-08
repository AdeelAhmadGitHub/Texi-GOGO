/// status : true
/// upcomingRides : {"current_page":1,"data":[{"id":4,"reference_no":"5B4UII","first_name":"Muzamil","last_name":"New","pickup_date":"2023-02-24","pickup_time":"20:39","pickup_address":"Multan, Pakistan","destination_address":"Lahore, Pakistan","driver_price":"16.5"},{"id":4,"reference_no":"5B4UII","first_name":"Muzamil","last_name":"New","pickup_date":"2023-02-24","pickup_time":"20:39","pickup_address":"Multan, Pakistan","destination_address":"Lahore, Pakistan","driver_price":"16.5"}],"first_page_url":"http://taxigogo.co.uk/api/upcomingRides?page=1","from":1,"last_page":1,"last_page_url":"http://taxigogo.co.uk/api/upcomingRides?page=1","links":[{"url":null,"label":"&laquo; Previous","active":false},{"url":"http://taxigogo.co.uk/api/upcomingRides?page=1","label":"1","active":true},{"url":null,"label":"Next &raquo;","active":false}],"next_page_url":null,"path":"http://taxigogo.co.uk/api/upcomingRides","per_page":15,"prev_page_url":null,"to":2,"total":2}

class UpcomingRidesModel {
  UpcomingRidesModel({
      bool? status, 
      UpcomingRides? upcomingRides,}){
    _status = status;
    _upcomingRides = upcomingRides;
}

  UpcomingRidesModel.fromJson(dynamic json) {
    _status = json['status'];
    _upcomingRides = json['data'] != null ? UpcomingRides.fromJson(json['data']) : null;
  }
  bool? _status;
  UpcomingRides? _upcomingRides;
UpcomingRidesModel copyWith({  bool? status,
  UpcomingRides? upcomingRides,
}) => UpcomingRidesModel(  status: status ?? _status,
  upcomingRides: upcomingRides ?? _upcomingRides,
);
  bool? get status => _status;
  UpcomingRides? get upcomingRides => _upcomingRides;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_upcomingRides != null) {
      map['upcomingRides'] = _upcomingRides?.toJson();
    }
    return map;
  }

}

/// current_page : 1
/// data : [{"id":4,"reference_no":"5B4UII","first_name":"Muzamil","last_name":"New","pickup_date":"2023-02-24","pickup_time":"20:39","pickup_address":"Multan, Pakistan","destination_address":"Lahore, Pakistan","driver_price":"16.5"},{"id":4,"reference_no":"5B4UII","first_name":"Muzamil","last_name":"New","pickup_date":"2023-02-24","pickup_time":"20:39","pickup_address":"Multan, Pakistan","destination_address":"Lahore, Pakistan","driver_price":"16.5"}]
/// first_page_url : "http://taxigogo.co.uk/api/upcomingRides?page=1"
/// from : 1
/// last_page : 1
/// last_page_url : "http://taxigogo.co.uk/api/upcomingRides?page=1"
/// links : [{"url":null,"label":"&laquo; Previous","active":false},{"url":"http://taxigogo.co.uk/api/upcomingRides?page=1","label":"1","active":true},{"url":null,"label":"Next &raquo;","active":false}]
/// next_page_url : null
/// path : "http://taxigogo.co.uk/api/upcomingRides"
/// per_page : 15
/// prev_page_url : null
/// to : 2
/// total : 2

class UpcomingRides {
  UpcomingRides({
      num? currentPage, 
     // List<Data>? data,
      String? firstPageUrl, 
      num? from, 
      num? lastPage, 
      String? lastPageUrl, 
      List<Links>? links, 
      dynamic nextPageUrl, 
      String? path, 
      num? perPage, 
      dynamic prevPageUrl, 
      num? to, 
      num? total,}){
    _currentPage = currentPage;
  //  _data = data;
    _firstPageUrl = firstPageUrl;
    _from = from;
    _lastPage = lastPage;
    _lastPageUrl = lastPageUrl;
    _links = links;
    _nextPageUrl = nextPageUrl;
    _path = path;
    _perPage = perPage;
    _prevPageUrl = prevPageUrl;
    _to = to;
    _total = total;
}

  UpcomingRides.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    // if (json['data'] != null) {
    //   _data = [];
    //   json['data'].forEach((v) {
    //     _data?.add(Data.fromJson(v));
    //   });
    // }
    _firstPageUrl = json['first_page_url'];
    _from = json['from'];
    _lastPage = json['last_page'];
    _lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      _links = [];
      json['links'].forEach((v) {
        _links?.add(Links.fromJson(v));
      });
    }
    _nextPageUrl = json['next_page_url'];
    _path = json['path'];
    _perPage = json['per_page'];
    _prevPageUrl = json['prev_page_url'];
    _to = json['to'];
    _total = json['total'];
  }
  num? _currentPage;
 // List<Data>? _data;
  String? _firstPageUrl;
  num? _from;
  num? _lastPage;
  String? _lastPageUrl;
  List<Links>? _links;
  dynamic _nextPageUrl;
  String? _path;
  num? _perPage;
  dynamic _prevPageUrl;
  num? _to;
  num? _total;
UpcomingRides copyWith({  num? currentPage,
//  List<Data>? data,
  String? firstPageUrl,
  num? from,
  num? lastPage,
  String? lastPageUrl,
  List<Links>? links,
  dynamic nextPageUrl,
  String? path,
  num? perPage,
  dynamic prevPageUrl,
  num? to,
  num? total,
}) => UpcomingRides(  currentPage: currentPage ?? _currentPage,
 // data: data ?? _data,
  firstPageUrl: firstPageUrl ?? _firstPageUrl,
  from: from ?? _from,
  lastPage: lastPage ?? _lastPage,
  lastPageUrl: lastPageUrl ?? _lastPageUrl,
  links: links ?? _links,
  nextPageUrl: nextPageUrl ?? _nextPageUrl,
  path: path ?? _path,
  perPage: perPage ?? _perPage,
  prevPageUrl: prevPageUrl ?? _prevPageUrl,
  to: to ?? _to,
  total: total ?? _total,
);
  num? get currentPage => _currentPage;
 // List<Data>? get data => _data;
  String? get firstPageUrl => _firstPageUrl;
  num? get from => _from;
  num? get lastPage => _lastPage;
  String? get lastPageUrl => _lastPageUrl;
  List<Links>? get links => _links;
  dynamic get nextPageUrl => _nextPageUrl;
  String? get path => _path;
  num? get perPage => _perPage;
  dynamic get prevPageUrl => _prevPageUrl;
  num? get to => _to;
  num? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = _currentPage;
    // if (_data != null) {
    //   map['data'] = _data?.map((v) => v.toJson()).toList();
    // }
    map['first_page_url'] = _firstPageUrl;
    map['from'] = _from;
    map['last_page'] = _lastPage;
    map['last_page_url'] = _lastPageUrl;
    if (_links != null) {
      map['links'] = _links?.map((v) => v.toJson()).toList();
    }
    map['next_page_url'] = _nextPageUrl;
    map['path'] = _path;
    map['per_page'] = _perPage;
    map['prev_page_url'] = _prevPageUrl;
    map['to'] = _to;
    map['total'] = _total;
    return map;
  }

}

/// url : null
/// label : "&laquo; Previous"
/// active : false

class Links {
  Links({
      dynamic url, 
      String? label, 
      bool? active,}){
    _url = url;
    _label = label;
    _active = active;
}

  Links.fromJson(dynamic json) {
    _url = json['url'];
    _label = json['label'];
    _active = json['active'];
  }
  dynamic _url;
  String? _label;
  bool? _active;
Links copyWith({  dynamic url,
  String? label,
  bool? active,
}) => Links(  url: url ?? _url,
  label: label ?? _label,
  active: active ?? _active,
);
  dynamic get url => _url;
  String? get label => _label;
  bool? get active => _active;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    map['label'] = _label;
    map['active'] = _active;
    return map;
  }

}

/// id : 4
/// reference_no : "5B4UII"
/// first_name : "Muzamil"
/// last_name : "New"
/// pickup_date : "2023-02-24"
/// pickup_time : "20:39"
/// pickup_address : "Multan, Pakistan"
/// destination_address : "Lahore, Pakistan"
/// driver_price : "16.5"

// class Data {
//   Data({
//       num? id,
//       String? referenceNo,
//       String? firstName,
//       String? lastName,
//       String? pickupDate,
//       String? pickupTime,
//       String? pickupAddress,
//       String? destinationAddress,
//       String? driverPrice,
//       String? status,
//       String? paymentStatus,
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
//     _driverPrice = driverPrice;
//     _status = status;
//     _paymentStatus = paymentStatus;
// }
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
//     _driverPrice = json['driver_price'];
//     _status = json['status'];
//     _paymentStatus = json['payment_status'];
//   }
//   num? _id;
//   String? _referenceNo;
//   String? _firstName;
//   String? _lastName;
//   String? _pickupDate;
//   String? _pickupTime;
//   String? _pickupAddress;
//   String? _destinationAddress;
//   String? _driverPrice;
//   String? _status;
//   String? _paymentStatus;
// Data copyWith({  num? id,
//   String? referenceNo,
//   String? firstName,
//   String? lastName,
//   String? pickupDate,
//   String? pickupTime,
//   String? pickupAddress,
//   String? destinationAddress,
//   String? driverPrice,
//   String? status,
//   String? paymentStatus,
// }) => Data(  id: id ?? _id,
//   referenceNo: referenceNo ?? _referenceNo,
//   firstName: firstName ?? _firstName,
//   lastName: lastName ?? _lastName,
//   pickupDate: pickupDate ?? _pickupDate,
//   pickupTime: pickupTime ?? _pickupTime,
//   pickupAddress: pickupAddress ?? _pickupAddress,
//   destinationAddress: destinationAddress ?? _destinationAddress,
//   driverPrice: driverPrice ?? _driverPrice,
//   status: status ?? _status,
//   paymentStatus: paymentStatus ?? _paymentStatus,
// );
//   num? get id => _id;
//   String? get referenceNo => _referenceNo;
//   String? get firstName => _firstName;
//   String? get lastName => _lastName;
//   String? get pickupDate => _pickupDate;
//   String? get pickupTime => _pickupTime;
//   String? get pickupAddress => _pickupAddress;
//   String? get destinationAddress => _destinationAddress;
//   String? get driverPrice => _driverPrice;
//   String? get status => _status;
//   String? get paymentStatus => _paymentStatus;
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
//     map['driver_price'] = _driverPrice;
//     map['status'] = _status;
//     map['payment_status'] = _paymentStatus;
//     return map;
//   }
//
// }