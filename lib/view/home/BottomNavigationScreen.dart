import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:taxi_gogo/components/custom_text.dart';

import '../../Controllers/update_location_controller.dart';
import '../AccountScreen/AccountScreen.dart';
import '../QRCodeScreen/QRCodeScreen.dart';
import 'home_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  var updateLocationController = Get.put(UpdateLocationController());

  @override
  void initState() {
    // TODO: implement initState
    updateLocation();
    super.initState();
  }
  updateLocation() async {
    await updateLocationController.getLocation();
  }
 int index=0;
  List<Widget> screens=[
    HomeScreen(),
    AccountScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:InkWell(
        onTap: (){
          Get.to(QRCodeScreen());
        },
        child: CircleAvatar(
          radius: 30.h,
          child: Image.asset("assets/images/qrCode.png"),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar:BottomAppBar(
        notchMargin: 4,
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 66.h,
          width: double.infinity,
          color: const Color(0xff000000),
          child:Center(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal:20.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                InkWell(
                  onTap: (){
                    index=0;
                    setState(() {

                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/home.png",
                        height: 18.h,
                        width: 18.w,
                        fit: BoxFit.fill,
                        color: index==0?Color(0xffDDCA7F):Colors.white,
                      ),
                      SizedBox(height: 2.h,),
                      CustomText(
                        text: "Home",
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        fontColor: index==0?Color(0xffDDCA7F):Colors.white,

                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    index=1;
                    setState(() {

                    });
                    },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Image.asset("assets/images/account.png",
                        height: 18.h,
                        width: 18.w,
                        fit: BoxFit.fill,
                        color: index==1?Color(0xffDDCA7F):Colors.white,
                      ),
                      SizedBox(height: 2.h,),
                      CustomText(
                        text: "Account",
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        fontColor: index==1?Color(0xffDDCA7F):Colors.white,
                      )
                    ],
                  ),
                ),
              ],),
            ),
          ),
        ),
      ) ,
      body: screens[index],
    );
  }
}
