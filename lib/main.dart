import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import "package:taxi_gogo/dependencies/dependencies.dart" as binds;
import 'package:taxi_gogo/view/positionChanged.dart';
import 'package:taxi_gogo/view/splash/splash_screen.dart';
import 'package:get/get.dart';
import 'Controllers/auth_controller.dart';
import 'Controllers/update_location_controller.dart';
import 'Notification/firebase_messaging.dart';
import 'TimerSet.dart';
import 'imageSize.dart';
import 'navigationScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await binds.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FCM firebaseMessaging = FCM();
  final authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    firebaseMessaging.setNotifications(context);
    firebaseMessaging.streamCtrl.stream.listen((msgData) {
      debugPrint('messageData $msgData');
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: (context, child) => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              // fontFamily: "Montserrat",
              bottomSheetTheme: const BottomSheetThemeData(
                  backgroundColor: Colors.transparent),
              primarySwatch: Colors.blue,
            ),
            home: FutureBuilder(
              future: authController.checkUserLoggedIn(),
              builder: (context, dynamic snapshot) {
                return snapshot.data;
              },
              initialData: const SplashScreen(),
            ),
         //  home:ImageSizeC()
            // home: NavigationScreen(
            //     lat: 29.385958852960034, long:71.75555623569166)

        ));
  }
}
