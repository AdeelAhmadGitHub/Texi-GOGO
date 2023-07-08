import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:taxi_gogo/Controllers/RegisterController.dart';
import 'package:taxi_gogo/components/customDatePicker.dart';
import 'package:taxi_gogo/components/custom_text.dart';
import 'package:taxi_gogo/components/custom_text_feild.dart';

import '../../../components/CustomUploadImageContainer.dart';
import '../../../components/custom_card.dart';
import '../../../models/GetCitiesModel.dart';
import '../../../utils/functions.dart';
import '../DVLALicenseDetails/DVLALicenseDetails.dart';

class RegisterAccount extends StatefulWidget {
  const RegisterAccount({Key? key}) : super(key: key);

  @override
  State<RegisterAccount> createState() => _RegisterAccountState();
}

class _RegisterAccountState extends State<RegisterAccount> {
  final registerCont = Get.put(RegisterController());
  int imageType = 0;
  int dateType = 0;
  @override
  void dispose() {
    // TODO: implement dispose
    registerCont.setLicencingDistrict=null;
    registerCont.update();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: RegisterController(),
        builder: (cont) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8.h,
                    ),
                    const CustomText(
                      text: "Create Account",
                      fontColor: Color(0xff36363C),
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
                      child: const CustomText(
                        text: "Enter your details for Register\nyour account",
                        fontSize: 16,
                        textAlign: TextAlign.start,
                        fontColor: Color(0xffAEAEAE),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      child: const CustomText(
                        text: "Profile Picture *",
                        fontSize: 16,
                      ),
                    ),
                    CustomUploadImageContainer(
                      onTap: () {
                        imageType = 0;
                        _showChoiceDialog(context);
                      },
                      image: cont.profileImage?.value,
                      height: 87,
                      width: 87,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
                      child: const CustomText(
                        text: "First Name *",
                        fontSize: 16,
                      ),
                    ),
                    CustomTextFormFiled(
                        controller: cont.firstName, hintText: ''),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
                      child: const CustomText(
                        text: "Last Name *",
                        fontSize: 16,
                      ),
                    ),
                    CustomTextFormFiled(
                        controller: cont.lastName, hintText: ''),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
                      child: const CustomText(
                        text: "Date of Birth *",
                        fontSize: 16,
                      ),
                    ),
                    CustomDatePicker(
                      onTap: () async {
                        dateType = 0;
                        await _selectDate(context);
                      },
                      text: cont.dob.value,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
                      child: const CustomText(
                        text: "Gender *",
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            cont.setSelected = 0.obs;
                            cont.update();
                          },
                          child: Container(
                            height: 13.h,
                            width: 13.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: cont.selected.value == 0
                                        ? Color(0xffDDCA7F)
                                        : Color(0xff000000))),
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        const CustomText(
                          text: "Male",
                          fontSize: 16,
                        ),
                        SizedBox(
                          width: 30.w,
                        ),
                        InkWell(
                          onTap: () {
                            cont.setSelected = 1.obs;
                            cont.update();
                          },
                          child: Container(
                            height: 13.h,
                            width: 13.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: cont.selected.value == 1
                                        ? Color(0xffDDCA7F)
                                        : Color(0xff000000))),
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        const CustomText(
                          text: "Female",
                          fontSize: 16,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
                      child: const CustomText(
                        text: "Phone Number *",
                        fontSize: 16,
                      ),
                    ),
                    CustomTextFormFiled(
                      controller: cont.phoneNumber,
                      hintText: '',
                      textInputType: TextInputType.number,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
                      child: const CustomText(
                        text: "Home Address *",
                        fontSize: 16,
                      ),
                    ),
                    CustomTextFormFiled(
                        controller: cont.homeAddress, hintText: ''),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
                      child: const CustomText(
                        text: "Licencing District *",
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      height: 54.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        border: Border.all(
                          color: Color(0xffA8ADB1),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal:20.0.w),
                          child: DropdownButton<DataCity>(
                            value: cont.licencingDistrict?.value,
                            hint:const CustomText(text: "Select Licencing District"),
                            items: cont.getCitiesModel?.data?.map((e) {
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
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
                      child: Row(
                        children: const [
                          CustomText(
                            text: "Bank Statement *",
                            fontSize: 16,
                          ),
                          CustomText(
                            text: " (Upload Image)",
                            fontSize: 14,
                            fontColor: Color(0xff797B7E),
                          ),
                        ],
                      ),
                    ),
                    CustomUploadImageContainer(
                      onTap: () {
                        imageType = 1;
                        _showChoiceDialog(context);
                      },
                      image: cont.bankStatementImage?.value,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
                      child: Row(
                        children:const [
                           CustomText(
                            text: "National Insurance *",
                            fontSize: 16,
                          ),
                           CustomText(
                            text: " (Upload Image)",
                            fontSize: 14,
                            fontColor: Color(0xff797B7E),
                          ),
                        ],
                      ),
                    ),
                    CustomUploadImageContainer(
                      onTap: () {
                        imageType = 2;
                        _showChoiceDialog(context);
                      },
                      image: cont.nationalInsuranceImage?.value,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                               CustomText(
                                text: "Private Hire Driver License *",
                                fontSize: 16,
                              ),
                               CustomText(
                                text: " (Upload Image)",
                                fontSize: 14,
                                fontColor: Color(0xff797B7E),
                              ),
                            ],
                          ),
                          const CustomText(
                            text: "(Paper & Badge)",
                            fontSize: 16,
                          ),
                        ],
                      ),
                    ),
                    CustomUploadImageContainer(
                      onTap: () {
                        imageType = 3;
                        _showChoiceDialog(context);
                      },
                      image: cont.privateLicenseImage?.value,
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
                    //   child: const CustomText(
                    //     text: "Private Hire Driver License Expiry *",
                    //     fontSize: 16,
                    //   ),
                    // ),
                    // CustomDatePicker(
                    //   onTap: () async {
                    //     dateType = 1;
                    //     await _selectDate(context);
                    //   },
                    //   text: cont.expiryDate.value,
                    // ),
                    SizedBox(
                      height: 30.h,
                    ),
                    CustomButton(
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
                        if (cont.firstName.text.isNotEmpty &&
                            cont.lastName.text.isNotEmpty &&
                            cont.phoneNumber.text.isNotEmpty &&
                            cont.homeAddress.text.isNotEmpty &&
                            cont.profileImage?.value != null &&
                            cont.bankStatementImage?.value != null &&
                            cont.dob.value != "Select Date" &&
                           // cont.expiryDate.value != "Select Date" &&
                            cont.nationalInsuranceImage?.value != null &&
                            cont.licencingDistrict?.value != null &&
                            cont.privateLicenseImage?.value != null) {
                          await cont.registerAccount();
                        } else {
                          customsnackbar("Fill", "Please Fill all the Form");
                        }
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
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
        lastDate: dateType == 1?DateTime(3000):DateTime.now());
    if (picked != null) {
      if (dateType == 1) {
        registerCont.setExpiryDate.value =
            DateFormat('dd-MM-yyyy').format(picked);
        registerCont.update();
      } else {
        registerCont.setDob.value = DateFormat('dd-MM-yyyy').format(picked);
        registerCont.update();
      }
    }
  }

  _openCamera(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (imageType == 0) {
      registerCont.setProfileImage = File(pickedFile!.path).obs;
      registerCont.update();
    } else if (imageType == 1) {
      registerCont.setBankStatementImage = File(pickedFile!.path).obs;
      registerCont.update();
    } else if (imageType == 2) {
      registerCont.setNationalInsuranceImage = File(pickedFile!.path).obs;
      registerCont.update();
    } else {
      registerCont.setPrivateLicenseImage = File(pickedFile!.path).obs;
      registerCont.update();
    }
  }

  _openGallery(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageType == 0) {
      registerCont.setProfileImage = File(pickedFile!.path).obs;
      registerCont.update();
    } else if (imageType == 1) {
      registerCont.setBankStatementImage = File(pickedFile!.path).obs;
      registerCont.update();
    } else if (imageType == 2) {
      registerCont.setNationalInsuranceImage = File(pickedFile!.path).obs;
      registerCont.update();
    } else {
      registerCont.setPrivateLicenseImage = File(pickedFile!.path).obs;
      registerCont.update();
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

  ///
}
