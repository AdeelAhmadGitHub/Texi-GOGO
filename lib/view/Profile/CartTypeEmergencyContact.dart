import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi_gogo/components/custom_card.dart';
import 'package:taxi_gogo/components/custom_text.dart';
import 'package:taxi_gogo/const/app_color.dart';
import 'package:get/get.dart';
import '../../Controllers/EditedProfileController.dart';
import '../../components/CustomCardTextFiled.dart';
import '../../models/GetCarTypesModel.dart';

class CartTypeEmergencyContact extends StatefulWidget {
  const CartTypeEmergencyContact({Key? key}) : super(key: key);

  @override
  State<CartTypeEmergencyContact> createState() => _CartTypeEmergencyContactState();
}

class _CartTypeEmergencyContactState extends State<CartTypeEmergencyContact> {
  final contEdit = Get.put(EditedProfileController());
  @override
  void initState() {
    // TODO: implement initState
    contEdit.contactNameCont.text = contEdit.getProfileModel?.value.emergencyContactName ?? "";
    contEdit.relationWithYouCont.text = contEdit.getProfileModel?.value.relation ?? "";
    contEdit.contactNumberCont.text = contEdit.getProfileModel?.value.emergencyContactNo ?? "";
    contEdit.contactEmailCont.text = contEdit.getProfileModel?.value.emergencyContactEmail ?? "";
    contEdit.contactAddressCont.text = contEdit.getProfileModel?.value.emergencyContactAddress ?? "";
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    contEdit.isCartTypeEmergencyContactEdited.value=true;
    contEdit.setCarType=null;
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
                              width: 20.w,
                            ),
                            CustomText(
                              text: "Cart Type & Emergency Contact",
                              fontSize: 18.sp,
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
                                    cont.isCartTypeEmergencyContactEdited.value = false;
                                    cont.update();
                                  },
                                  child: Visibility(
                                    visible:cont.isCartTypeEmergencyContactEdited.value,
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
                                    color: Color(0xffE8E6EA),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 10.0.w),
                                  child: cont.isCartTypeEmergencyContactEdited.value
                                      ? SizedBox(
                                    width: double.infinity,
                                    child: Padding(
                                      padding:
                                      EdgeInsets.only(top: 15.0.h,bottom: 15.h),
                                      child: CustomText(
                                        text: cont.carType?.value
                                            .carName??
                                            cont.getProfileModel?.value.carType,
                                      ),
                                    ),
                                  )
                                      : DropdownButtonHideUnderline(
                                    child: DropdownButton<DataCarType>(
                                      itemHeight: 90.h,
                                      isExpanded: true,
                                      value: cont.carType?.value,
                                      hint: const CustomText(
                                          text: "Select"),
                                      items: cont.getCarTypesModel?.value.data?.map((e) {
                                        return DropdownMenuItem<DataCarType>(
                                            value: e,
                                            child: CustomText(
                                              text: e.carName,
                                            ));
                                      }).toList(),
                                      onChanged: (value) {
                                        cont.setCarType = value!.obs;
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
                        text: "Contact Name",
                        readOnly: cont.isCartTypeEmergencyContactEdited.value,
                        controller: cont.contactNameCont,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomCardTextFiled(
                        text: "Relation with you",
                        readOnly: cont.isCartTypeEmergencyContactEdited.value,
                        controller: cont.relationWithYouCont,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomCardTextFiled(
                        text: "Contact Number",
                        readOnly: cont.isCartTypeEmergencyContactEdited.value,
                        controller: cont.contactNumberCont,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomCardTextFiled(
                        text: "Contact Email",
                        readOnly: cont.isCartTypeEmergencyContactEdited.value,
                        controller: cont.contactEmailCont,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomCardTextFiled(
                        text: "Contact Address",
                        readOnly: cont.isCartTypeEmergencyContactEdited.value,
                        controller: cont.contactAddressCont,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Visibility(
                          visible: cont.isCartTypeEmergencyContactEdited.value == true
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
                              await cont.driverCarType();
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

}
