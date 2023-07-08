import 'dart:async';

import 'package:country_list_pick/country_list_pick.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:taxi_gogo/components/custom_text.dart';
import '../../Controllers/RegisterController.dart';
import '../../Controllers/auth_controller.dart';
import '../../components/CustomOTPTextFiledBox/CustomOTPTextFiledBox.dart';
import '../../components/custom_card.dart';
import '../../components/custom_text_feild.dart';
import '../ConfirmPassword/ConfirmPassword.dart';


class EmailSent extends StatefulWidget {
  EmailSent({Key? key}) : super(key: key);
  static final auth = Get.find<AuthController>();

  @override
  State<EmailSent> createState() => _EmailSentState();
}

class _EmailSentState extends State<EmailSent> {
  final registerCount = Get.put(RegisterController());
  bool showLoading = false;
  final key = GlobalKey<FormState>();
  String? _validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Email is required';
    } else if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
        body: Form(
          key: key,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 37.h, bottom: 30.h),
                        child: Image.asset(
                          "assets/images/logo.png",
                          height: 172.h,
                          width: 189.h,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const CustomText(
                      text: "Create Account",
                      fontColor: Color(0xff36363C),
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
                      child: const CustomText(
                        text: "Please enter your email address for SignUp",
                        fontSize: 12,
                        textAlign: TextAlign.center,
                        fontColor: const Color(0xffAEAEAE),
                      ),
                    ),
                    const CustomText(
                      text: "Email",
                      fontSize: 16,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    TextFormField(
                        controller: registerCount.emailCont,
                        cursorColor: const Color(0xff5AD6FE),
                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.r),
                              borderSide: const BorderSide(
                                color: Color(0xffA8ADB1),
                              )),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.r),
                            borderSide: const BorderSide(
                              color: Color(0xffA8ADB1),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.r),
                            borderSide: const BorderSide(
                              color: Color(0xffA8ADB1),
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.r),
                              borderSide: const BorderSide(
                                color: Colors.red,
                              )),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.r),
                              borderSide: const BorderSide(
                                color: Colors.red,
                              )),
                          contentPadding: EdgeInsets.only(
                              top: 4.h, bottom: 4.h, left: 15.w, right: 10.w),
                          hintText: "Enter your Email Here",
                          hintStyle: TextStyle(
                              fontFamily: "Montserrat-Light",
                              color: const Color(0xffA8ADB1),
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp),
                        ),
                        validator: _validateEmail),
                    SizedBox(
                      height: 210.h,
                    ),
                    CustomButton(
                      height: 54.h,
                      width: double.infinity.w,
                      buttonColor: const Color(0xffDDCA7F),
                      child: const Center(
                          child: CustomText(
                            text: "Send",
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          )),
                      onTap: () {
                        if (key.currentState!.validate()) {
                          registerCount.signUp();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

}
