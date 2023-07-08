import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_gogo/components/custom_text.dart';

errorAlert(String error) {
  Get.defaultDialog(
    title: '',
    titlePadding: EdgeInsets.zero,
    content: Column(
      children: [
        const Icon(
          Icons.warning_amber,
          size: 40,
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 200,
          child: Text(
            error,
            textAlign: TextAlign.center,
            // style: AppTextStyle.mediumBlack14,
          ),
        ),
      ],
    ),
  );
}



customsnackbar(String title,String message){
  Get.snackbar("", "",
    backgroundColor: Color(0xffDDCA7F),
    borderRadius: 10,
    titleText:CustomText(text:title,
    fontColor: Colors.white,
    ),
    messageText: CustomText(text:message,
      fontColor: Colors.white,
    ),
  );
}
Route createRoute({required Widget page}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(-1.0, 0.0);
      const end = Offset(0.0, 0.0);
      const curve = Curves.easeOut;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        // opacity: animation.drive(tween),
        child: child,
      );
    },
  );
}
