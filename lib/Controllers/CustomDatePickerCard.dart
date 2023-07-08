import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi_gogo/components/custom_text.dart';

class CustomDatePickerCard extends StatelessWidget {
  String text;
  String dateText;
  VoidCallback? onTap;
  CustomDatePickerCard({Key? key,this.text="",this.dateText="",this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
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
             height: 50.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xffE8E6EA),
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal:10.0.w,vertical:15.h),
                  child:CustomText(text:dateText,),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
