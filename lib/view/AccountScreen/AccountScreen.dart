import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Controllers/EditedProfileController.dart';
import '../../Controllers/auth_controller.dart';
import '../../components/custom_text.dart';
import '../../const/app_color.dart';
class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.kBlackColor,
          centerTitle: true,
          elevation: 0,
          title: CustomText(
            text: "Account",
            fontSize: 20.sp,
            fontColor: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: GetBuilder(
            init: EditedProfileController(),
            builder: (cont) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    InkWell(
                      onTap: () {
                        cont.getDataApis();
                        },
                      child: Container(
                        height: 80.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.r),
                            color: const Color(0xff000000)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CustomText(
                                    text: "Profile",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    fontColor: Color(0xffF4F8FB),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  const CustomText(
                                    text: "View your profile and edit",
                                    fontSize: 12,
                                    fontColor: Color(0xffF4F8FB),
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Color(0xffF4F8FB),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      height: 80.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.r),
                          color: const Color(0xff000000)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CustomText(
                                  text: "Privacy Policy",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  fontColor: Color(0xffF4F8FB),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                const CustomText(
                                  text: "Policy Statement",
                                  fontSize: 12,
                                  fontColor: Color(0xffF4F8FB),
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Color(0xffF4F8FB),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      height: 80.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.r),
                          color: const Color(0xff000000)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CustomText(
                                  text: "FAQS",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  fontColor: Color(0xffF4F8FB),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                const CustomText(
                                  text: "FAQS Statement",
                                  fontSize: 12,
                                  fontColor: Color(0xffF4F8FB),
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Color(0xffF4F8FB),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      height: 80.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.r),
                          color: const Color(0xff000000)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CustomText(
                                  text: "Term & Conditions",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  fontColor: Color(0xffF4F8FB),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                const CustomText(
                                  text: "Terms and Conditions Statement",
                                  fontSize: 12,
                                  fontColor: Color(0xffF4F8FB),
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Color(0xffF4F8FB),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      height: 80.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.r),
                          color: const Color(0xff000000)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CustomText(
                                  text: "Contact Us",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  fontColor: Color(0xffF4F8FB),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                const CustomText(
                                  text: "If you have any query contact us any time",
                                  fontSize: 12,
                                  fontColor: Color(0xffF4F8FB),
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Color(0xffF4F8FB),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    ListTile(
                      onTap: () async {
                        await Get.find<AuthController>().logout();
                      },
                      leading: Image.asset(
                        "assets/images/LogOutIcon.png",
                        height: 20.h,
                        width: 20.w,
                        color:  Colors.black,
                      ),
                      title: const CustomText(
                        text: "Logout",
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        fontColor: Color(0xff000000),
                      ),
                      dense: true,
                      visualDensity:
                      const VisualDensity(horizontal: -4, vertical: -1),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }
}
