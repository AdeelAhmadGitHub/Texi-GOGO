import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_gogo/Controllers/auth_controller.dart';
import 'package:taxi_gogo/components/custom_card.dart';

import '../api/api_checker.dart';
import '../api/api_client.dart';
import '../components/custom_text.dart';
import '../models/GetCarTypesModel.dart';
import '../models/GetCitiesModel.dart';
import '../utils/functions.dart';
import '../view/Account/CarType/CarType.dart';
import '../view/Account/DVLALicenseDetails/DVLALicenseDetails.dart';
import '../view/Account/RegisterAccount/register_account.dart';
import 'package:http/http.dart' as http;

import '../view/Account/VehicleLicenseDetails/VehicleLicenseDetails.dart';
import '../view/ConfirmPassword/ConfirmPassword.dart';
import '../view/EmailVerification/EmailSent.dart';
import '../view/EmailVerification/EmailVerification.dart';
import '../view/auth_screens/sign_in/sign_in_sreen.dart';

class RegisterController extends GetxController {
  ApiChecker apichecker = ApiChecker();
  var userId;
  final auth = Get.find<AuthController>();
  final String statusS = 'currentStatus';
  final String userIdS = 'userId';
  final String userEmailS = 'userEmail';
  int currentStatus = 0;

  Future getDataApis() async {
    popDialog();
    await getCities();
    await getCarTypes();
    await checkStatus();
    Get.back();
    if (currentStatus == 0) {
      Get.to(EmailSent());
    } else if (currentStatus == 1) {
      Get.to(EmailVerification());
    } else if (currentStatus == 2) {
      Get.to(const ConfirmPassword());
    } else if (currentStatus == 3) {
      Get.to(const RegisterAccount());
    } else if (currentStatus == 4) {
      Get.to(const DVLALicenseDetails());
    } else if (currentStatus == 5) {
      Get.to(const VehicleLicenseDetails());
    } else if (currentStatus == 6) {
      Get.to(const CarType());
    } else {
      Get.to(EmailSent());
    }

    //com Get.to(RegisterAccount());
  }

  checkStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString(userIdS);
    emailCont.text = prefs.getString(userEmailS) ?? "";
    currentStatus = prefs.getInt(statusS) ?? 0;
    print("good");
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
 // Rx<GetCitiesModel>? setGetCitiesModel;
  GetCitiesModel? getCitiesModel;

 // Rx<GetCitiesModel>? get getCitiesModel => setGetCitiesModel;

  Future getCities() async {
    Response response = await api.getData(
      "api/getCities",
      headers: {'Accept': 'application/json'},
    );
    if (response == null) {
      errorAlert('Check your internet connection.');
    } else if (response.statusCode == 200) {
      getCitiesModel = GetCitiesModel.fromJson(response.body);
      update();
    } else {
      errorAlert('Something went wrong\nPlease try again!');
    }
  }

  // Get Cities apis
  GetCarTypesModel? getCarTypesModel;
 // Rx<GetCarTypesModel>? setGetCarTypesModel;

 // Rx<GetCarTypesModel>? get getCarTypesModel => setGetCarTypesModel;

  Future getCarTypes() async {
    Response response = await api.getData(
      "api/getCarTypes",
      headers: {'Accept': 'application/json'},
    );
    if (response == null) {
      errorAlert('Check your internet connection.');
    } else if (response.statusCode == 200) {
      getCarTypesModel = GetCarTypesModel.fromJson(response.body);
    } else {
      errorAlert('Something went wrong\nPlease try again!');
    }
  }

  // SignUp Variables
  TextEditingController emailCont = TextEditingController();

  // Password Controller

  TextEditingController passwordCont = TextEditingController();
  TextEditingController confirmPasswordCont = TextEditingController();
  ApiClient api = ApiClient(appBaseUrl: baseUrl);

