import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:taxi_gogo/components/custom_text.dart';
import 'package:taxi_gogo/components/custom_text_feild.dart';
import '../../../Controllers/RegisterController.dart';
import '../../../components/custom_card.dart';
import '../../../models/GetCarTypesModel.dart';
import '../../../utils/functions.dart';

class CarType extends StatefulWidget {
  const CarType({Key? key}) : super(key: key);

  @override
  State<CarType> createState() => _CarTypeState();
}
class _CarTypeState extends State<CarType> {
  final key = GlobalKey<FormState>();
  final registerCont = Get.put(RegisterController());
  void dispose() {
    // TODO: implement dispose
    registerCont.setCarType=null;
    registerCont.update();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<RegisterController>(
        builder: (cont) {
          return Form(
            key: key,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 8.h, bottom: 5.h),
                        child: const CustomText(
                          text: "Please Enter your\nDriver Car Type",
                          fontSize: 16,
                          textAlign: TextAlign.start,
                          fontColor: Color(0xffAEAEAE),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
                        child: const CustomText(
                          text: "Car Type *",
                          fontSize: 16,
                        ),
                      ),
                      Container(
                        //height: 54.h,
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
                            child: DropdownButton<DataCarType>(
                              value: cont.carType?.value,
                              itemHeight: 90.h,
                              menuMaxHeight: 600.h,
                              hint:const CustomText(text: "Select car type"),
                              items: cont.getCarTypesModel?.data?.map((e) {
                                return DropdownMenuItem<DataCarType>(
                                    value: e,
                                    child: SizedBox(
                                      width: 250.w,
                                      child: CustomText(
                                        text: e.carName,
                                      ),
                                    ));
                              }).toList(),
                              onChanged: (value) {
                                cont.setCarType =
                                    value!.obs;
                                cont.update();
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
                        child: const CustomText(
                          text: "Emergency Contact\nDetails",
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
                        child: const CustomText(
                          text: "Contact Name *",
                          fontSize: 16,
                        ),
                      ),
                      CustomTextFormFiled(
                        controller: cont.contactNameCont,
                        hintText: '',
                        validateText: "Required *",
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
                        child: const CustomText(
                          text: "Relation with you *",
                          fontSize: 16,
                        ),
                      ),
                      CustomTextFormFiled(
                          controller: cont.relationWithYouCont,
                          validateText: "Required *",
                          hintText: ''),
                      Padding(
                        padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
                        child: const CustomText(
                          text: "Contact Number *",
                          fontSize: 16,
                        ),
                      ),
                      CustomTextFormFiled(
                          textInputType: TextInputType.number,
                          controller: cont.contactNumberCont,
                          validateText: "Required *",
                          hintText: ''),
                      Padding(
                        padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
                        child: const CustomText(
                          text: "Contact Email *",
                          fontSize: 16,
                        ),
                      ),
                      CustomTextFormFiled(
                          controller: cont.contactEmailCont,
                          validateText: "Required *",
                          hintText: ''),
                      Padding(
                        padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
                        child: const CustomText(
                          text: "Contact Address *",
                          fontSize: 16,
                        ),
                      ),
                      CustomTextFormFiled(
                        controller: cont.contactAddressCont,
                        validateText: "Required *",
                        hintText: '',
                      ),
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
                          // if(key.currentState!.validate()){
                          //
                          // }
                          if (cont.contactNameCont.text.isNotEmpty &&
                              cont.relationWithYouCont.text.isNotEmpty &&
                              cont.contactNumberCont.text.isNotEmpty &&
                              cont.contactEmailCont.text.isNotEmpty &&
                              cont.contactAddressCont.text.isNotEmpty&&
                          cont.carType?.value !=null
                          ) {
                            cont.driverCarType();
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
            ),
          );
        },
      ),
    );
  }
}
