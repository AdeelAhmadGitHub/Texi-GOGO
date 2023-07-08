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
import '../../components/CustomCardTextFiled.dart';
import '../../components/CustomImageCard.dart';
import '../../components/CustomImageDialog.dart';
import '../../models/GetCitiesModel.dart';

class ProfileInformation extends StatefulWidget {
  const ProfileInformation({Key? key}) : super(key: key);

  @override
  State<ProfileInformation> createState() => _ProfileInformationState();
}

class _ProfileInformationState extends State<ProfileInformation> {
  final contEdit = Get.put(EditedProfileController());
  String lDistrict = '';
  int imageType = 0;

  int dateType = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    contEdit.setGender = null;
    contEdit.setLicencingDistrict = null;
    contEdit.isPersonalInformationEdited.value = true;
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    contEdit.firstName.text = contEdit.getProfileModel?.value.firstName ?? "";
    contEdit.lastName.text = contEdit.getProfileModel?.value.lastName ?? "";
    contEdit.setDob.value = contEdit.getProfileModel?.value.dateOfBirth ?? "";
    contEdit.setExpiryDate.value =
        contEdit.getProfileModel?.value.phdlExpiry ?? "";
    contEdit.phoneNumber.text = contEdit.getProfileModel?.value.phone ?? "";
    contEdit.homeAddress.text = contEdit.getProfileModel?.value.address ?? "";
    contEdit.getCitiesModel?.value.data?.forEach((element) {
      if (element.id.toString() == contEdit.getProfileModel?.value.jobCity) {
        lDistrict = element.city ?? '';
      }
    });
    super.initState();
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
                              width: 40.w,
                            ),
                            CustomText(
                              text: "Profile Information",
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
                                    cont.isPersonalInformationEdited.value =
                                        false;
                                    cont.update();
                                  },
                                  child: Visibility(
                                    visible:
                                        cont.isPersonalInformationEdited.value,
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
                                          fontColor: const Color(0xffCCA300),
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
                              child: cont.profileImage?.value != null
                                  ? Image.file(
                                      cont.profileImage!.value,
                                      height: 128.h,
                                      width: 128.w,
                                      fit: BoxFit.fill,
                                    )
                                  : CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      height: 128.h,
                                      width: 128.w,
                                      imageUrl: cont.getProfileModel?.value
                                              .profileImage ??
                                          "",
                                      errorWidget: (context, url, error) =>
                                          const SizedBox(),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: cont.isPersonalInformationEdited.value == true
                          ? false
                          : true,
                      child: Positioned(
                        top: 160.h,
                        left: 225.w,
                        child: InkWell(
                          onTap: () {
                            imageType = 0;
                            _showChoiceDialog(context);
                          },
                          child: CircleAvatar(
                            radius: 15.r,
                            backgroundColor: Colors.black.withOpacity(.3),
                            child: const Center(
                              child: Icon(
                                Icons.camera_alt,
                                color: Color(0xffDDCA7F),
                                size: 17,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: Column(
                    children: [
                      CustomCardTextFiled(
                        text: "First Name",
                        readOnly: cont.isPersonalInformationEdited.value,
                        controller: cont.firstName,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomCardTextFiled(
                        text: "Last Name",
                        readOnly: cont.isPersonalInformationEdited.value,
                        controller: cont.lastName,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomDatePickerCard(
                        text: "Date of Birth",
                        dateText: cont.dob.value,
                        onTap: () {
                          if (cont.isPersonalInformationEdited.value == true
                              ? false
                              : true) {
                            dateType = 0;
                            _selectDate(context);
                          }
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 20.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                text: "Gender",
                                fontSize: 14,
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xffE8E6EA),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.0.w),
                                  child: cont.isPersonalInformationEdited.value
                                      ? SizedBox(
                                          width: double.infinity,
                                          height: 50.h,
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(top: 15.0.h),
                                            child: CustomText(
                                              text: cont.getProfileModel?.value
                                                      .gender ??
                                                  "",
                                            ),
                                          ),
                                        )
                                      : DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            value: cont.gender?.value,
                                            hint: const CustomText(
                                                text: "Select Gender"),
                                            items: cont.genderList.map((e) {
                                              return DropdownMenuItem<String>(
                                                  value: e,
                                                  child: CustomText(
                                                    text: e,
                                                  ));
                                            }).toList(),
                                            onChanged: (value) {
                                              cont.setGender = value!.obs;
                                              cont.update();
                                            },
                                          ),
                                        ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomCardTextFiled(
                        text: "Phone",
                        readOnly: cont.isPersonalInformationEdited.value,
                        controller: cont.phoneNumber,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomCardTextFiled(
                        text: "Address",
                        readOnly: cont.isPersonalInformationEdited.value,
                        controller: cont.homeAddress,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 20.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                text: "Licencing District",
                                fontSize: 14,
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xffE8E6EA),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.0.w),
                                  child: cont.isPersonalInformationEdited.value
                                      ? SizedBox(
                                          width: double.infinity,
                                          height: 50.h,
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(top: 15.0.h),
                                            child: CustomText(
                                              text: cont.licencingDistrict
                                                      ?.value.city ??
                                                  lDistrict,
                                            ),
                                          ),
                                        )
                                      : DropdownButtonHideUnderline(
                                          child: DropdownButton<DataCity>(
                                            isExpanded: true,
                                            value:
                                                cont.licencingDistrict?.value,
                                            hint: const CustomText(
                                                text: "Select"),
                                            items: cont
                                                .getCitiesModel?.value.data
                                                ?.map((e) {
                                              return DropdownMenuItem<DataCity>(
                                                  value: e,
                                                  child: CustomText(
                                                    text: e.city,
                                                  ));
                                            }).toList(),
                                            onChanged: (value) {
                                              cont.setLicencingDistrict =
                                                  value!.obs;
                                              cont.update();
                                            },
                                          ),
                                        ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomImageCard(
                        text: "Bank Statement",
                        image: cont.getProfileModel?.value.bankStatementImage ??
                            "",
                        onTapViewImage: () {
                          showDialog(
                              context: context,
                              builder: (context) => CustomImageDialog(
                                    image: cont.getProfileModel?.value
                                            .bankStatementImage ??
                                        "",
                                    imageFile: cont.bankStatementImage?.value,
                                  ));
                        },
                        onTapUploadImage: () {
                          imageType = 1;
                          _showChoiceDialog(context);
                        },
                        newImage: cont.bankStatementImage?.value,
                        isUpload: cont.isPersonalInformationEdited.value == true
                            ? false
                            : true,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomImageCard(
                        text: "National Insurance",
                        image: cont.getProfileModel?.value
                                .nationalInsuranceImage ??
                            "",
                        onTapViewImage: () {
                          showDialog(
                              context: context,
                              builder: (context) => CustomImageDialog(
                                    image: cont.getProfileModel?.value
                                            .nationalInsuranceImage ??
                                        "",
                                    imageFile:
                                        cont.nationalInsuranceImage?.value,
                                  ));
                        },
                        onTapUploadImage: () {
                          imageType = 2;
                          _showChoiceDialog(context);
                        },
                        newImage: cont.nationalInsuranceImage?.value,
                        isUpload: cont.isPersonalInformationEdited.value == true
                            ? false
                            : true,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomImageCard(
                        text: "Private Hire Driver License",
                        image: cont.getProfileModel?.value.phdlImage ?? "",
                        onTapViewImage: () {
                          showDialog(
                              context: context,
                              builder: (context) => CustomImageDialog(
                                    image:
                                        cont.getProfileModel?.value.phdlImage ??
                                            "",
                                    imageFile: cont.privateLicenseImage?.value,
                                  ));
                        },
                        onTapUploadImage: () {
                          imageType = 3;
                          _showChoiceDialog(context);
                        },
                        newImage: cont.privateLicenseImage?.value,
                        isUpload: cont.isPersonalInformationEdited.value == true
                            ? false
                            : true,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomDatePickerCard(
                        text: "Private Hire Driver License Expiry",
                        dateText: cont.expiryDate.value,
                        // onTap: () {
                        //   if (cont.isPersonalInformationEdited.value == true
                        //       ? false
                        //       : true) {
                        //     dateType = 1;
                        //     _selectDate(context);
                        //   }
                        // },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Visibility(
                          visible:
                              cont.isPersonalInformationEdited.value == true
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
                              await cont.registerAccount();
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
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1947),
        lastDate: DateTime.now());
    if (picked != null) {
      if (dateType == 1) {
        contEdit.setExpiryDate.value = DateFormat('dd-MM-yyyy').format(picked);
        contEdit.update();
      } else {
        contEdit.setDob.value = DateFormat('dd-MM-yyyy').format(picked);
        contEdit.update();
      }
    }
  }

  _openCamera(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (imageType == 0) {
      contEdit.setProfileImage = File(pickedFile!.path).obs;
      contEdit.update();
    } else if (imageType == 1) {
      contEdit.setBankStatementImage = File(pickedFile!.path).obs;
      contEdit.update();
    } else if (imageType == 2) {
      contEdit.setNationalInsuranceImage = File(pickedFile!.path).obs;
      contEdit.update();
    } else {
      contEdit.setPrivateLicenseImage = File(pickedFile!.path).obs;
      contEdit.update();
    }
  }

  _openGallery(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageType == 0) {
      contEdit.setProfileImage = File(pickedFile!.path).obs;
      contEdit.update();
    } else if (imageType == 1) {
      contEdit.setBankStatementImage = File(pickedFile!.path).obs;
      contEdit.update();
    } else if (imageType == 2) {
      contEdit.setNationalInsuranceImage = File(pickedFile!.path).obs;
      contEdit.update();
    } else {
      contEdit.setPrivateLicenseImage = File(pickedFile!.path).obs;
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
