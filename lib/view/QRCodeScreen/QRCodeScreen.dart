import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Controllers/auth_controller.dart';
import '../../components/custom_text.dart';
import '../../const/app_color.dart';

class QRCodeScreen extends StatefulWidget {
  const QRCodeScreen({Key? key}) : super(key: key);

  @override
  State<QRCodeScreen> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kBlackColor,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios)),
        title: CustomText(
          text: "Qr Code",
          fontSize: 20.sp,
          fontColor: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 30.h),
          child: GetBuilder(
            init: AuthController(),
            builder: (cont) {
              return Center(
                child: Column(
                  children: [
                    SizedBox(height: 50.h,),
                    cont.user?.qrCodeImage != null
                        ? Image.network(cont.user?.qrCodeImage ?? "",
                    height:256.h,
                      width:249.w,
                    )
                        : Container(),
                    SizedBox(
                      height: 49.h,
                    ),
                    const CustomText(
                      text: "Please Scan this code to book a ride",
                      fontSize: 16,
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}
