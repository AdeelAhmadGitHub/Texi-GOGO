import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:taxi_gogo/Controllers/auth_controller.dart';

import '../api/api_checker.dart';
import '../api/api_client.dart';
import '../models/GetCarTypesModel.dart';
import '../models/GetCitiesModel.dart';
import '../models/ProfileModel.dart';
import '../utils/functions.dart';
import '../view/Account/CarType/CarType.dart';
import '../view/Account/DVLALicenseDetails/DVLALicenseDetails.dart';
import '../view/Account/RegisterAccount/register_account.dart';
import 'package:http/http.dart' as http;
import '../view/Account/VehicleLicenseDetails/VehicleLicenseDetails.dart';
import '../view/Profile/Profile.dart';
import '../view/auth_screens/sign_in/sign_in_sreen.dart';

class EditedProfileController extends GetxController {
  ApiChecker apichecker = ApiChecker();
  RxBool isPersonalInformationEdited = true.obs;
  RxBool isDVLALicenceInfoEdited = true.obs;
  RxBool isCartTypeEmergencyContactEdited = true.obs;
  RxBool isVehicleInfoLicenceEdited = true.obs;
  var userId;
  final auth = Get.find<AuthController>();

  Future getDataApis() async {
    popDialog();
    await getCities();
    await getCarTypes();
    await getProfileData();
    Get.back();
    Get.to(Profile());
  }

  popDialog() {
    Get.defaultDialog(
      backgroundColor: Colors.transparent,
      title: "",
      content: WillPopScope(
          onWillPop: () => Future.value(false),
          child: const SpinKitFoldingCube(
            color: Color(0xffDDCA7F),
          )),
    );
  }

// Get Cities apis
  Rx<GetCitiesModel>? setGetCitiesModel;

  Rx<GetCitiesModel>? get getCitiesModel => setGetCitiesModel;

  Future getCities() async {
    Response response = await api.getData(
      "api/getCities",
      headers: {'Accept': 'application/json'},
    );
    if (response == null) {
      errorAlert('Check your internet connection.');
    } else if (response.statusCode == 200) {
      setGetCitiesModel = GetCitiesModel.fromJson(response.body).obs;
    } else {
      errorAlert('Something went wrong\nPlease try again!');
    }
  }

  Rx<ProfileModel>? setProfileModel;

  Rx<ProfileModel>? get getProfileModel => setProfileModel;

  Future getProfileData() async {
    print(auth.user?.accessToken);
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${auth.user?.accessToken}'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('${baseUrl}api/view-profile'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      setProfileModel = ProfileModel.fromJson(jsonDecode(responseData)).obs;
      print(jsonDecode(responseData));
    } else {
      print(response.reasonPhrase);
    }
  }

  // Get Cities apis
  Rx<GetCarTypesModel>? setGetCarTypesModel;

  Rx<GetCarTypesModel>? get getCarTypesModel => setGetCarTypesModel;

  Future getCarTypes() async {
    Response response = await api.getData(
      "api/getCarTypes",
      headers: {'Accept': 'application/json'},
    );
    if (response == null) {
      errorAlert('Check your internet connection.');
    } else if (response.statusCode == 200) {
      setGetCarTypesModel = GetCarTypesModel.fromJson(response.body).obs;
    } else {
      errorAlert('Something went wrong\nPlease try again!');
    }
  }

  // SignUp Variables
  TextEditingController oneController = TextEditingController();
  TextEditingController twoController = TextEditingController();
  TextEditingController threeController = TextEditingController();
  TextEditingController fourController = TextEditingController();
  TextEditingController fiveController = TextEditingController();
  TextEditingController sixController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController emailCont = TextEditingController();

  // Password Controller

  TextEditingController passwordCont = TextEditingController();
  TextEditingController confirmPasswordCont = TextEditingController();
  ApiClient api = ApiClient(appBaseUrl: baseUrl);

  Future signUp() async {
    print(emailCont.text);
    print(passwordCont.text);
    print(emailCont.text);
    Response response = await api.postWithForm(
        "api/signUp",
        {
          'email': emailCont.text,
          'password': passwordCont.text,
          'password_confirmation': confirmPasswordCont.text,
        },
        headers: {'Accept': 'application/json'},
        showdialog: true);
    print(response.statusCode);
    if (response == null) {
      errorAlert('Check your internet connection.');
    } else if (response.statusCode == 200) {
      userId = response.body['user_id'];
      print(userId);
      Get.to(const RegisterAccount());
    } else {
      errorAlert('Something went wrong\nPlease try again!');
    }
  }

  // Register Account Variables
  //////////////////////////////////////////////////////
  RxString setExpiryDate = "Select Date".obs;
  Rx<DataCity>? setLicencingDistrict;
  RxString setDob = "Select Date".obs;
  Rx<File>? setBankStatementImage;
  Rx<File>? setProfileImage;
  Rx<File>? setNationalInsuranceImage;
  Rx<File>? setPrivateLicenseImage;
  RxInt setSelected = 0.obs;
  RxString? setGender;
  RxList<String> genderList = ["Male", "Female"].obs;

