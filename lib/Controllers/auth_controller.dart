import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_gogo/Controllers/home_controller.dart';
import 'package:taxi_gogo/Controllers/update_location_controller.dart';
import '../Notification/firebase_messaging.dart';
import '../api/api_checker.dart';
import '../api/api_client.dart';
import '../models/UserData.dart';
import '../utils/app_constants.dart';
import '../utils/functions.dart';
import '../view/auth_screens/sign_in/sign_in_sreen.dart';
import '../view/home/BottomNavigationScreen.dart';
import '../view/home/home_screen.dart';
bool loginStatus=false;
class AuthController extends GetxController {
  RxBool isPasswordHide = true.obs;
  TextEditingController emailControllerL = TextEditingController();
  TextEditingController passwordControllerL = TextEditingController();
  TextEditingController newController = TextEditingController();
  TextEditingController confirmedController = TextEditingController();
  TextEditingController phoneCont = TextEditingController();
  bool isLogin = false;
  late SharedPreferences prefs;
  String? token;
  bool isShowButton = true;
  UserData? user;
  ApiClient api = ApiClient(appBaseUrl: baseUrl);
  ApiChecker apichecker = ApiChecker();
  @override
  Future<void> onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
  }

  Future getuserDetail() async {
    print("Goddddddddddddddddddddddddddddddddd");
    tokenMain = prefs.getString(AppConstants().token);
    token = prefs.getString(AppConstants().token);
    print("////////////////////////////////////////");
    print(token);
    print("////////////////////////////////////////");
    api.updateHeader(token ?? "");
    print(jsonDecode(prefs.getString(AppConstants().userdata)!));
    try {
      print("goood");
      user = UserData.fromJson(
          jsonDecode(prefs.getString(AppConstants().userdata)!));
    } catch (e) {
      Get.offAll(SignInScreen());
      print(e);
    }
    update();
  }

  Future<Widget> checkUserLoggedIn() async {
    final SharedPreferences prefss = await SharedPreferences.getInstance();
    bool isLogin = (prefss.get(AppConstants().userdata) == null ? false : true);
    if (isLogin) {
      await getuserDetail();
      return const BottomNavigationScreen();
    } else {
      return SignInScreen();
    }
  }

  Future login() async {
    loginStatus=true;
    Response response = await api.postData(
      "api/login",
      {
        "email": emailControllerL.text,
        "password": passwordControllerL.text,
        "device_token": deviceToken ?? '',
      },
    );
    if (response == null) {
      errorAlert('Check your internet connection.');
    } else if (response.statusCode == 200) {
      if (response.body['status'] == "failed") {
        Get.defaultDialog(
          title: '',
          titlePadding: EdgeInsets.zero,
          content: Column(
            children: const [
              SizedBox(
                width: 200,
                child: Text(
                  "Your profile is under review,\nwaiting for the admin approval",
                  textAlign: TextAlign.center,
                  // style: AppTextStyle.mediumBlack14,
                ),
              ),
            ],
          ),
        );
      } else {
        emailControllerL.clear();
        passwordControllerL.clear();
        print(response.body["access_token"]);
        tokenMain = response.body["access_token"];
        await prefs.setString(
            AppConstants().token, response.body["access_token"]);
        onLoginSuccess(response.body);
      }
    } else {
      errorAlert('Something went wrong\nPlease try again!');
    }
  }

  void onLoginSuccess(Map<String, dynamic> value) async {
    await prefs.setString(AppConstants().userdata, jsonEncode(value));
    await getuserDetail();
    isLogin = true;
    Get.offAll(const BottomNavigationScreen());
    update();
  }

  Future<void> logout() async {
    Response response = await api.postData(
      "api/logout",
      {},
    );
    if (response == null) {
      errorAlert('Check your internet connection.');
    } else if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(AppConstants().token);
      await prefs.remove(AppConstants().userdata);
      await prefs.clear();
      Get.offAll(() => SignInScreen());
    } else {
      errorAlert('Something went wrong\nPlease try again!');
    }

  }

  Future changePassword() async {
    Response response = await api.postWithForm(
      "api/changePassword",
      {
        "password": newController.text.trim(),
        "password_confirmation": confirmedController.text.trim(),
      },
    );
    if (response == null) {
      errorAlert('Check your internet connection.');
    } else if (response.statusCode == 200) {
      Get.to(const HomeScreen());
    } else {
      errorAlert('Something went wrong\nPlease try again!');
    }
  }
}
