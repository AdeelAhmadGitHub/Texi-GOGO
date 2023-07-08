import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:taxi_gogo/components/custom_card.dart';
import 'package:taxi_gogo/components/custom_text.dart';
import 'package:taxi_gogo/const/app_color.dart';
import 'package:get/get.dart';
import '../../Controllers/CustomDatePickerCard.dart';
import '../../Controllers/EditedProfileController.dart';
import '../../Controllers/wallet_controller.dart';
import '../../components/CustomCardTextFiled.dart';
import '../../components/CustomImageCard.dart';
import '../../components/CustomImageDialog.dart';
import '../../models/GetCitiesModel.dart';

class DVLALicenceInfo extends StatefulWidget {
  const DVLALicenceInfo({Key? key}) : super(key: key);

  @override
  State<DVLALicenceInfo> createState() => _DVLALicenceInfoState();
}

class _DVLALicenceInfoState extends State<DVLALicenceInfo> {
  final contEdit = Get.put(EditedProfileController());
  String lDistrict = '';
  int imageType = 0;

  int dateType = 0;

  @override
  void initState() {
    // TODO: implement initState
    contEdit.dVLACodeCont.text = contEdit.getProfileModel?.value.dvlaEccc ?? "";
    contEdit.setLicenseExpiryDate.value =
        contEdit.getProfileModel?.value.dvlaPdlExpiry ?? "";
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    contEdit.isDVLALicenceInfoEdited.value = true;
    super.dispose();
  }

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
                              width: 50.w,
                            ),
                            CustomText(
                              text: "DVLA & Licence Info",
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
                        child: Container(
                          height: 176.h,
                          width: 335.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xffFFFFFF)),
                          child: Padding(
                            padding: EdgeInsets.only(top: 84.0.h),
                            child: Column(
                              children: [
                                CustomText(
                                  text:
                                      "${contEdit.getProfileModel?.value.firstName} ${contEdit.getProfileModel?.value.lastName}",
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                InkWell(
                                  onTap: () {
                                    cont.isDVLALicenceInfoEdited.value = false;
                                    cont.update();
                                  },
                                  child: Visibility(
                                    visible: cont.isDVLALicenceInfoEdited.value,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/images/edited.png",
                                          height: 19.h,
                                          width: 19.w,
                                          fit: BoxFit.fill,
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        CustomText(
                                          text: "Edit Profile",
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700,
                                          fontColor: Color(0xffCCA300),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
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
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Center(
                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                height: 128.h,
                                width: 128.w,
                                imageUrl:
                                    cont.getProfileModel?.value.profileImage ??
                                        "",
                                errorWidget: (context, url, error) =>
                                    SizedBox(),
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
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: Column(
                    children: [
                      CustomImageCard(
                        text: "DVLA Plastic Driving License (Front)",
                        image: cont.getProfileModel?.value.dvlaPdlfImage ?? "",
                        onTapViewImage: () {
                          showDialog(
                              context: context,
                              builder: (context) => CustomImageDialog(
                                    image: cont.getProfileModel?.value
                                            .dvlaPdlfImage ??
                                        "",
                                    imageFile: cont.dVLALicenseImage?.value,
                                  ));
                        },
                        onTapUploadImage: () {
                          imageType = 0;
                          _showChoiceDialog(context);
                        },
                        newImage: cont.dVLALicenseImage?.value,
                        isUpload: cont.isDVLALicenceInfoEdited.value == true
                            ? false
                            : true,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomDatePickerCard(
                        text: "DVLA Plastic Driving License Expiry",
                        dateText: cont.licenseExpiryDate.value,
                        // onTap: () {
                        //   if (cont.isDVLALicenceInfoEdited.value == true
                        //       ? false
                        //       : true) {
                        //     dateType = 0;
                        //     _selectDate(context);
                        //   }
                        // },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomImageCard(
                        text:
                            "V5C Vehicle Logbook (2nd page)\nor New Keeper Slip",
                        image: cont.getProfileModel?.value.vlbNks ?? "",
                        onTapViewImage: () {
                          showDialog(
                              context: context,
                              builder: (context) => CustomImageDialog(
                                    image: cont.getProfileModel?.value.vlbNks ??
                                        "",
                                    imageFile: cont.v5CImage?.value,
                                  ));
                        },
                        onTapUploadImage: () {
                          imageType = 1;
                          _showChoiceDialog(context);
                        },
                        newImage: cont.v5CImage?.value,
                        isUpload: cont.isDVLALicenceInfoEdited.value == true
                            ? false
                            : true,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomCardTextFiled(
                        text: "DVLA Electronic Counterpart Check\nCode",
                        readOnly: cont.isDVLALicenceInfoEdited.value,
                        controller: cont.dVLACodeCont,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Visibility(
                          visible: cont.isDVLALicenceInfoEdited.value == true
                              ? false
                              : true,
                          child: CustomButton(
                            height: 54.h,
                            width: double.infinity.w,
                            buttonColor: const Color(0xffDDCA7F),
                            child: const Center(
                                child: CustomText(
                              text: "Next",
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            )),
                            onTap: () async {
                              await cont.dVLAAccount();
                            },
                          )),
                      SizedBox(
                        height: 20.h,
                      ),
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

  ///
  ///
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1947),
        lastDate: DateTime.now());
    if (picked != null) {
      contEdit.setLicenseExpiryDate.value =
          DateFormat('dd-MM-yyyy').format(picked);
      contEdit.update();
    }
  }

  _openCamera(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (imageType == 0) {
      contEdit.setDVLALicenseImage = File(pickedFile!.path).obs;
      contEdit.update();
    } else {
      contEdit.setV5CImage = File(pickedFile!.path).obs;
      contEdit.update();
    }
  }

  _openGallery(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageType == 0) {
      contEdit.setDVLALicenseImage = File(pickedFile!.path).obs;
      contEdit.update();
    } else {
      contEdit.setV5CImage = File(pickedFile!.path).obs;
      contEdit.update();
    }
  }

  Future _showChoiceDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Choose option",
            style: TextStyle(color: const Color(0xff000000).withOpacity(.6)),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                ListTile(
                  onTap: () {
                    _openGallery(context);
                    Navigator.pop(context);
                  },
                  title: const Text("Gallery"),
                  leading: const Icon(
                    Icons.account_box,
                    color: Color(0xff8C8FA5),
                  ),
                ),
                ListTile(
                  onTap: () {
                    _openCamera(context);
                    Navigator.pop(context);
                  },
                  title: const Text("Camera"),
                  leading: const Icon(
                    Icons.camera,
                    color: Color(0xff8C8FA5),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