// Get Variable Values
  RxInt get selected => setSelected;

  RxString get dob => setDob;

  RxString? get gender => setGender;

  Rx<DataCity>? get licencingDistrict => setLicencingDistrict;

  RxString get expiryDate => setExpiryDate;

  Rx<File>? get profileImage => setProfileImage;

  Rx<File>? get bankStatementImage => setBankStatementImage;

  Rx<File>? get nationalInsuranceImage => setNationalInsuranceImage;

  Rx<File>? get privateLicenseImage => setPrivateLicenseImage;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController homeAddress = TextEditingController();

  Future registerAccount() async {
    popDialog();
    var headers = {'Accept': 'application/json'};
    var request =
        http.MultipartRequest('POST', Uri.parse('${baseUrl}api/createAccount'));
    request.fields.addAll({
      'user_id': "${auth.user?.userId}",
      'first_name': firstName.text,
      'last_name': lastName.text,
      'dob': dob.value,
      'gender': gender?.value ?? getProfileModel?.value.gender ?? "",
      'phone': phoneNumber.text,
      'address': homeAddress.text,
      'licencing_district': licencingDistrict?.value.id.toString() ??
          getProfileModel?.value.jobCity ??
          "",
      'phdl_expiry': expiryDate.value
    });
    if (profileImage?.value != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'profile_image', profileImage!.value.path));
    }
    if (bankStatementImage?.value != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'bank_statement_image', bankStatementImage!.value.path));
    }
    if (nationalInsuranceImage?.value != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'national_insurance', nationalInsuranceImage!.value.path));
    }
    if (privateLicenseImage?.value != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'phdl_image', privateLicenseImage!.value.path));
    }
    request.headers.addAll(headers);
    http.StreamedResponse streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    Get.back();
    Response responseGet = await apichecker.checkApi(respons: response);
    if (responseGet == null) {
      errorAlert('Check your internet connection.');
    } else if (responseGet.statusCode == 200) {
      Get.close(2);
    } else {
      errorAlert('Something went wrong\nPlease try again!');
    }
  }

//////////////////////////////////////////////////////

// DVLA & License Details
  Rx<File>? setDVLALicenseImage;
  Rx<File>? setV5CImage;
  RxString setLicenseExpiryDate = "Select Date".obs;

// DVLA & License Details Variables
  RxString get licenseExpiryDate => setLicenseExpiryDate;

  Rx<File>? get dVLALicenseImage => setDVLALicenseImage;

  Rx<File>? get v5CImage => setV5CImage;
  TextEditingController dVLACodeCont = TextEditingController();

  Future dVLAAccount() async {
    popDialog();
    var headers = {'Accept': 'application/json'};
    var request =
        http.MultipartRequest('POST', Uri.parse('${baseUrl}api/DVLA'));
    request.fields.addAll({
      'user_id': "${auth.user?.userId}",
      'dvla_pdl_expiry': licenseExpiryDate.value,
      'dvla_eccc': dVLACodeCont.text
    });
    if (dVLALicenseImage?.value != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'dvla_pdlf_image', dVLALicenseImage!.value.path));
    }
    if (v5CImage?.value != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'vlb_nks_image', v5CImage!.value.path));
    }
    request.headers.addAll(headers);

    http.StreamedResponse streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    Get.back();
    Response responseGet = await apichecker.checkApi(respons: response);
    if (responseGet == null) {
      errorAlert('Check your internet connection.');
    } else if (responseGet.statusCode == 200) {
      Get.close(2);
    } else {
      errorAlert('Something went wrong\nPlease try again!');
    }
  }

  //////////////////////////////////////////////////////
