import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Controllers/auth_controller.dart';
import '../../components/custom_card.dart';
import '../../components/custom_text.dart';
import '../../const/app_color.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool currentShow = true;
  bool newShow = true;
  bool confirmedShow = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kBlackColor,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios)),
        title: CustomText(
          text: "Change Password",
          fontSize: 20.sp,
          fontColor: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 30.h),
            child: GetBuilder(
              init: AuthController(),
              builder: (cont) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: "Change Pasword",
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0.h),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                          controller: cont.newController,
                          cursorColor: const Color(0xffE76880),
                          obscureText: newShow,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 9.h),
                            labelText: "New Password",
                            labelStyle: TextStyle(
                                fontFamily: "Rubik",
                                color: const Color(0xff96CCD5),
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  newShow = !newShow;
                                });
                              },
                              icon: Icon(newShow == false
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        controller: cont.confirmedController,
                        cursorColor: const Color(0xffE76880),
                        obscureText: confirmedShow,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 9.h),
                          labelText: "Confirmed Password",
                          labelStyle: TextStyle(
                              fontFamily: "Rubik",
                              color: const Color(0xff96CCD5),
                              fontWeight: FontWeight.w500,
                              fontSize: 15.sp),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                confirmedShow = !confirmedShow;
                              });
                            },
                            icon: Icon(confirmedShow == false
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    CustomButton(
                      height: 45.h,
                      width: double.maxFinite,
                      buttonColor: AppColors.kPrimaryColor,
                      onTap: () async {
                        if (cont.newController.text.isEmpty ||
                            cont.confirmedController.text.isEmpty) {
                          Get.defaultDialog(
                              title: "Fill",
                              middleText: "Please fill all filed");
                        } else {
                          cont.changePassword();
                        }
                      },
                      child: Center(
                        child: CustomText(
                          text: "Continue",
                          fontSize: 16.sp,
                          fontColor: Colors.black,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );
              },
            )),
      ),
    );
  }
}
