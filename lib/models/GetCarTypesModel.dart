class GetCarTypesModel {
  bool? status;
  List<DataCarType>? data;

  GetCarTypesModel({this.status, this.data});

  GetCarTypesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <DataCarType>[];
      json['data'].forEach((v) {
        data!.add(new DataCarType.fromJson(v));
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

class DataCarType {
  int? id;
  String? carName;

  DataCarType({this.id, this.carName});

  DataCarType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carName = json['car_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['car_name'] = this.carName;
    return data;
  }
}
