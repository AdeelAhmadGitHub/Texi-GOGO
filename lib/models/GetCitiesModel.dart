class GetCitiesModel {
  bool? status;
  List<DataCity>? data;

  GetCitiesModel({this.status, this.data});

  GetCitiesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <DataCity>[];
      json['data'].forEach((v) {
        data!.add(new DataCity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataCity {
  int? id;
  String? city;

  DataCity({this.id, this.city});

  DataCity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['city'] = this.city;
    return data;
  }
}
