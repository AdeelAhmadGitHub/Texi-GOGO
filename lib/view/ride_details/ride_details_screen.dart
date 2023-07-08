import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:taxi_gogo/Controllers/home_controller.dart';
import 'package:taxi_gogo/components/custom_card.dart';
import 'package:taxi_gogo/components/custom_text.dart';
import 'package:taxi_gogo/const/app_color.dart';
import 'package:get/get.dart';
class RideDetailsScreen extends StatelessWidget {
  final bool showOnlyDetails;
  int? time;
   RideDetailsScreen({Key? key,this.showOnlyDetails=true,this.time}) : super(key: key);

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
          text: "Ride Details",
          fontSize: 20.sp,
          fontColor: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: GetX<HomeController>(
          builder: (cont) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.h),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(width: 70.w),
                      CustomText(
                        text: "Reference #",
                        fontSize: 18.sp,
                        // fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        text: cont.rideDetails?.value.data?.referenceNo ?? "N/A",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        fontColor: AppColors.kBlackColor,
                      ),
                      SizedBox(width: 40.w),
                      Visibility(
                        visible: cont.screenType==0?true:false,
                        child: TimerCountdown(
                          enableDescriptions: false,
                          format: CountDownTimerFormat
                              .secondsOnly,
                          endTime: DateTime.now().add(
                            Duration(
                              seconds: time ??
                                  0,
                            ),
                          ),
                          onEnd: () {
                            Get.back();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Trip Price GBP : ${cont.rideDetails?.value.data?.bookingPrice ?? "N/A"}",
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          fontColor: AppColors.kRedColor,
                        ),
                        SizedBox(height: 5.h,),
                        CustomText(
                          text: "Driver amount GBP : ${cont.rideDetails?.value.data?.driverPrice ?? "N/A"}",
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          fontColor: AppColors.kBlueColor,
                        ),

                      ],
                    ),
                    Column(
                      children: [
                        CustomText(
                          text: cont.rideDetails?.value.data?.paymentStatus ?? "N/A",
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          fontColor: AppColors.kGreenColor,
                        ),
                        CustomText(
                          text: cont.rideDetails?.value.data?.paymentType?? "N/A",
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          fontColor: AppColors.kGreenColor,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text:
                          "${cont.rideDetails?.value.data?.firstName} ${cont.rideDetails?.value.data?.lastName}",
                      fontSize: 18.sp,
                      fontColor: AppColors.kRedColor,
                    ),
                    CustomText(
                      text: cont.rideDetails?.value.data?.phone ?? "N/A",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      fontColor: Colors.black.withOpacity(0.5),
                    ),
                  ],
                ),
                Divider(height: 20.h, color: Colors.black),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Pickup Date",
                      fontSize: 16.sp,
                      fontColor: AppColors.kBlackColor,
                    ),
                    CustomText(
                      text: cont.rideDetails?.value.data?.pickupDate ?? "N/A",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      fontColor: Colors.black.withOpacity(0.5),
                    ),
                  ],
                ),
                Divider(height: 20.h, color: Colors.black),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Pickup Time",
                      fontSize: 16.sp,
                      fontColor: AppColors.kBlackColor,
                    ),
                    CustomText(
                      text: cont.rideDetails?.value.data?.pickupTime ?? "N/A",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      fontColor: Colors.black.withOpacity(0.5),
                    ),
                  ],
                ),
                Divider(height: 20.h, color: Colors.black),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Passengers:",
                      fontSize: 16.sp,
                      fontColor: AppColors.kBlackColor,
                    ),
                    CustomText(
                      text: cont.rideDetails?.value.data?.passengers.toString() ??
                          "N/A",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      fontColor: Colors.black.withOpacity(0.5),
                    ),
                  ],
                ),
                Divider(height: 20.h, color: Colors.black),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Luggage:",
                      fontSize: 16.sp,
                      fontColor: AppColors.kBlackColor,
                    ),
                    CustomText(
                      text: cont.rideDetails?.value.data?.luggage.toString() ?? "N/A",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      fontColor: Colors.black.withOpacity(0.5),
                    ),
                  ],
                ),
                Divider(height: 20.h, color: Colors.black),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Comments",
                      fontSize: 16.sp,
                      fontColor: AppColors.kBlackColor,
                    ),
                    SizedBox(height: 10.h),
                    SizedBox(
                      width: 335.w,
                      child: CustomText(
                        text: cont.rideDetails?.value.data?.comments ?? "N/A",
                        fontSize: 12.sp,
                        fontColor: AppColors.kBlackColor,
                      ),
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
                        child:  IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding:  EdgeInsets.only(right:4.0.w),
                                        child: Icon(
                                          Icons.location_on,
                                          size: 20.r,
                                          color: AppColors.kGreenColor,
                                        ),
                                      ),
                                      SizedBox(height: 2.h,),
                                      Column(
                                        children: List.generate(
                                          (((cont.rideDetails?.value.data?.pickupAddress?.length??0)*2)~/25)+5,
                                              (i) => Padding(
                                              padding: EdgeInsets.only(
                                                  left: 8.w,
                                                  right: 12.w,
                                                top: 3.h
                                              ),
                                              child: Container(
                                                height: 5.h,
                                                width: 2.w,
                                                color: Colors.grey,
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        width: 250.w,
                                        child: CustomText(
                                          text: cont.rideDetails?.value.data?.pickupAddress ??
                                              "N/A",
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 250.w,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              text: "Pickup Distance: ",
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              fontColor: const Color(0xff2E8FF7),
                                            ),
                                            SizedBox(
                                              width: 138.w,
                                              child: CustomText(
                                                text: "${cont.rideDetails?.value.data?.driverPickupDistance??0} miles away",
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: List.generate(
                                  cont.rideDetails?.value.data?.destinationVia
                                      ?.length ??
                                      0,
                                      (index) {
                                    final waitData =   cont.rideDetails?.value.data?.destinationVia?[index];
                                    return Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            SizedBox(height: 5.h,),
                                            Padding(
                                              padding:  EdgeInsets.only(right:3.0.w),
                                              child: Image.asset(
                                                "assets/images/waitLocation.png",
                                                color: Colors.black,
                                                height:18.h,
                                                width: 18.w,
                                              ),
                                            ),
                                            SizedBox(height: 2.h,),
                                            Column(
                                              children: List.generate(
                                                (((waitData?.destinationAddressVia?.length??0)*2)~/25)+5,
                                                    (i) => Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8.5.w,
                                                        right: 12.w,
                                                        top: 3.h,
                                                    ),
                                                    child: Container(
                                                      height: 5.h,
                                                      width: 2.w,
                                                      color: Colors.grey,
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            SizedBox(height: 5.h,),
                                            SizedBox(
                                              width: 250.w,
                                              child: CustomText(
                                                text: waitData
                                                    ?.destinationAddressVia ??
                                                    "N/A",
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.visible,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 3.h,
                                            ),
                                            SizedBox(
                                              width: 250.w,
                                              child: CustomText(
                                                text:
                                                "Stay Time: ${waitData?.stayTime ?? "0"} minutes",
                                                fontColor:
                                                const Color(0xffF40D04),
                                                fontSize: 13.sp,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            )
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(height: 5.h,),
                                      Padding(
                                        padding:  EdgeInsets.only(right:4.0.w),
                                        child: Icon(
                                          Icons.location_on,
                                          size: 20.r,
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(height: 5.h,),
                                      SizedBox(
                                        width: 250.w,
                                        child: CustomText(
                                          text: cont.rideDetails?.value.data?.destinationAddress ??
                                              "N/A",
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 250.w,
                                        child: Row(
                                          children: [
                                            CustomText(
                                              text: "Drop Off Distance: ",
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              fontColor: const Color(0xff2E8FF7),
                                            ),

                                            CustomText(
                                              text: "${cont.rideDetails?.value.data?.calculativeDistance.toString()} miles away"??
                                                  "0 Km",
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              overflow: TextOverflow.visible,
                                            ),
                                          ],
                                        ),
                                      ),


                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 100.h),
                    Visibility(
                      visible: showOnlyDetails,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButton(
                              height: 40.h,
                              width: 150.w,
                              buttonColor: AppColors.kPrimaryColor,
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                cont.rideAcceptReject(1);
                              },
                              child: Center(
                                child: CustomText(
                                  text: "Accept",
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  fontColor: AppColors.kBlackColor,
                                ),
                              )),
                          CustomButton(
                            height: 40.h,
                            width: 150.w,
                            onTap: () {
                              cont.rideAcceptReject(2);
                            },
                            buttonColor: AppColors.kGrayColor,
                            borderRadius: BorderRadius.circular(10),
                            child: Center(
                              child: CustomText(
                                text: "Reject",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                fontColor: AppColors.kBlackColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
