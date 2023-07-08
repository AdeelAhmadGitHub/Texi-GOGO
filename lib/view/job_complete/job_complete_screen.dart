import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../components/custom_card.dart';
import '../../components/custom_text.dart';
import '../../const/app_color.dart';

class CompleteJobScreen extends StatelessWidget {
  const CompleteJobScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Image.asset("assets/images/map.PNG"),
            Positioned(
              left: 20.w,
              top: 55.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.arrow_back_ios),
                  SizedBox(width: 50.w),
                ],
              ),
            ),
          ],
        ),
        bottomSheet: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomCard(
                    height: 40.h,
                    width: 135.w,
                    cardColor: AppColors.kBlueColor,
                    borderRadius: BorderRadius.circular(50.r),
                    cardChild: Padding(
                      padding: EdgeInsets.all(10.r),
                      child: Row(
                        children: [
                          Image.asset("assets/images/location.png"),
                          SizedBox(width: 10.w),
                          CustomText(
                            text: "Navigate",
                            fontSize: 16.sp,
                            fontColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            CustomCard(
              width: double.maxFinite,
              cardColor: Colors.white,
              cardChild: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "GBP : 140",
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          fontColor: AppColors.kRedColor,
                        ),
                        CircleAvatar(
                          backgroundColor: AppColors.kPrimaryColor,
                          radius: 20.r,
                          child: Icon(
                            Icons.phone,
                            size: 30.r,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    CustomCard(
                      width: double.maxFinite,
                      cardColor: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 0.2,
                            blurRadius: 15)
                      ],
                      cardChild: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 25.h),
                        child: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 20.r,
                                    color: AppColors.kGreenColor,
                                  ),
                                  SizedBox(
                                    width: 250.w,
                                    child: CustomText(
                                      text: "Imtiaz Super Market - Lahore",
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: List.generate(
                                  3,
                                  (ii) => Padding(
                                      padding: EdgeInsets.only(
                                          left: 8.w,
                                          right: 12.w,
                                          top: 5.h,
                                          bottom: 5.h),
                                      child: Container(
                                        height: 3,
                                        width: 2,
                                        color: Colors.grey,
                                      )),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 20.r,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                  SizedBox(
                                    width: 250.w,
                                    child: CustomText(
                                      text:
                                          "5-K Main Boulevard Gulberg, Block Gulberg 2, Lahore, Punjab",
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50.h),
                    CustomButton(
                        height: 40.h,
                        width: double.maxFinite,
                        buttonColor: AppColors.kPrimaryColor,
                        borderRadius: BorderRadius.circular(10),
                        onTap: () => Get.bottomSheet(
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            CustomCard(
                              borderRadius: BorderRadius.circular(20.r),
                              cardColor: Colors.white,
                              cardChild: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(height: 20.h),
                                  CustomCard(
                                    width: double.maxFinite,
                                    cardColor: Colors.white,
                                    cardChild: SingleChildScrollView(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w),
                                      child: Column(
                                        children: [
                                          CustomText(
                                            text:
                                                "Have you Collected\nthe money?",
                                            fontSize: 24.sp,
                                            fontWeight: FontWeight.bold,
                                            fontColor: AppColors.kBlackColor,
                                          ),
                                          SizedBox(height: 10.h),
                                          CustomText(
                                            text: "GBP : 140",
                                            fontSize: 32.sp,
                                            fontWeight: FontWeight.bold,
                                            fontColor: AppColors.kRedColor,
                                          ),
                                          SizedBox(height: 20.h),
                                          CustomCard(
                                            width: double.maxFinite,
                                            cardColor: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.2),
                                                  spreadRadius: 0.2,
                                                  blurRadius: 15)
                                            ],
                                            cardChild: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.w,
                                                  vertical: 25.h),
                                              child: IntrinsicHeight(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Icon(
                                                          Icons.location_on,
                                                          size: 20.r,
                                                          color: AppColors
                                                              .kGreenColor,
                                                        ),
                                                        SizedBox(
                                                          width: 250.w,
                                                          child: CustomText(
                                                            text:
                                                                "Imtiaz Super Market - Lahore",
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: List.generate(
                                                        3,
                                                        (ii) => Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 8.w,
                                                                    right: 12.w,
                                                                    top: 5.h,
                                                                    bottom:
                                                                        5.h),
                                                            child: Container(
                                                              height: 3,
                                                              width: 2,
                                                              color:
                                                                  Colors.grey,
                                                            )),
                                                      ),
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Icon(
                                                          Icons.location_on,
                                                          size: 20.r,
                                                          color: Colors.black
                                                              .withOpacity(0.5),
                                                        ),
                                                        SizedBox(
                                                          width: 250.w,
                                                          child: CustomText(
                                                            text:
                                                                "5-K Main Boulevard Gulberg, Block Gulberg 2, Lahore, Punjab",
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 10.h),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 50.h),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomButton(
                                                  height: 40.h,
                                                  width: 150.w,
                                                  buttonColor:
                                                      AppColors.kPrimaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  // onTap: () => Get.to(JobPreview()),
                                                  child: Center(
                                                    child: CustomText(
                                                      text: "Yes",
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontColor:
                                                          AppColors.kBlackColor,
                                                    ),
                                                  )),
                                              CustomButton(
                                                height: 40.h,
                                                width: 150.w,
                                                buttonColor:
                                                    AppColors.kGrayColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Center(
                                                  child: CustomText(
                                                    text: "No",
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.bold,
                                                    fontColor:
                                                        AppColors.kBlackColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10.h),
                                          SizedBox(height: 10.h),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        child: Center(
                          child: CustomText(
                            text: "Finish the ride",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            fontColor: AppColors.kBlackColor,
                          ),
                        )),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
