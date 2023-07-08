class RideRequestModel {
  bool? status;
  RideRequest? rideRequest;

  RideRequestModel({this.status, this.rideRequest});

  RideRequestModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    rideRequest = json['data'] != null
        ? new RideRequest.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.rideRequest != null) {
      data['data'] = this.rideRequest!.toJson();
    }
    return data;
  }
}

class RideRequest {
  int? currentPage;
 // List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  Null? nextPageUrl;
  String? path;
  int? perPage;
  Null? prevPageUrl;
  int? to;
  int? total;

  RideRequest(
      {this.currentPage,
       // this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  RideRequest.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    // if (json['data'] != null) {
    //   data = <Data>[];
    //   json['data'].forEach((v) {
    //     data!.add(new Data.fromJson(v));
    //   });
    // }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    // if (this.data != null) {
    //   data['data'] = this.data!.map((v) => v.toJson()).toList();
    // }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
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
//   String? destinationAddress;
//   String? driverPrice;
//
//   Data(
//       {this.id,
//         this.referenceNo,
//         this.firstName,
//         this.lastName,
//         this.pickupDate,
//         this.pickupTime,
//         this.pickupAddress,
//         this.destinationAddress,
//         this.driverPrice});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     referenceNo = json['reference_no'];
//     firstName = json['first_name'];
//     lastName = json['last_name'];
//     pickupDate = json['pickup_date'];
//     pickupTime = json['pickup_time'];
//     pickupAddress = json['pickup_address'];
//     destinationAddress = json['destination_address'];
//     driverPrice = json['driver_price'];
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
//     data['destination_address'] = this.destinationAddress;
//     data['driver_price'] = this.driverPrice;
//     return data;
//   }
// }

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}

