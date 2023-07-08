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

class VehicleInfoLicence extends StatefulWidget {
  VehicleInfoLicence({Key? key}) : super(key: key);

  @override
  State<VehicleInfoLicence> createState() => _VehicleInfoLicenceState();
}

class _VehicleInfoLicenceState extends State<VehicleInfoLicence> {
  final contEdit = Get.put(EditedProfileController());
  String lDistrict = '';
  int imageType = 0;

  int dateType = 0;
  @override
  void dispose() {
    // TODO: implement dispose
    contEdit.setGender=null;
    contEdit.setLicencingDistrict=null;
    contEdit.isVehicleInfoLicenceEdited.value=true;
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    contEdit.vehicleMakeCont.text = contEdit.getProfileModel?.value.vehicleName ?? "";
    contEdit.vehicleMakeModel.text = contEdit.getProfileModel?.value.vehicleModel ?? "";
    contEdit.vehicleColor.text = contEdit.getProfileModel?.value.vehicleColor ?? "";
    contEdit.vehicleReg.text = contEdit.getProfileModel?.value.vehicleNumber ?? "";
    contEdit.vehiclePassengerCapacity.text = contEdit.getProfileModel?.value.vehiclePassengerCapacity.toString() ?? "";
    contEdit.hireLicenseExpiryDate.value = contEdit.getProfileModel?.value.phvlExpiry ?? "";
    contEdit.insuranceExpiryDate.value = contEdit.getProfileModel?.value.insuranceCertificateExpiry ?? "";
    contEdit.motoExpiryDate.value = contEdit.getProfileModel?.value.motCertificateExpiry ?? "";
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
                              text: "Vehicle Info & Licence",
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
                                  text: "${contEdit.getProfileModel?.value.firstName} ${contEdit.getProfileModel?.value.lastName}",
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                InkWell(
                                  onTap: () {
                                    cont.isVehicleInfoLicenceEdited.value = false;
                                    cont.update();
                                  },
                                  child: Visibility(
                                    visible: cont.isVehicleInfoLicenceEdited.value,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset("assets/images/edited.png",
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
                      CustomCardTextFiled(
                        text: "Vehicle Make",
                        readOnly: cont.isVehicleInfoLicenceEdited.value,
                        controller: cont.vehicleMakeCont,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomCardTextFiled(
                        text: "Vehicle Model",
                        readOnly: cont.isVehicleInfoLicenceEdited.value,
                        controller: cont.vehicleMakeModel,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Card(
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal:15.w,vertical: 20.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text:"Vehicle Images",
                                    fontSize: 14,
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h,),
                              Container(
                                height: 50.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Color(0xffE8E6EA),
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Padding(
                                  padding:  EdgeInsets.symmetric(horizontal:10.0.w,vertical:15.h),
                                  child:cont.isVehicleInfoLicenceEdited.value!=true?
                                  SizedBox(
                                    height: 25.h,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:cont.vehicleImages.length+1,
                                        itemBuilder: (context,index){
                                          return  index<cont.vehicleImages.length?InkWell(
                                            onTap: (){
                                              showDialog(
                                                  context: context,
                                                  builder: (context) => CustomImageDialog(
                                                    image: null,
                                                    imageFile: cont.vehicleImages[index],
                                                  ));
                                            },
                                            child: Image.file(cont.vehicleImages[index],
                                              height: 25.h,
                                              width: 40.w ,
                                            ),
                                          ):InkWell(
                                            onTap: (){
                                              imageType=0;
                                              _showChoiceDialog(context);
                                            },
                                            child: Container(
                                              height: 25.h,
                                              width: 40.w ,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(3),
                                                color: Colors.white,
                                              ),
                                              child:Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: Image.asset("assets/images/upload.png",
                                                ),
                                              ) ,
                                            ),
                                          );
                                        }),
                                  )
                                      : SizedBox(
                                    height: 25.h,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:cont.getProfileModel?.value.vehicleImages?.length,
                                        itemBuilder: (context,index){
                                          print("${cont.getProfileModel?.value.vehicleImages?[index]}");
                                          return InkWell(
                                            onTap: (){
                                              showDialog(
                                                  context: context,
                                                  builder: (context) => CustomImageDialog(
                                                    image: "${cont.getProfileModel?.value.vehicleImages?[index]}",
                                                    imageFile: null,
                                                  ));
                                            },
                                            child: CachedNetworkImage(
                                              height: 25.h,
                                              width: 40.w,
                                              imageUrl: cont.getProfileModel?.value.vehicleImages?[index]??"",
                                              errorWidget: (context, url, error) => SizedBox(),
                                            ),
                                          );
                                        }),
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
                        text: "Vehicle Color\n(as written in VC5 Vehicle logbook)",
                        readOnly: cont.isVehicleInfoLicenceEdited.value,
                        controller: cont.vehicleColor,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomCardTextFiled(
                        text: "Vehicle Reg",
                        readOnly: cont.isVehicleInfoLicenceEdited.value,
                        controller: cont.vehicleReg,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomCardTextFiled(
                        text: "Vehicle Passenger Capacity",
                        readOnly: cont.isVehicleInfoLicenceEdited.value,
                        controller: cont.vehiclePassengerCapacity,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomImageCard(
                        text: "Private Hire Vehicle License",
                        image: cont.getProfileModel?.value.phvlImage??
                            "",
                        onTapViewImage: () {
                          showDialog(
                              context: context,
                              builder: (context) => CustomImageDialog(
                                image: cont.getProfileModel?.value
                                    .phvlImage ??
                                    "",
                                imageFile: cont.privateHireVehicleImage?.value,
                              ));
                        },
                        onTapUploadImage: () {
                          imageType = 1;
                          _showChoiceDialog(context);
                        },
                        newImage: cont.privateHireVehicleImage?.value,
                        isUpload: cont.isVehicleInfoLicenceEdited.value == true
                            ? false
                            : true,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomDatePickerCard(
                        text: "Private Hire Vehicle License Expiry",
                        dateText: cont.hireLicenseExpiryDate.value,
                        // onTap: () {
                        //   if(cont.isVehicleInfoLicenceEdited.value==true?false:true) {
                        //     dateType = 0;
                        //     _selectDate(context);
                        //   }
                        // },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomImageCard(
                        text: "Insurance Certificate",
                        image: cont.getProfileModel?.value.insuranceCertificateImage??
                            "",
                        onTapViewImage: () {
                          showDialog(
                              context: context,
                              builder: (context) => CustomImageDialog(
                                image: cont.getProfileModel?.value
                                    .insuranceCertificateImage ??
                                    "",
                                imageFile: cont.insuranceCertificateImage?.value,
                              ));
                        },
                        onTapUploadImage: () {
                          imageType = 2;
                          _showChoiceDialog(context);
                        },
                        newImage: cont.insuranceCertificateImage?.value,
                        isUpload: cont.isVehicleInfoLicenceEdited.value == true
                            ? false
                            : true,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomDatePickerCard(
                        text: "Insurance Certificate Expiry",
                        dateText: cont.insuranceExpiryDate.value,
                        // onTap: () {
                        //   if(cont.isVehicleInfoLicenceEdited.value==true?false:true) {
                        //     dateType = 1;
                        //     _selectDate(context);
                        //   }
                        // },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomImageCard(
                        text: "MOT Certificate",
                        image: cont.getProfileModel?.value.motCertificateImage??
                            "",
                        onTapViewImage: () {
                          showDialog(
                              context: context,
                              builder: (context) => CustomImageDialog(
                                image: cont.getProfileModel?.value
                                    .motCertificateImage ??
                                    "",
                                imageFile: cont.mOTCertificateImage?.value,
                              ));
                        },
                        onTapUploadImage: () {
                          imageType = 3;
                          _showChoiceDialog(context);
                        },
                        newImage: cont.mOTCertificateImage?.value,
                        isUpload: cont.isVehicleInfoLicenceEdited.value == true
                            ? false
                            : true,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomDatePickerCard(
                        text: "MOT Certificate Expiry",
                        dateText: cont.motoExpiryDate.value,
                        // onTap: () {
                        //   if(cont.isVehicleInfoLicenceEdited.value==true?false:true) {
                        //     dateType = 2;
                        //     _selectDate(context);
                        //   }
                        // },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Visibility(
                          visible:
                          cont.isVehicleInfoLicenceEdited.value == true
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
                              await cont.vehicleDetails();
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
      if (dateType == 0) {
        contEdit.setHireLicenseExpiryDate.value =
            DateFormat('dd-MM-yyyy').format(picked);
        contEdit.update();
      } else if (dateType == 1) {
        contEdit.setInsuranceExpiryDate.value =
            DateFormat('dd-MM-yyyy').format(picked);
        contEdit.update();
      } else {
        contEdit.setMotoExpiryDate.value =
            DateFormat('dd-MM-yyyy').format(picked);
        contEdit.update();
      }
    }
  }

  _openCamera(BuildContext context) async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.camera);
    if (imageType == 0) {
      contEdit.setVehicleImages.add(File(pickedFile!.path));
      contEdit.update();
    } else if (imageType == 1) {
      contEdit.setPrivateHireVehicleImage = File(pickedFile!.path).obs;
      contEdit.update();
    } else if (imageType == 2) {
      contEdit.setInsuranceCertificateImage = File(pickedFile!.path).obs;
      contEdit.update();
    } else {
      contEdit.setMOTCertificateImage = File(pickedFile!.path).obs;
      contEdit.update();
    }
  }

  _openGallery(BuildContext context) async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageType == 0) {
      contEdit.setVehicleImages.add(File(pickedFile!.path));
      contEdit.update();
    } else if (imageType == 1) {
      contEdit.setPrivateHireVehicleImage = File(pickedFile!.path).obs;
      contEdit.update();
    } else if (imageType == 2) {
      contEdit.setInsuranceCertificateImage = File(pickedFile!.path).obs;
      contEdit.update();
    } else {
      contEdit.setMOTCertificateImage = File(pickedFile!.path).obs;
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
