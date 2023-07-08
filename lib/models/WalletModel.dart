class WalletModel {
  bool? status;
 dynamic paymentTypeEarningInWeek;
  dynamic totalEarningInWeek;
  PaymentTypeTransactions? paymentTypeTransactions;

  WalletModel(
      {this.status,
        this.paymentTypeEarningInWeek,
        this.totalEarningInWeek,
        this.paymentTypeTransactions});

  WalletModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    paymentTypeEarningInWeek = json['PaymentTypeEarningInWeek'];
    totalEarningInWeek = json['TotalEarningInWeek'];
    paymentTypeTransactions = json['PaymentTypeTransactions'] != null
        ?   PaymentTypeTransactions.fromJson(json['PaymentTypeTransactions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['PaymentTypeEarningInWeek'] = this.paymentTypeEarningInWeek;
    data['TotalEarningInWeek'] = this.totalEarningInWeek;
    if (this.paymentTypeTransactions != null) {
      data['PaymentTypeTransactions'] = this.paymentTypeTransactions!.toJson();
    }
    return data;
  }
}

class PaymentTypeTransactions {
  int? currentPage;
  List<WalletData>? walletData;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  PaymentTypeTransactions(
      {this.currentPage,
        this.walletData,
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

  PaymentTypeTransactions.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      walletData = <WalletData>[];
      json['data'].forEach((v) {
        walletData!.add(new WalletData.fromJson(v));
      });
    }
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
    if (this.walletData != null) {
      data['data'] = this.walletData!.map((v) => v.toJson()).toList();
    }
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

class WalletData {
  int? id;
  String? referenceNo;
  String? driverAmount;
  String? createdAt;

  WalletData({this.id, this.referenceNo, this.driverAmount, this.createdAt});

  WalletData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referenceNo = json['reference_no'];
    driverAmount = json['driverAmount'].toString();
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reference_no'] = this.referenceNo;
    data['driverAmount'] = this.driverAmount;
    data['created_at'] = this.createdAt;
    return data;
  }
}

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
