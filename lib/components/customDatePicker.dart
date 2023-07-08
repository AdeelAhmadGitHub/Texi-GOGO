import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi_gogo/components/custom_text.dart';

class CustomDatePicker extends StatelessWidget {
  String text;
  VoidCallback? onTap;
   CustomDatePicker({Key? key,this.text="SelectDate",this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 54.h,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: const Color(0xffA8ADB1))),
        child: Center(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal:20.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                CustomText(
                  text: text,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontColor: Color(0xffC4C4C4),
                ),
                Image.asset("assets/images/datePicker.png")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