  Future signUp() async {
    Response response = await api.postWithForm(
        "api/signUp",
        {
          'email': emailCont.text,
        },
        headers: {'Accept': 'application/json'},
        showdialog: true);
    print(response.statusCode);
    if (response == null) {
      errorAlert('Check your internet connection.');
    } else if (response.statusCode == 200) {
      userId = response.body['user_id'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt(statusS, 1);
      prefs.setString(userIdS, userId.toString());
      prefs.setString(userEmailS, emailCont.text.trim());
      Get.to(EmailVerification());
    } else {
      errorAlert('Something went wrong\nPlease try again!');
    }
  }

  Future emailVerification() async {
    Response response = await api.postWithForm(
        "api/verifyEmail",
        {
          'email': emailCont.text,
        },
        headers: {'Accept': 'application/json'},
        showdialog: true);
    print(response.statusCode);
    if (response == null) {
      errorAlert('Check your internet connection.');
    } else if (response.statusCode == 200) {
      if (response.body['status'] == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt(statusS, 2);
        Get.to(const ConfirmPassword());
      } else {
        Get.defaultDialog(
          barrierDismissible: false,
          radius: 10,
          title: 'Note',
          titlePadding: EdgeInsets.only(top: 20.h),
          content: Column(
            children:  [
            const  SizedBox(
                width: 224,
                child: Text(
                  """Your Email address can’t be\nverified please go to your email\nand confirm it.""",
                  textAlign: TextAlign.center,
                  // style: AppTextStyle.mediumBlack14,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 13.h,
                ),
                child: CustomButton(
                  height: 34.h,
                  width: 224.w,
                  borderRadius: BorderRadius.circular(5),
                  buttonColor: const Color(0xffDDCA7F),
                  child: const Center(
                      child: CustomText(
                        text: "Cancel",
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      )),
                  onTap: () async {
                  Get.back();
                  },
                ),
              ),
            ],
          ),
        );
      }
    } else {
      errorAlert('Something went wrong\nPlease try again!');
    }
  }

  Future createPassword() async {
    Response response = await api.postWithForm(
        "api/setPassword",
        {
          'user_id': "$userId",
          'password': passwordCont.text,
          'password_confirmation': confirmPasswordCont.text,
        },
        headers: {'Accept': 'application/json'},
        showdialog: true);
    print(response.statusCode);
    if (response == null) {
      errorAlert('Check your internet connection.');
    } else if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt(statusS, 3);
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

// Get Variable Values
  RxInt get selected => setSelected;

  RxString get dob => setDob;

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
      'user_id': "$userId",
      'first_name': firstName.text,
      'last_name': lastName.text,
      'dob': dob.value,
      'gender': selected.value == 0 ? "Male" : "Female",
      'phone': phoneNumber.text,
      'address': homeAddress.text,
      'licencing_district': licencingDistrict!.value.id.toString(),
     'phdl_expiry': ""
     //'phdl_expiry': expiryDate.value
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
      Get.back();
      errorAlert('Check your internet connection.');
    } else if (responseGet.statusCode == 401 || responseGet.statusCode == 403) {
      Get.back();
    } else if (response.statusCode >= 500) {
      Get.back();
    } else if (response.statusCode >= 400) {
      Get.back();
    } else if (responseGet.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt(statusS, 4);
      Get.to(const DVLALicenseDetails());
    } else {
      Get.back();
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
      'user_id': "$userId",
      //'dvla_pdl_expiry': licenseExpiryDate.value,
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
      Get.back();
      errorAlert('Check your internet connection.');
    } else if (responseGet.statusCode == 401 || responseGet.statusCode == 403) {
      Get.back();
    } else if (response.statusCode >= 500) {
      Get.back();
    } else if (response.statusCode >= 400) {
      Get.back();
    } else if (responseGet.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt(statusS, 5);
      Get.to(const VehicleLicenseDetails());
    } else {
      Get.back();
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
      'user_id': "$userId",
      'vehicle_make': vehicleMakeCont.text,
      'vehicle_model': vehicleMakeModel.text,
      'vehicle_color': vehicleColor.text,
      'vehicle_number': vehicleReg.text,
      'vehicle_passenger_capacity': vehiclePassengerCapacity.text,
      //'phvl_expiry': hireLicenseExpiryDate.value,
      //'insurance_certificate_expiry': insuranceExpiryDate.value,
      //'mot_certificate_expiry': motoExpiryDate.value
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
      Get.back();
      errorAlert('Check your internet connection.');
    } else if (responseGet.statusCode == 401 || responseGet.statusCode == 403) {
      Get.back();
    } else if (response.statusCode >= 500) {
      Get.back();
    } else if (response.statusCode >= 400) {
      Get.back();
    } else if (responseGet.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt(statusS, 6);
      Get.to(const CarType());
    } else {
      Get.back();
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
    print("${carType?.value.id}");
    print("$userId");
    request.fields.addAll({
      'user_id': "$userId",
      'car_type': "${carType?.value.carName}",
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
      Get.back();
      errorAlert('Check your internet connection.');
    } else if (responseGet.statusCode == 401 || responseGet.statusCode == 403) {
      Get.back();
    } else if (response.statusCode >= 500) {
      Get.back();
    } else if (response.statusCode >= 400) {
      Get.back();
    } else if (responseGet.statusCode == 200) {
      auth.isShowButton = false;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt(statusS, 7);
      Get.offAll(SignInScreen());
    } else {
      Get.back();
      errorAlert('Something went wrong\nPlease try again!');
    }
  }
}
