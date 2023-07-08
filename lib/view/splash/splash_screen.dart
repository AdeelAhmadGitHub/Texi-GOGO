import 'package:flutter/material.dart';
import '../../const/app_color.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBlackColor,
      body: Center(
        child: Image.asset("assets/images/logo.png",
        height: double.infinity,
          width: double.infinity,
        ),
      ),
    );
  }
}
