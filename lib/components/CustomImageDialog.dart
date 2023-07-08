import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomImageDialog extends StatelessWidget {
  String? image;
  File? imageFile;
   CustomImageDialog({Key? key,this.image,this.imageFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 276.h,
      width: 276.w,
      child: Center(
        child:imageFile !=null?Image.file(imageFile!,
        height:276.h ,
          width: 276.w,
          fit: BoxFit.fill,
        ): CachedNetworkImage(
          height:276.h ,
          width: 276.w,
          imageUrl: image??"",
          errorWidget: (context, url, error) => SizedBox(),
        ),

      ),
    );
  }
}
