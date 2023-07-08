import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../components/custom_card.dart';
import '../../components/custom_text.dart';
import '../../const/app_color.dart';
import '../job_complete/job_complete_screen.dart';

class StartJobScreen extends StatelessWidget {
  const StartJobScreen({Key? key}) : super(key: key);

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
                  InkWell(
                      onTap: (){
                        Get.back();
                      },
                      child: const Icon(Icons.arrow_back_ios)),
                  SizedBox(width: 50.w),
                  CustomText(
                    text: "Customer is coming",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
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
                          backgroundColor: AppColors.kBlackColor,
                          radius: 20.r,
                          child: Icon(
                            Icons.phone,
                            size: 30.r,
                            color: Colors.white,
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
                        onTap: () => Get.to(CompleteJobScreen()),
                        child: Center(
                          child: CustomText(
                            text: "Picked and start",
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
