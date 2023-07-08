// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomOTPTextFiledBox extends StatefulWidget {
  final TextEditingController? textEditingController;
  const CustomOTPTextFiledBox({Key? key,this.textEditingController});

  @override
  State<CustomOTPTextFiledBox> createState() => _CustomOTPTextFiledBoxState();
}

class _CustomOTPTextFiledBoxState extends State<CustomOTPTextFiledBox> {
  bool isShow=false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 45.w,
      decoration: BoxDecoration(
        color:isShow?const Color(0xff000000):Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
            color: Color(0xffE8E6EA)
        )
      ),
      child: TextFormField(
        controller: widget.textEditingController,
        inputFormatters: [LengthLimitingTextInputFormatter(1),
        FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value){
          if(value.length==1){
            setState(() {
              isShow=true;
            });
            FocusScope.of(context).nextFocus();
          }else{
            isShow=false;
          setState(() {
          FocusScope.of(context).previousFocus();

          });
          }
        },
        style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            fontFamily: "Rubik",
            color: const Color(0xffFFFFFF)),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText:"0" ,
          hintStyle:TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              fontFamily: "Rubik",
              color: const Color(0xffE8E6EA)),
          contentPadding: EdgeInsets.only(left: 15.w, bottom: 9.h),
          border: InputBorder.none
        ),
      ),
    );
  }
}
