import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../const/app_color.dart';

class SearchTextField extends StatelessWidget {
  final Color? color;
  const SearchTextField({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: color,
          border: Border.all(color: AppColors.kBorderColor),
          borderRadius: BorderRadius.circular(10.r)),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: "search",
          contentPadding: EdgeInsets.only(bottom: 7.h),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          prefixIcon: Icon(
            Icons.search_sharp,
            size: 25.r,
          ),
        ),
      ),
    );
  }
}