// Vehicle Details & Vehicle License Details
  RxList<File> setVehicleImages = <File>[].obs;
  Rx<File>? setPrivateHireVehicleImage;
  Rx<File>? setInsuranceCertificateImage;
  Rx<File>? setMOTCertificateImage;

  RxString setMotoExpiryDate = "Select Date".obs;
  RxString setInsuranceExpiryDate = "Select Date".obs;
  RxString setHireLicenseExpiryDate = "Select Date".obs;

// Vehicle Details & Vehicle License Details Variables
  RxList<File> get vehicleImages => setVehicleImages;

  Rx<File>? get privateHireVehicleImage => setPrivateHireVehicleImage;

  Rx<File>? get insuranceCertificateImage => setInsuranceCertificateImage;

  Rx<File>? get mOTCertificateImage => setMOTCertificateImage;

  RxString get motoExpiryDate => setMotoExpiryDate;

  RxString get insuranceExpiryDate => setInsuranceExpiryDate;

  RxString get hireLicenseExpiryDate => setHireLicenseExpiryDate;

  TextEditingController vehicleMakeCont = TextEditingController();
  TextEditingController vehicleMakeModel = TextEditingController();
  TextEditingController vehicleColor = TextEditingController();
  TextEditingController vehicleReg = TextEditingController();
  TextEditingController vehiclePassengerCapacity = TextEditingController();

  Future vehicleDetails() async {
    popDialog();
    var headers = {'Accept': 'application/json'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('${baseUrl}api/VehicleDetails'));
    request.fields.addAll({
      'user_id': "${auth.user?.userId}",
      'vehicle_make': vehicleMakeCont.text,
      'vehicle_model': vehicleMakeModel.text,
      'vehicle_color': vehicleColor.text,
      'vehicle_number': vehicleReg.text,
      'vehicle_passenger_capacity': vehiclePassengerCapacity.text,
      'phvl_expiry': hireLicenseExpiryDate.value,
      'insurance_certificate_expiry': insuranceExpiryDate.value,
      'mot_certificate_expiry': motoExpiryDate.value
    });
    if (vehicleImages.isNotEmpty) {
      for (int i = 0; i < vehicleImages.length; i++) {
        request.files.add(await http.MultipartFile.fromPath(
            'vehicle_images[]', vehicleImages[i].path));
      }
    }

    if (privateHireVehicleImage?.value != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'phvl_image', privateHireVehicleImage!.value.path));
    }
    if (insuranceCertificateImage?.value != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'insurance_certificate_image',
        insuranceCertificateImage!.value.path,
      ));
    }
    if (mOTCertificateImage?.value != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'mot_certificate_image', mOTCertificateImage!.value.path));
    }
    request.headers.addAll(headers);

    http.StreamedResponse streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    Get.back();
    Response responseGet = await apichecker.checkApi(respons: response);
    if (responseGet == null) {
      errorAlert('Check your internet connection.');
    } else if (responseGet.statusCode == 200) {
      Get.close(2);
      print("Good");
    } else {
      errorAlert('Something went wrong\nPlease try again!');
    }
  }

  ///////////////////////////////////////////////////
// Emergency Contact Details variables
  Rx<DataCarType>? setCarType;

// Emergency Contact Details variables value
  Rx<DataCarType>? get carType => setCarType;

  TextEditingController contactNameCont = TextEditingController();
  TextEditingController relationWithYouCont = TextEditingController();
  TextEditingController contactNumberCont = TextEditingController();
  TextEditingController contactEmailCont = TextEditingController();
  TextEditingController contactAddressCont = TextEditingController();

  Future driverCarType() async {
    popDialog();
    var headers = {'Accept': 'application/json'};
    var request =
        http.MultipartRequest('POST', Uri.parse('${baseUrl}api/DriverCarType'));
    request.fields.addAll({
      'user_id': "${auth.user?.userId}",
      'car_type': carType?.value.carName ?? "${getProfileModel?.value.carType}",
      'emergency_contact_name': contactNameCont.text,
      'relation': relationWithYouCont.text,
      'emergency_contact_number': contactNumberCont.text,
      'emergency_contact_email': contactEmailCont.text,
      'emergency_contact_address': contactAddressCont.text
    });
    request.headers.addAll(headers);

    http.StreamedResponse streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    Get.back();
    Response responseGet = await apichecker.checkApi(respons: response);
    if (responseGet == null) {
      errorAlert('Check your internet connection.');
    } else if (responseGet.statusCode == 200) {
      Get.close(2);
    } else {
      errorAlert('Something went wrong\nPlease try again!');
    }
  }
}
