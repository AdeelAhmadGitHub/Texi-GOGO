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
import '../../../utils/functions.dart';
import '../CarType/CarType.dart';

class VehicleLicenseDetails extends StatefulWidget {
  const VehicleLicenseDetails({Key? key}) : super(key: key);

  @override
  State<VehicleLicenseDetails> createState() => _VehicleLicenseDetailsState();
}

class _VehicleLicenseDetailsState extends State<VehicleLicenseDetails> {
  final registerCont = Get.put(RegisterController());
  int imageType = 0;
  int dateType = 0;

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
                    Padding(
                      padding: EdgeInsets.only(top: 8.h, bottom: 5.h),
                      child: const CustomText(
                        text:
                            "Please Enter your\nVehicle Details & Vehicle License Details",
                        fontSize: 16,
                        textAlign: TextAlign.start,
                        fontColor: Color(0xffAEAEAE),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
                      child: const CustomText(
                        text: "Vehicle Make *",
                        fontSize: 16,
                      ),
                    ),
                    CustomTextFormFiled(
                        controller: cont.vehicleMakeCont, hintText: ''),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
                      child: const CustomText(
                        text: "Vehicle Model *",
                        fontSize: 16,
                      ),
                    ),
                    CustomTextFormFiled(
                        controller: cont.vehicleMakeModel, hintText: ''),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
                      child: const CustomText(
                        text: "Vehicle Images *",
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 105.h,
                      width: double.infinity,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: cont.vehicleImages.length + 1,
                          itemBuilder: (context, index) {
                            List<File> images =
                                cont.vehicleImages.reversed.toList();
                            return index > 0
                                ? Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5.0.w),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5.0.w),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          images[index - 1],
                                          height: 105.h,
                                          width: 150.w,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      imageType = 0;
                                      _showChoiceDialog(context);
                                    },
                                    child: SizedBox(
                                      height: 105.h,
                                      width: 150.w,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                            child: Image.asset(
                                          "assets/images/uploadIcon.png",
                                        )),
                                      ),
                                    ),
                                  );
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
                      child: const CustomText(
                        text:
                            "Vehicle Color\n(as written in VC5 Vehicle logbook) *",
                        fontSize: 16,
                      ),
                    ),
                    CustomTextFormFiled(
                        controller: cont.vehicleColor, hintText: ''),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
                      child: const CustomText(
                        text: "Vehicle Reg *",
                        fontSize: 16,
                      ),
                    ),
                    CustomTextFormFiled(
                        controller: cont.vehicleReg, hintText: ''),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
                      child: const CustomText(
                        text: "Vehicle Passenger Capacity *",
                        fontSize: 16,
                      ),
                    ),
                    CustomTextFormFiled(
                      controller: cont.vehiclePassengerCapacity,
                      hintText: '',
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
                      child: const CustomText(
                        text: "Private Hire Vehicle License *",
                        fontSize: 16,
                      ),
                    ),
                    CustomUploadImageContainer(
                      onTap: () {
                        imageType = 1;
                        _showChoiceDialog(context);
                      },
                      image: cont.privateHireVehicleImage?.value,
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
                    //   child: const CustomText(
                    //     text: "Private Hire Vehicle License Expiry *",
                    //     fontSize: 16,
                    //   ),
                    // ),
                    // CustomDatePicker(
                    //   onTap: () async {
                    //     dateType = 0;
                    //     await _selectDate(context);
                    //   },
                    //   text: cont.hireLicenseExpiryDate.value,
                    // ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
                      child: const CustomText(
                        text: "Insurance Certificate *",
                        fontSize: 16,
                      ),
                    ),
                    CustomUploadImageContainer(
                      onTap: () {
                        imageType = 2;
                        _showChoiceDialog(context);
                      },
                      image: cont.insuranceCertificateImage?.value,
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
                    //   child: const CustomText(
                    //     text: "Insurance Certificate Expiry *",
                    //     fontSize: 16,
                    //   ),
                    // ),
                    // CustomDatePicker(
                    //   onTap: () async {
                    //     dateType = 1;
                    //     await _selectDate(context);
                    //   },
                    //   text: cont.insuranceExpiryDate.value,
                    // ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
                      child: const CustomText(
                        text: "MOT Certificate *",
                        fontSize: 16,
                      ),
                    ),
                    CustomUploadImageContainer(
                      onTap: () {
                        imageType = 3;
                        _showChoiceDialog(context);
                      },
                      image: cont.mOTCertificateImage?.value,
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
                    //   child: const CustomText(
                    //     text: "MOT Certificate Expiry *",
                    //     fontSize: 16,
                    //   ),
                    // ),
                    // CustomDatePicker(
                    //   onTap: () async {
                    //     dateType = 2;
                    //     await _selectDate(context);
                    //   },
                    //   text: cont.motoExpiryDate.value,
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
                      onTap: () {
                        if (cont.vehicleMakeCont.text.isNotEmpty &&
                            cont.vehicleMakeModel.text.isNotEmpty &&
                            cont.vehicleColor.text.isNotEmpty &&
                            cont.vehicleReg.text.isNotEmpty &&
                            cont.vehiclePassengerCapacity.text.isNotEmpty &&
                            cont.vehicleImages.isNotEmpty &&
                            cont.privateHireVehicleImage != null &&
                           // cont.hireLicenseExpiryDate.value != "Select Date" &&
                          //  cont.insuranceExpiryDate.value != "Select Date" &&
                           // cont.motoExpiryDate.value != "Select Date" &&
                            cont.insuranceCertificateImage?.value != null &&
                            cont.mOTCertificateImage?.value != null) {
                          cont.vehicleDetails();
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
        lastDate: DateTime(3000));
    if (picked != null) {
      if (dateType == 0) {
        registerCont.setHireLicenseExpiryDate.value =
            DateFormat('dd-MM-yyyy').format(picked);
        registerCont.update();
      } else if (dateType == 1) {
        registerCont.setInsuranceExpiryDate.value =
            DateFormat('dd-MM-yyyy').format(picked);
        registerCont.update();
      } else {
        registerCont.setMotoExpiryDate.value =
            DateFormat('dd-MM-yyyy').format(picked);
        registerCont.update();
      }
    }
  }

  _openCamera(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (imageType == 0) {
      registerCont.setVehicleImages.add(File(pickedFile!.path));
      registerCont.update();
    } else if (imageType == 1) {
      registerCont.setPrivateHireVehicleImage = File(pickedFile!.path).obs;
      registerCont.update();
    } else if (imageType == 2) {
      registerCont.setInsuranceCertificateImage = File(pickedFile!.path).obs;
      registerCont.update();
    } else {
      registerCont.setMOTCertificateImage = File(pickedFile!.path).obs;
      registerCont.update();
    }
  }

  _openGallery(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageType == 0) {
      registerCont.setVehicleImages.add(File(pickedFile!.path));
      registerCont.update();
    } else if (imageType == 1) {
      registerCont.setPrivateHireVehicleImage = File(pickedFile!.path).obs;
      registerCont.update();
    } else if (imageType == 2) {
      registerCont.setInsuranceCertificateImage = File(pickedFile!.path).obs;
      registerCont.update();
    } else {
      registerCont.setMOTCertificateImage = File(pickedFile!.path).obs;
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
