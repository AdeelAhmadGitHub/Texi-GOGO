class ProfileModel {
  bool? status;
  int? userId;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? dateOfBirth;
  String? gender;
  int? onlineStatus;
  String? deviceToken;
  dynamic driverPercentage;
  String? jobCity;
  String? carType;
  String? address;
  String? profileImage;
  String? nationalInsuranceImage;
  String? insuranceCertificateImage;
  String? insuranceCertificateExpiry;
  String? motCertificateImage;
  String? motCertificateExpiry;
  String? bankStatementImage;
  String? dvlaPdlfImage;
  String? dvlaPdlExpiry;
  String? dvlaEccc;
  String? phdlImage;
  String? phdlExpiry;
  String? vehicleName;
  String? vehicleModel;
  String? vehicleColor;
  String? vehicleNumber;
  dynamic vehiclePassengerCapacity;
  String? phvlImage;
  String? phvlExpiry;
  String? vlbNks;
  String? navigation;
  String? emergencyContactName;
  String? relation;
  String? qrCodeImage;
  String? emergencyContactNo;
  String? emergencyContactEmail;
  String? emergencyContactAddress;
  List<String>? vehicleImages;

  ProfileModel(
      {this.status,
        this.userId,
        this.firstName,
        this.lastName,
        this.phone,
        this.email,
        this.dateOfBirth,
        this.gender,
        this.onlineStatus,
        this.deviceToken,
        this.driverPercentage,
        this.jobCity,
        this.carType,
        this.address,
        this.profileImage,
        this.nationalInsuranceImage,
        this.insuranceCertificateImage,
        this.insuranceCertificateExpiry,
        this.motCertificateImage,
        this.motCertificateExpiry,
        this.bankStatementImage,
        this.dvlaPdlfImage,
        this.dvlaPdlExpiry,
        this.dvlaEccc,
        this.phdlImage,
        this.phdlExpiry,
        this.vehicleName,
        this.vehicleModel,
        this.vehicleColor,
        this.vehicleNumber,
        this.vehiclePassengerCapacity,
        this.phvlImage,
        this.phvlExpiry,
        this.vlbNks,
        this.navigation,
        this.emergencyContactName,
        this.relation,
        this.qrCodeImage,
        this.emergencyContactNo,
        this.emergencyContactEmail,
        this.emergencyContactAddress,
        this.vehicleImages});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    email = json['email'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    onlineStatus = json['online_status'];
    deviceToken = json['device_token'];
    driverPercentage = json['driver_percentage'];
    jobCity = json['job_city'];
    carType = json['car_type'];
    address = json['address'];
    profileImage = json['profile_image'];
    nationalInsuranceImage = json['national_insurance_image'];
    insuranceCertificateImage = json['insurance_certificate_image'];
    insuranceCertificateExpiry = json['insurance_certificate_expiry'];
    motCertificateImage = json['mot_certificate_image'];
    motCertificateExpiry = json['mot_certificate_expiry'];
    bankStatementImage = json['bank_statement_image'];
    dvlaPdlfImage = json['dvla_pdlf_image'];
    dvlaPdlExpiry = json['dvla_pdl_expiry'];
    dvlaEccc = json['dvla_eccc'];
    phdlImage = json['phdl_image'];
    phdlExpiry = json['phdl_expiry'];
    vehicleName = json['vehicle_name'];
    vehicleModel = json['vehicle_model'];
    vehicleColor = json['vehicle_color'];
    vehicleNumber = json['vehicle_number'];
    vehiclePassengerCapacity = json['vehicle_passenger_capacity'];
    phvlImage = json['phvl_image'];
    phvlExpiry = json['phvl_expiry'];
    vlbNks = json['vlb_nks'];
    navigation = json['navigation'];
    emergencyContactName = json['emergency_contact_name'];
    relation = json['relation'];
    qrCodeImage = json['qrCode_image'];
    emergencyContactNo = json['emergency_contact_no'];
    emergencyContactEmail = json['emergency_contact_email'];
    emergencyContactAddress = json['emergency_contact_address'];
    vehicleImages = json['vehicle_images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['user_id'] = this.userId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['date_of_birth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['online_status'] = this.onlineStatus;
    data['device_token'] = this.deviceToken;
    data['driver_percentage'] = this.driverPercentage;
    data['job_city'] = this.jobCity;
    data['car_type'] = this.carType;
    data['address'] = this.address;
    data['profile_image'] = this.profileImage;
    data['national_insurance_image'] = this.nationalInsuranceImage;
    data['insurance_certificate_image'] = this.insuranceCertificateImage;
    data['insurance_certificate_expiry'] = this.insuranceCertificateExpiry;
    data['mot_certificate_image'] = this.motCertificateImage;
    data['mot_certificate_expiry'] = this.motCertificateExpiry;
    data['bank_statement_image'] = this.bankStatementImage;
    data['dvla_pdlf_image'] = this.dvlaPdlfImage;
    data['dvla_pdl_expiry'] = this.dvlaPdlExpiry;
    data['dvla_eccc'] = this.dvlaEccc;
    data['phdl_image'] = this.phdlImage;
    data['phdl_expiry'] = this.phdlExpiry;
    data['vehicle_name'] = this.vehicleName;
    data['vehicle_model'] = this.vehicleModel;
    data['vehicle_color'] = this.vehicleColor;
    data['vehicle_number'] = this.vehicleNumber;
    data['vehicle_passenger_capacity'] = this.vehiclePassengerCapacity;
    data['phvl_image'] = this.phvlImage;
    data['phvl_expiry'] = this.phvlExpiry;
    data['vlb_nks'] = this.vlbNks;
    data['navigation'] = this.navigation;
    data['emergency_contact_name'] = this.emergencyContactName;
    data['relation'] = this.relation;
    data['qrCode_image'] = this.qrCodeImage;
    data['emergency_contact_no'] = this.emergencyContactNo;
    data['emergency_contact_email'] = this.emergencyContactEmail;
    data['emergency_contact_address'] = this.emergencyContactAddress;
    data['vehicle_images'] = this.vehicleImages;
    return data;
  }
}
