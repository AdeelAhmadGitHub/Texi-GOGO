import 'package:flutter/material.dart';
import 'dart:io';

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
import '../../../utils/functions.dart';
import '../VehicleLicenseDetails/VehicleLicenseDetails.dart';
class DVLALicenseDetails  extends StatefulWidget {
  const DVLALicenseDetails ({Key? key}) : super(key: key);

  @override
  State<DVLALicenseDetails> createState() => _DVLALicenseDetailsState();
}

class _DVLALicenseDetailsState extends State<DVLALicenseDetails> {
  final registerCont=Get.put(RegisterController());
  int imageType=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:GetBuilder(
        init:RegisterController(),
        builder: (cont) {
          return  SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal:20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8.h, bottom: 5.h),
                      child: const CustomText(
                        text: "Please Enter your\nDVLA & License Details",
                        fontSize: 16,
                        textAlign: TextAlign.start,
                        fontColor:  Color(0xffAEAEAE),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      child: const CustomText(
                        text: "DVLA Plastic Driving License (Front) *",
                        fontSize: 16,
                      ),
                    ),
                    CustomUploadImageContainer(
                      onTap: (){
                        imageType=0;
                        _showChoiceDialog(context);
                      },
                      image: cont.dVLALicenseImage?.value,
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
                    //     await _selectDate(context);
                    //   },
                    //   text: cont.licenseExpiryDate.value,
                    // ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
                      child:    const CustomText(
                        text: "V5C Vehicle Logbook (2nd page)\nor New Keeper Slip *",
                        fontSize: 16,
                      ),
                    ),
                    CustomUploadImageContainer(
                      onTap: (){
                        imageType=1;
                        _showChoiceDialog(context);
                      },
                      image: cont.v5CImage?.value,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
                      child: const CustomText(
                        text: "DVLA Electronic Counterpart Check Code *",
                        fontSize: 16,
                      ),
                    ),
                    CustomTextFormFiled(hintText: "",
                    controller: cont.dVLACodeCont,
                    ),
                    SizedBox(height: 50.h,),
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
                      onTap: () {


                        if (
                        cont.dVLACodeCont.text.isNotEmpty &&
                            cont.v5CImage?.value != null &&
                           // cont.licenseExpiryDate.value != "Select Date" &&
                            cont.dVLALicenseImage?.value != null) {
                          cont.dVLAAccount();
                        } else {
                          customsnackbar("Fill", "Please Fill all the Form");
                        }
                      },

                    ),
                    SizedBox(height: 20.h,),
                  ],
                ),
              ),
            ),
          );
        },),
    );
  }
  ///
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1947),
        lastDate: DateTime(3000));
    if (picked != null) {
      registerCont.setLicenseExpiryDate.value =
          DateFormat('dd-MM-yyyy').format(picked);
      registerCont.update();
    }
  }

  _openCamera(BuildContext context) async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.camera);
    if(imageType==0){
      registerCont.setDVLALicenseImage=File(pickedFile!.path).obs;
      registerCont.update();
    } else{
      registerCont.setV5CImage=File(pickedFile!.path).obs;
      registerCont.update();
    }
  }

  _openGallery(BuildContext context) async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if(imageType==0){
      registerCont.setDVLALicenseImage=File(pickedFile!.path).obs;
      registerCont.update();
    } else{
      registerCont.setV5CImage=File(pickedFile!.path).obs;
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
}
