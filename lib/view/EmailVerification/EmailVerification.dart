import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Controllers/RegisterController.dart';
import '../../components/custom_card.dart';
import '../../components/custom_text.dart';
import '../ConfirmPassword/ConfirmPassword.dart';
import 'EmailSent.dart';

class EmailVerification extends StatelessWidget {
  EmailVerification({Key? key}) : super(key: key);
  final registerCount = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 30.h,
                  ),
                  child: Image.asset(
                    "assets/images/logo.png",
                    height: 172.h,
                    width: 189.h,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 40.h,
                  ),
                  child: Image.asset(
                    "assets/images/Vector.png",
                    height: 55.h,
                    width: 80.h,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16.h),
                  child: CustomText(
                    text: "Check Your Email",
                    fontSize: 23,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: CustomText(
                    text: """Please check the email address\n${registerCount.emailCont.text} for instructions\nto verify your email.""",
                    fontColor: const Color(0xffAEAEAE),
                    fontSize: 14,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 200.h,
                  ),
                  child: CustomButton(
                    height: 54.h,
                    width: double.infinity.w,
                    buttonColor: const Color(0xffDDCA7F),
                    child: const Center(
                        child: CustomText(
                      text: "Verified Successfully",
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    )),
                    onTap: () async {
                      registerCount.emailVerification();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.clear();
                        Get.off(EmailSent());
                      },
                      child: const CustomText(
                        text: "Change Email?",
                        fontColor: const Color(0xffDDCA7F),
                        fontSize: 12,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
