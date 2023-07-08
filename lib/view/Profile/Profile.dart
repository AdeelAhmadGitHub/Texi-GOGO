import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi_gogo/components/custom_text.dart';
import 'package:taxi_gogo/const/app_color.dart';
import 'package:get/get.dart';
import '../../Controllers/EditedProfileController.dart';
import '../../Controllers/wallet_controller.dart';
import 'CartTypeEmergencyContact.dart';
import 'DVLA&LicenceInfo.dart';
import 'Personal Information.dart';
import 'VehicleInfoLicence.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: EditedProfileController(),
        builder: (cont) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 283.h,
                      width: double.infinity,
                      color: AppColors.kBlackColor,
                      child: Padding(
                        padding: EdgeInsets.only(top: 30.0.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 20.w,
                            ),
                            InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Color(0xffFFFFFF),
                                )),
                            SizedBox(
                              width: 100.w,
                            ),
                            CustomText(
                              text: "Profile",
                              fontSize: 20.sp,
                              fontColor: Colors.white,
                              fontWeight: FontWeight.bold,
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 153.0.h),
                      child: Center(
                        child: SizedBox(
                          height: 176.h,
                          width: 335.w,
                          child: Card(
                            child: Center(
                              child: CustomText(
                                text: "${cont.getProfileModel?.value.firstName} ${cont.getProfileModel?.value.lastName}",
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 89.0.h),
                        child: Container(
                          height: 128.h,
                          width: 128.w,
                          decoration:const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Center(
                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                height: 128.h,
                                width: 128.w,
                                imageUrl: cont.getProfileModel?.value.profileImage??"",
                                errorWidget: (context, url, error) => SizedBox(),
                              ),

                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal:20.0.w),
                  child: Column(
                    children: [
                      InkWell(
                        onTap:(){
                          Get.to( ProfileInformation());
                        },
                        child: Container(
                          height: 80.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.kBlackColor,

                          ),
                          child:  Center(
                            child:  Padding(
                              padding:  EdgeInsets.symmetric(horizontal:20.0.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:const [
                                  CustomText(
                                    text: "Personal Information",
                                    fontColor: Color(0xffFFFFFF),
                                    fontSize: 16,fontWeight: FontWeight.w500,
                                  ),
                                  Icon(Icons.arrow_forward_ios_rounded,
                                    size: 14,

                                    color: Color(0xffFFFFFF),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      InkWell(
                        onTap:(){
                          Get.to( DVLALicenceInfo());
                        },
                        child: Container(
                          height: 80.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.kBlackColor,

                          ),
                          child:  Center(
                            child:  Padding(
                              padding:  EdgeInsets.symmetric(horizontal:20.0.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:const [
                                  CustomText(
                                    text: "DVLA & Licence Info",
                                    fontColor: Color(0xffFFFFFF),
                                    fontSize: 16,fontWeight: FontWeight.w500,
                                  ),
                                  Icon(Icons.arrow_forward_ios_rounded,
                                    size: 14,

                                    color: Color(0xffFFFFFF),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      InkWell(
                        onTap:(){
                          Get.to( VehicleInfoLicence());
                        },
                        child: Container(
                          height: 80.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.kBlackColor,

                          ),
                          child:  Center(
                            child:  Padding(
                              padding:  EdgeInsets.symmetric(horizontal:20.0.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:const [
                                  CustomText(
                                    text: "Vehicle Info & Licence",
                                    fontColor: Color(0xffFFFFFF),
                                    fontSize: 16,fontWeight: FontWeight.w500,
                                  ),
                                  Icon(Icons.arrow_forward_ios_rounded,
                                    size: 14,

                                    color: Color(0xffFFFFFF),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      InkWell(
                        onTap:(){
                          Get.to( CartTypeEmergencyContact());
                        },
                        child: Container(
                          height: 80.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.kBlackColor,

                          ),
                          child:  Center(
                            child:  Padding(
                              padding:  EdgeInsets.symmetric(horizontal:20.0.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:const [
                                  CustomText(
                                    text: "Car Type & Emergency contact",
                                    fontColor: Color(0xffFFFFFF),
                                    fontSize: 16,fontWeight: FontWeight.w500,
                                  ),
                                  Icon(Icons.arrow_forward_ios_rounded,
                                    size: 14,

                                    color: Color(0xffFFFFFF),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h,),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
