/// status : true
/// access_token : "445|Jgo4V8OA3o3VxFXjCLo0tuOZqTcM5fPHrBnqGv7Z"
/// token_type : "Bearer"
/// user_id : 36
/// first_name : "Muzamil"
/// last_name : "Hussain"
/// phone : "03061636105"
/// email : "muzamil@gmail.cpm"
/// date_of_birth : "2023-02-06"
/// gender : "Male"
/// online_status : 1
/// device_token : "5ABC12sfdgregre"
/// created_at : "2023-02-21T10:47:36.000000Z"

class UserData {
  UserData({
      bool? status, 
      String? accessToken, 
      String? tokenType, 
      num? userId, 
      String? firstName, 
      String? lastName, 
      String? phone, 
      String? email, 
      String? dateOfBirth, 
      String? gender, 
      String? navigation,
      num? onlineStatus,
      String? deviceToken, 
      String? qrCodeImage,
      String? createdAt,}){
    _status = status;
    _accessToken = accessToken;
    _tokenType = tokenType;
    _userId = userId;
    _firstName = firstName;
    _lastName = lastName;
    _phone = phone;
    _email = email;
    _dateOfBirth = dateOfBirth;
    _gender = gender;
    _navigation = navigation;
    _onlineStatus = onlineStatus;
    _deviceToken = deviceToken;
    _qrCodeImage = qrCodeImage;
    _createdAt = createdAt;
}

  UserData.fromJson(dynamic json) {
    _status = json['status'];
    _accessToken = json['access_token'];
    _tokenType = json['token_type'];
    _userId = json['user_id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _phone = json['phone'];
    _email = json['email'];
    _dateOfBirth = json['date_of_birth'];
    _gender = json['gender'];
    _navigation = json['navigation'];
    _onlineStatus = json['online_status'];
    _deviceToken = json['device_token'];
    _qrCodeImage = json['qrCode_image'];
    _createdAt = json['created_at'];
  }
  bool? _status;
  String? _accessToken;
  String? _tokenType;
  num? _userId;
  String? _firstName;
  String? _lastName;
  String? _phone;
  String? _email;
  String? _dateOfBirth;
  String? _gender;
  String? _navigation;
  num? _onlineStatus;
  String? _deviceToken;
  String? _qrCodeImage;
  String? _createdAt;
UserData copyWith({  bool? status,
  String? accessToken,
  String? tokenType,
  num? userId,
  String? firstName,
  String? lastName,
  String? phone,
  String? email,
  String? dateOfBirth,
  String? gender,
  String? navigation,
  num? onlineStatus,
  String? deviceToken,
  String? qrCodeImage,
  String? createdAt,
}) => UserData(  status: status ?? _status,
  accessToken: accessToken ?? _accessToken,
  tokenType: tokenType ?? _tokenType,
  userId: userId ?? _userId,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  phone: phone ?? _phone,
  email: email ?? _email,
  dateOfBirth: dateOfBirth ?? _dateOfBirth,
  gender: gender ?? _gender,
  navigation: navigation ?? _navigation,
  onlineStatus: onlineStatus ?? _onlineStatus,
  deviceToken: deviceToken ?? _deviceToken,
  qrCodeImage: qrCodeImage ?? _qrCodeImage,
  createdAt: createdAt ?? _createdAt,
);
  bool? get status => _status;
  String? get accessToken => _accessToken;
  String? get tokenType => _tokenType;
  num? get userId => _userId;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get phone => _phone;
  String? get email => _email;
  String? get dateOfBirth => _dateOfBirth;
  String? get gender => _gender;
  String? get navigation => _navigation;
  num? get onlineStatus => _onlineStatus;
  String? get deviceToken => _deviceToken;
  String? get qrCodeImage => _qrCodeImage;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['access_token'] = _accessToken;
    map['token_type'] = _tokenType;
    map['user_id'] = _userId;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['phone'] = _phone;
    map['email'] = _email;
    map['date_of_birth'] = _dateOfBirth;
    map['gender'] = _gender;
    map['navigation'] = _navigation;
    map['online_status'] = _onlineStatus;
    map['device_token'] = _deviceToken;
    map['qrCode_image'] = _qrCodeImage;
    map['created_at'] = _createdAt;
    return map;
  }

}