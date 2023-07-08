import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi_gogo/components/custom_text.dart';

class CustomCardTextFiled extends StatelessWidget {
  TextEditingController? controller;
  TextInputType? textInputType;
  TextAlign textAlign;
  String text;
  bool readOnly;
   CustomCardTextFiled({Key? key,this.controller,this.textInputType,this.textAlign=TextAlign.start,this.text="",this.readOnly=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal:15.w,vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text:text,
              fontSize: 14,
            ),
        SizedBox(height: 8.h,),
        Container(
         // height: 35.h,
          decoration: BoxDecoration(
              color: Color(0xffE8E6EA),
              borderRadius: BorderRadius.circular(5)
          ),
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal:10.0.w),
            child: TextFormField(
              readOnly: readOnly,
              maxLines: 3,
              minLines: 1,
              cursorColor: const Color(0xff000000),
              controller: controller,
              keyboardType: textInputType,
              textAlign: textAlign,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xff000000),
                fontFamily: "Montserrat-Light",
              ),
             decoration: InputDecoration(
              // contentPadding: EdgeInsets.only(bottom: 20.h),
               border: InputBorder.none,
               fillColor: Color(0xffE8E6EA)

             ),
            ),
          ),
        )

          ],
        ),
      ),
    );
  }
}
