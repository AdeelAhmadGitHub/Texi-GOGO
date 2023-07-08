import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi_gogo/components/custom_text.dart';

class CustomImageCard extends StatelessWidget {
  String text;
  String image;
  VoidCallback? onTapUploadImage;
  bool isUpload;
  VoidCallback? onTapViewImage;
  File? newImage;
  CustomImageCard({Key? key,this.text="",this.newImage,this.image="",this.onTapUploadImage,this.onTapViewImage,this.isUpload=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal:15.w,vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text:text,
                  fontSize: 14,
                ),
                Visibility(
                    visible: isUpload,
                    child: InkWell(
                        onTap: onTapUploadImage,
                        child: Image.asset("assets/images/upload.png",
                          height: 23.h,
                          width: 23.w,
                          fit: BoxFit.fill,
                        )))
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
                child:Row(
                  children: [
                    newImage!=null?Image.file(newImage!,
                    height: 25.h,
                        width: 40.w ,
                    ):
                    CachedNetworkImage(
                      height: 25.h,
                      width: 40.w,
                      imageUrl: image,
                      errorWidget: (context, url, error) => SizedBox(),
                    ),
                    SizedBox(width: 13.w,),
                    InkWell(
                      onTap: onTapViewImage,
                      child: const CustomText(text:"Click to view",
                      fontColor: Color(0xff01AED9),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,),
                    ),
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
