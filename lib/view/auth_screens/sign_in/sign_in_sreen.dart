import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:taxi_gogo/Controllers/RegisterController.dart';
import 'package:taxi_gogo/components/custom_card.dart';
import 'package:taxi_gogo/components/custom_text.dart';
import 'package:taxi_gogo/const/app_color.dart';
import '../../../Controllers/auth_controller.dart';
import '../../../Streeam Builder.dart';
import '../../../components/custom_text_feild.dart';
import '../../EmailVerification/EmailSent.dart';

class SignInScreen extends GetView<AuthController> {
   SignInScreen({Key? key}) : super(key: key);
final registerCont=Get.put(RegisterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 74.h),
            Center(
              child: Image.asset("assets/images/logo.png",
              ),
            ),
            SizedBox(height: 60.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Hi, Welcome To Taxigogo \nDriver app",
                    fontSize: 23.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: 10.h),
                  CustomText(
                    text: "Login in to your account",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    fontColor: Colors.black.withOpacity(0.5),
                  ),
                  SizedBox(height: 20.h),
                  CustomText(
                    text: "Email",
                    fontSize: 16.sp,
                    fontColor: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  CustomTextFieldWithoutIcon(
                    hintText: 'Enter your Email Here ',
                    controller: controller.emailControllerL,
                  ),
                  SizedBox(height: 20.h),
                  CustomText(
                    text: "Password",
                    fontSize: 16.sp,
                    fontColor: Colors.black,
                    // fontWeight: FontWeight.bold,
                  ),
                  Obx(
                    () => CustomPasswordTextField(
                      hintText: "Password",
                      controller: controller.passwordControllerL,
                      icon: Icons.lock,
                      obscureText: controller.isPasswordHide.value,
                      hideIcon: InkWell(
                        onTap: () {
                          controller.isPasswordHide.value =
                              !controller.isPasswordHide.value;
                        },
                        child: Icon(
                          controller.isPasswordHide.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  CustomButton(
                    height: 45.h,
                    width: double.maxFinite,
                    buttonColor: AppColors.kPrimaryColor,
                    onTap: () async {
                      await controller.login();
                    },
                    child: Center(
                      child: CustomText(
                        text: "Log In",
                        fontSize: 16.sp,
                        fontColor: Colors.black,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Visibility(
                    visible: controller.isShowButton,
                    child: Column(
                      children: [
                        Center(
                          child: CustomText(
                            text: "OR",
                            // fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        CustomButton(
                          height: 45.h,
                          width: double.maxFinite,
                          buttonColor: AppColors.kBlackColor,
                          onTap: (){
                            registerCont.getDataApis();
                          },
                          child: Center(
                            child: CustomText(
                              text: "Become a Driver",
                              fontSize: 16.sp,
                              fontColor: AppColors.kPrimaryColor,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
