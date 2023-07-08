import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get.dart';
import 'package:taxi_gogo/Controllers/auth_controller.dart';
import 'package:taxi_gogo/components/custom_text.dart';
import 'package:taxi_gogo/const/app_color.dart';
import 'package:taxi_gogo/models/RideRequestModel.dart';
import 'package:taxi_gogo/view/ChangePassword/ChangePassword.dart';
import '../../Controllers/home_controller.dart';
import '../../Controllers/wallet_controller.dart';
import '../../api/api_client.dart';
import '../../components/custom_card.dart';
import 'package:http/http.dart' as http;

import '../../models/DataModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var auth = Get.put(AuthController());
  var controller = Get.put(HomeController());
  var walletCont = Get.put(WalletController());
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  ScrollController scrollControllerRunning = ScrollController();

  @override
  initState() {
    super.initState();

    if (auth.isLogin) {
      controller.getRideRequest();
      controller.getRunningRides();
      controller.getUpcomingRides();
      controller.getQrCodeRides();
      auth.isLogin = false;
    }
    if (controller.runningList.length > 15) {
      controller.noMoreRunning = false.obs;
    }
    if (controller.upcomingList.length > 15) {
      controller.noMoreUpcoming = false.obs;
    }
    if (controller.qrCodeList.length > 15) {
      controller.noMoreQrCode = false.obs;
    }
    if (controller.rideList.length > 15) {
      controller.noMoreRide = false.obs;
    }
    scrollControllerRunning.addListener(() {
      if (scrollControllerRunning.position.maxScrollExtent ==
          scrollControllerRunning.offset) {
        controller.selectedIndex.value == 0
            ? fetchMoreDataRide()
            : controller.selectedIndex.value == 1
                ? fetchMoreDataRunning()
                : controller.selectedIndex.value == 2
                    ? fetchMoreDataUpcoming()
                    : fetchMoreDataQrCode();
      }
    });
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   controller.isAccepted = false;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldState,
        drawer: Drawer(
          width: 250.w,
          child: Column(
            children: [
              Container(
                height: 206.h,
                width: MediaQuery.of(context).size.width,
                color: AppColors.kBlackColor,
                child: Center(
                  child: CustomText(
                    text: "${auth.user?.firstName} ${auth.user?.lastName}",
                    fontColor: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20.sp,
                  ),
                  // child: Image.asset(
                  //   "",
                  //   height: 88.h,
                  //   width: 167.w,
                  // ),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              ListTile(
                onTap: () async {
                  walletCont.currentType = 0;
                  walletCont.pagination = false;
                  walletCont.paymentType = "payment_link";
                  walletCont.isNavigate = true;
                  walletCont.weeklyEarningReport();
                },
                leading: Image.asset(
                  "assets/images/payment.png",
                  height: 20.h,
                  width: 20.w,
                  color: const Color(0xffDDCA7F),
                ),
                title: const CustomText(
                  text: "Payment History",
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  fontColor: Color(0xff000000),
                ),
                dense: true,
                visualDensity:
                    const VisualDensity(horizontal: -4, vertical: -1),
              ),
              ListTile(
                onTap: () async {
                  Get.to(const ChangePassword());
                },
                leading: Image.asset(
                  "assets/images/ChangePassword.png",
                  height: 20.h,
                  width: 20.w,
                  color: const Color(0xffDDCA7F),
                ),
                title: const CustomText(
                  text: "Change Password",
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  fontColor: Color(0xff000000),
                ),
                dense: true,
                visualDensity:
                    const VisualDensity(horizontal: -4, vertical: -1),
              ),
              ListTile(
                onTap: () async {
                  await Get.find<AuthController>().logout();
                },
                leading: Image.asset(
                  "assets/images/LogOutIcon.png",
                  height: 20.h,
                  width: 20.w,
                  color: const Color(0xffDDCA7F),
                ),
                title: const CustomText(
                  text: "Logout",
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  fontColor: Color(0xff000000),
                ),
                dense: true,
                visualDensity:
                    const VisualDensity(horizontal: -4, vertical: -1),
              )
            ],
          ),
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              controller.pageUpcoming = 1;
              controller.pageQrCode = 1;
              controller.pageRunning = 1;
              controller.pageRide = 1;
              controller.selectedIndex.value == 0
                  ? controller.isRefreshRide = true
                  : controller.selectedIndex.value == 1
                      ? controller.isRefreshRunning = true
                      : controller.selectedIndex.value == 2
                          ? controller.isRefreshUpcoming = true
                          : controller.isRefreshQrCode = true;
              controller.selectedIndex.value == 0
                  ? controller.getRideRequest()
                  : controller.selectedIndex.value == 1
                      ? controller.getRunningRides()
                      : controller.selectedIndex.value == 2
                          ? controller.getUpcomingRides()
                          : controller.getQrCodeRides();
            },
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(height: 25.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomCard(
                            height: 40.h,
                            width: 40.w,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: Colors.black12),
                            cardChild: Builder(builder: (context) {
                              return IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () =>
                                    Scaffold.of(context).openDrawer(),
                                icon: Icon(
                                  Icons.format_list_bulleted_sharp,
                                  size: 22.r,
                                ),
                              );
                            }),
                          ),
                          CustomCard(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(100.r),
                            cardChild: Obx(
                              () => FlutterToggleTab(
                                width: 50.w,
                                height: 40.h,
                                selectedIndex:
                                    controller.tabTextIndexSelected.value??1,
                                selectedBackgroundColors: const [
                                  AppColors.kPrimaryColor,
                                  AppColors.kPrimaryColor,
                                ],
                                selectedTextStyle:
                                    const TextStyle(color: Colors.white),
                                unSelectedBackgroundColors: const [
                                  Colors.white
                                ],
                                unSelectedTextStyle:
                                    const TextStyle(color: Colors.black),
                                labels: controller.listTextTabToggle,
                                selectedLabelIndex: (index) {
                                  controller.toggle(index);
                                  controller.updateOnlineStatus(index);
                                },
                                isScroll: false,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.notifications,
                            size: 30.r,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
                SizedBox(
                  height: 70.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    itemCount: controller.ridesList.length,
                    itemBuilder: (context, index) {
                      return Obx(
                        () => Row(
                          children: [
                            SizedBox(width: 15.w),
                            InkWell(
                              onTap: () {
                                controller.selectedIndex.value = index;
                              },
                              child: CustomCard(
                                height: 36.h,
                                width: 134.w,
                                borderRadius: BorderRadius.circular(10.r),
                                border:
                                    Border.all(color: AppColors.kBorderColor),
                                cardColor:
                                    controller.selectedIndex.value == index
                                        ? AppColors.kPrimaryColor
                                        : Colors.white,
                                cardChild: Center(
                                  child: CustomText(
                                    text: controller.ridesList[index],
                                    fontSize: 12.sp,
                                    fontColor:
                                        controller.selectedIndex.value == index
                                            ? Colors.white
                                            : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            // SizedBox(width: 5.w),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // SliverToBoxAdapter(
                //   key: UniqueKey(),
                //   child: Column(
                //     children: [
                //       SizedBox(height: 25.h),
                //       Padding(
                //         padding: EdgeInsets.symmetric(horizontal: 20.w),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             CustomCard(
                //               height: 40.h,
                //               width: 40.w,
                //               borderRadius: BorderRadius.circular(10.r),
                //               border: Border.all(color: Colors.black12),
                //               cardChild: Builder(builder: (context) {
                //                 return IconButton(
                //                   padding: EdgeInsets.zero,
                //                   onPressed: () =>
                //                       Scaffold.of(context).openDrawer(),
                //                   icon: Icon(
                //                     Icons.format_list_bulleted_sharp,
                //                     size: 22.r,
                //                   ),
                //                 );
                //               }),
                //             ),
                //             CustomCard(
                //               border: Border.all(color: Colors.black),
                //               borderRadius: BorderRadius.circular(100.r),
                //               cardChild: Obx(
                //                 () => FlutterToggleTab(
                //                   width: 50.w,
                //                   height: 40.h,
                //                   selectedIndex:
                //                       controller.tabTextIndexSelected.value,
                //                   selectedBackgroundColors: const [
                //                     AppColors.kPrimaryColor,
                //                     AppColors.kPrimaryColor,
                //                   ],
                //                   selectedTextStyle:
                //                       const TextStyle(color: Colors.white),
                //                   unSelectedBackgroundColors: const [
                //                     Colors.white
                //                   ],
                //                   unSelectedTextStyle:
                //                       const TextStyle(color: Colors.black),
                //                   labels: controller.listTextTabToggle,
                //                   selectedLabelIndex: (index) {
                //                     controller.toggle(index);
                //                     controller.updateOnlineStatus(index);
                //                   },
                //                   isScroll: false,
                //                 ),
                //               ),
                //             ),
                //             Icon(
                //               Icons.notifications,
                //               size: 30.r,
                //             )
                //           ],
                //         ),
                //       ),
                //       SizedBox(height: 10.h),
                //     ],
                //   ),
                // ),
                // SliverAppBar(
                //   backgroundColor: Colors.white,
                //   automaticallyImplyLeading: false,
                //   pinned: true,
                //   titleSpacing: 0,
                //   title: SizedBox(
                //     height: 70.h,
                //     child: ListView.builder(
                //       scrollDirection: Axis.horizontal,
                //       physics: const BouncingScrollPhysics(
                //           parent: AlwaysScrollableScrollPhysics()),
                //       itemCount: controller.ridesList.length,
                //       itemBuilder: (context, index) {
                //         return Obx(
                //           () => Row(
                //             children: [
                //               SizedBox(width: 15.w),
                //               InkWell(
                //                 onTap: () {
                //                   controller.selectedIndex.value = index;
                //                 },
                //                 child: CustomCard(
                //                   height: 36.h,
                //                   width: 134.w,
                //                   borderRadius: BorderRadius.circular(10.r),
                //                   border:
                //                       Border.all(color: AppColors.kBorderColor),
                //                   cardColor:
                //                       controller.selectedIndex.value == index
                //                           ? AppColors.kPrimaryColor
                //                           : Colors.white,
                //                   cardChild: Center(
                //                     child: CustomText(
                //                       text: controller.ridesList[index],
                //                       fontSize: 12.sp,
                //                       fontColor:
                //                           controller.selectedIndex.value ==
                //                                   index
                //                               ? Colors.white
                //                               : Colors.black,
                //                       fontWeight: FontWeight.bold,
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //               // SizedBox(width: 5.w),
                //             ],
                //           ),
                //         );
                //       },
                //     ),
                //   ),
                // ),
                Obx(
                  () => Expanded(
                    child: controller.selectedIndex.value == 0
                        ? rideRequest()
                        : controller.selectedIndex.value == 1
                            ? runningRides()
                            : controller.selectedIndex.value == 2
                                ? upcomingRides()
                                : qrCodeRides(),
                  ),
                ),
                // Obx(
                //   () => SliverToBoxAdapter(
                //     key: UniqueKey(),
                //     child: controller.selectedIndex.value == 0
                //         ? rideRequest()
                //         : controller.selectedIndex.value == 1
                //             ? runningRides()
                //             : upcomingRides(),
                //   ),
                // ),
              ],
            ),
          ),
        ));
  }

  Stream<http.StreamedResponse> getRandomNumberFact() async* {
    yield* Stream.periodic(const Duration(seconds: 10), (_) async {
      print(">>>>>>>>>>>Muzamil<<<<<<<<<<<<<<<<<<<<<<");
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${auth.user?.accessToken}'
      };
      var request =
          http.Request('POST', Uri.parse('${baseUrl}api/rideRequest'));

      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      print(response.statusCode);
      print(">>>>>>>>>>>Muzamil<<<<<<<<<<<<<<<<<<<<<<");
      if (response.statusCode == 200) {
        final data = await response.stream.bytesToString();
        print(  jsonDecode(data));
        controller.rideList=<Data>[].obs;
        controller.setRideRequestModel=RideRequestModel.fromJson(jsonDecode(data));
        jsonDecode(data)['data']['data'].forEach((v) {
          controller.rideList.add(Data.fromJson(v));
        });
        controller.update();
      }
      return response;
    }).asyncMap((event) async {
      return event;
    });
  }

  rideRequest() {
    return GetBuilder<HomeController>(builder: (cont) {
      return StreamBuilder<http.StreamedResponse>(
          stream: getRandomNumberFact(),
          builder: (context, snapshot) {
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20),
                child: cont.rideList.isEmpty
                    ? ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 200.h,
                            ),
                            const Center(
                              child: CustomText(
                                text: "No Rides",
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        controller: scrollControllerRunning,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: cont.rideList.length + 1,
                        itemBuilder: (context, index) {
                          if (index >= cont.rideList.length) {
                            return Center(
                                child: cont.noMoreRide.value
                                    ? CustomText(
                                        text: 'No More Item',
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                            width: 20.w,
                                            height: 20.h,
                                            child:
                                                const CircularProgressIndicator()),
                                      ));
                          }
                          final rideData = cont.rideList[index];
                          return Column(
                            children: [
                              InkWell(
                                  onTap: () {
                                    if(rideData.isNavigate??true) {
                                      time=rideData.remainingSeconds;
                                      cont.screenType = 0;
                                      cont.rideId = rideData.id ?? 1;
                                      cont.getRideDetails();
                                    }
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    elevation: 15,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w, vertical: 10.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  CustomText(
                                                    text: "Pickup Time: ",
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w500,
                                                    fontColor:
                                                        const Color(0xff10C600),
                                                  ),
                                                  CustomText(
                                                    text: rideData.pickupTime ??
                                                        "",
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w600,
                                                    fontColor:
                                                        const Color(0xff303030),
                                                  ),
                                                ],
                                              ),
                                              Icon(
                                                Icons.more_horiz,
                                                size: 40.r,
                                                color: AppColors.kPrimaryColor,
                                              )
                                            ],
                                          ),
                                          // Row(
                                          //   children: [
                                          //     CustomText(
                                          //       text: "Pickup Date: ",
                                          //       fontSize: 16.sp,
                                          //       fontWeight: FontWeight.w500,
                                          //       fontColor:
                                          //           const Color(0xff2E8FF7),
                                          //     ),
                                          //     CustomText(
                                          //       text: "${rideData.pickupDate}",
                                          //       fontSize: 16.sp,
                                          //       fontWeight: FontWeight.w600,
                                          //       fontColor: const Color(0xff303030),
                                          //     ),
                                          //   ],
                                          // ),
                                          Divider(
                                              height: 10.h,
                                              color: Colors.black),
                                          SizedBox(height: 10.h),
                                          IntrinsicHeight(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 4.0.w),
                                                          child: Icon(
                                                            Icons.location_on,
                                                            size: 20.r,
                                                            color: AppColors
                                                                .kGreenColor,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 1.h,
                                                        ),
                                                        Column(
                                                          children:
                                                              List.generate(
                                                            (((rideData.pickupAddress?.length ??
                                                                            0) ~/
                                                                        25) *
                                                                    2) +
                                                                5,
                                                            (i) => Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: 8.w,
                                                                  right: 12.w,
                                                                  top: 4.h,
                                                                ),
                                                                child:
                                                                    Container(
                                                                  height: 5.h,
                                                                  width: 2.w,
                                                                  color: Colors
                                                                      .grey,
                                                                )),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5.h,
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        SizedBox(
                                                          width: 250.w,
                                                          child: CustomText(
                                                            text: rideData
                                                                    .pickupAddress ??
                                                                "N/A",
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 2.h,
                                                        ),
                                                        SizedBox(
                                                          width: 250.w,
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              CustomText(
                                                                text:
                                                                    "Pickup Distance: ",
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontColor:
                                                                    const Color(
                                                                        0xff2E8FF7),
                                                              ),
                                                              SizedBox(
                                                                width: 138.w,
                                                                child:
                                                                    CustomText(
                                                                  text:
                                                                      "${rideData.driverPickupDistance ?? 0} miles away",
                                                                  fontSize:
                                                                      14.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 4.0.w),
                                                      child: Icon(
                                                        Icons.location_on,
                                                        size: 20.r,
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                      ),
                                                    ),
                                                    Column(
                                                      children: [
                                                        SizedBox(
                                                          width: 250.w,
                                                          child: CustomText(
                                                              text: rideData
                                                                      .destinationAddress ??
                                                                  "N/A",
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        SizedBox(
                                                          width: 250.w,
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              CustomText(
                                                                text:
                                                                    "Drop Off Distance: ",
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontColor:
                                                                    const Color(
                                                                        0xff2E8FF7),
                                                              ),
                                                              SizedBox(
                                                                width: 130.w,
                                                                child:
                                                                    CustomText(
                                                                  text:
                                                                      "${rideData.calculativeDistance ?? "0"} miles away",
                                                                  fontSize:
                                                                      14.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 10.h),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 22.0.w),
                                            child: Visibility(
                                              visible: rideData.destinationVia!
                                                      .isNotEmpty
                                                  ? true
                                                  : false,
                                              child: CustomText(
                                                text: "Multi destination trip",
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                                fontColor:
                                                    const Color(0xff49965E),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10.h),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomText(
                                                text:
                                                    "GBP:  ${rideData.bookingPrice}",
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                                fontColor: AppColors.kRedColor,
                                              ),
                                              TimerCountdown(
                                                enableDescriptions: false,
                                                format: CountDownTimerFormat
                                                    .secondsOnly,
                                                endTime: DateTime.now().add(
                                                  Duration(
                                                    seconds: rideData
                                                            .remainingSeconds ??
                                                        60,
                                                  ),
                                                ),
                                                onEnd: () {
                                                  rideData.isNavigate=false;
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                              SizedBox(height: 20.h),
                            ],
                          );
                        }));
          });
    });
  }

  runningRides() {
    return GetBuilder<HomeController>(builder: (cont) {
      return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20),
          child: cont.runningList.isEmpty
              ? ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 200.h,
                      ),
                      const Center(
                        child: CustomText(
                          text: "No Rides",
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  controller: scrollControllerRunning,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: cont.runningList.length + 1,
                  itemBuilder: (context, index) {
                    if (index >= cont.runningList.length) {
                      return Center(
                          child: cont.noMoreRunning.value
                              ? CustomText(
                                  text: 'No More Item',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      width: 20.w,
                                      height: 20.h,
                                      child: const CircularProgressIndicator()),
                                ));
                    }
                    final rideData = cont.runningList[index];
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            cont.screenType = 1;
                            cont.rideId = rideData.id ?? 1;
                            cont.getRideDetails();
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 15,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 10.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CustomText(
                                            text: "Pickup Time: ",
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                            fontColor: const Color(0xff10C600),
                                          ),
                                          CustomText(
                                            text: rideData.pickupTime ?? "",
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                            fontColor: const Color(0xff303030),
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        Icons.more_horiz,
                                        size: 40.r,
                                        color: AppColors.kPrimaryColor,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      CustomText(
                                        text: "Pickup Date: ",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        fontColor: const Color(0xff2E8FF7),
                                      ),
                                      CustomText(
                                        text: "${rideData.pickupDate}",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        fontColor: const Color(0xff303030),
                                      ),
                                    ],
                                  ),
                                  Divider(height: 10.h, color: Colors.black),
                                  SizedBox(height: 10.h),
                                  IntrinsicHeight(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 4.0.w),
                                                  child: Icon(
                                                    Icons.location_on,
                                                    size: 20.r,
                                                    color:
                                                        AppColors.kGreenColor,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Column(
                                                  children: List.generate(
                                                    (((rideData.pickupAddress
                                                                        ?.length ??
                                                                    0) ~/
                                                                25) *
                                                            2) +
                                                        5,
                                                    (i) => Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: 8.w,
                                                          right: 12.w,
                                                          top: 4.h,
                                                        ),
                                                        child: Container(
                                                          height: 5.h,
                                                          width: 2.w,
                                                          color: Colors.grey,
                                                        )),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                SizedBox(
                                                  width: 250.w,
                                                  child: CustomText(
                                                    text: rideData
                                                            .pickupAddress ??
                                                        "N/A",
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                SizedBox(
                                                  width: 250.w,
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      CustomText(
                                                        text:
                                                            "Pickup Distance: ",
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontColor: const Color(
                                                            0xff2E8FF7),
                                                      ),
                                                      SizedBox(
                                                        width: 138.w,
                                                        child: CustomText(
                                                          text:
                                                              "${rideData.driverPickupDistance ?? 0} miles away",
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 4.0.w),
                                              child: Icon(
                                                Icons.location_on,
                                                size: 20.r,
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                SizedBox(
                                                  width: 250.w,
                                                  child: CustomText(
                                                      text: rideData
                                                              .destinationAddress ??
                                                          "N/A",
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  width: 250.w,
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      CustomText(
                                                        text:
                                                            "Drop Off Distance: ",
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontColor: const Color(
                                                            0xff2E8FF7),
                                                      ),
                                                      SizedBox(
                                                        width: 130.w,
                                                        child: CustomText(
                                                          text:
                                                              "${rideData.calculativeDistance ?? "0"} miles away",
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Padding(
                                    padding: EdgeInsets.only(left: 22.0.w),
                                    child: Visibility(
                                      visible:
                                          rideData.destinationVia!.isNotEmpty
                                              ? true
                                              : false,
                                      child: CustomText(
                                        text: "Multi destination trip",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        fontColor: const Color(0xff49965E),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        text: "GBP:  ${rideData.bookingPrice}",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        fontColor: AppColors.kRedColor,
                                      ),
                                      CustomText(
                                        text:"${rideData.rideStatus}",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        fontColor: const Color(0xff49965E),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    );
                  }));
    });
  }

  upcomingRides() {
    return GetBuilder<HomeController>(builder: (cont) {
      return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20),
          child: cont.upcomingList.isEmpty
              ? ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 200.h,
                      ),
                      const Center(
                        child: CustomText(
                          text: "No Rides",
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  controller: scrollControllerRunning,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: cont.upcomingList.length + 1,
                  itemBuilder: (context, index) {
                    if (index >= cont.upcomingList.length) {
                      return Center(
                          child: cont.noMoreUpcoming.value
                              ? CustomText(
                                  text: 'No More Item',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      width: 20.w,
                                      height: 20.h,
                                      child: const CircularProgressIndicator()),
                                ));
                    }
                    final rideData = cont.upcomingList[index];
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            cont.screenType = 2;
                            cont.rideId = rideData.id ?? 1;
                            cont.getRideDetails();
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 15,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 10.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CustomText(
                                            text: "Pickup Time: ",
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                            fontColor: const Color(0xff10C600),
                                          ),
                                          CustomText(
                                            text: rideData.pickupTime ?? "",
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                            fontColor: const Color(0xff303030),
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        Icons.more_horiz,
                                        size: 40.r,
                                        color: AppColors.kPrimaryColor,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      CustomText(
                                        text: "Pickup Date: ",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        fontColor: const Color(0xff2E8FF7),
                                      ),
                                      CustomText(
                                        text: "${rideData.pickupDate}",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        fontColor: const Color(0xff303030),
                                      ),
                                    ],
                                  ),
                                  Divider(height: 10.h, color: Colors.black),
                                  SizedBox(height: 10.h),
                                  IntrinsicHeight(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 4.0.w),
                                                  child: Icon(
                                                    Icons.location_on,
                                                    size: 20.r,
                                                    color:
                                                        AppColors.kGreenColor,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Column(
                                                  children: List.generate(
                                                    (((rideData.pickupAddress
                                                                        ?.length ??
                                                                    0) ~/
                                                                25) *
                                                            2) +
                                                        5,
                                                    (i) => Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: 8.w,
                                                          right: 12.w,
                                                          top: 4.h,
                                                        ),
                                                        child: Container(
                                                          height: 5.h,
                                                          width: 2.w,
                                                          color: Colors.grey,
                                                        )),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                SizedBox(
                                                  width: 250.w,
                                                  child: CustomText(
                                                    text: rideData
                                                            .pickupAddress ??
                                                        "N/A",
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                SizedBox(
                                                  width: 250.w,
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      CustomText(
                                                        text:
                                                            "Pickup Distance: ",
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontColor: const Color(
                                                            0xff2E8FF7),
                                                      ),
                                                      SizedBox(
                                                        width: 138.w,
                                                        child: CustomText(
                                                          text:
                                                              "${rideData.driverPickupDistance ?? 0} miles away",
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 4.0.w),
                                              child: Icon(
                                                Icons.location_on,
                                                size: 20.r,
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                SizedBox(
                                                  width: 250.w,
                                                  child: CustomText(
                                                      text: rideData
                                                              .destinationAddress ??
                                                          "N/A",
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  width: 250.w,
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      CustomText(
                                                        text:
                                                            "Drop Off Distance: ",
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontColor: const Color(
                                                            0xff2E8FF7),
                                                      ),
                                                      SizedBox(
                                                        width: 130.w,
                                                        child: CustomText(
                                                          text:
                                                              "${rideData.calculativeDistance ?? "0"} miles away",
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Padding(
                                    padding: EdgeInsets.only(left: 22.0.w),
                                    child: Visibility(
                                      visible:
                                          rideData.destinationVia!.isNotEmpty
                                              ? true
                                              : false,
                                      child: CustomText(
                                        text: "Multi destination trip",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        fontColor: const Color(0xff49965E),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  CustomText(
                                    text: "GBP:  ${rideData.bookingPrice}",
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    fontColor: AppColors.kRedColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    );
                  }));
    });
  }

  qrCodeRides() {
    return GetBuilder<HomeController>(builder: (cont) {
      return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20),
          child: cont.qrCodeList.isEmpty
              ? ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 200.h,
                      ),
                      const Center(
                        child: CustomText(
                          text: "No Rides",
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  controller: scrollControllerRunning,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: cont.qrCodeList.length + 1,
                  itemBuilder: (context, index) {
                    if (index >= cont.qrCodeList.length) {
                      return Center(
                          child: cont.noMoreQrCode.value
                              ? CustomText(
                                  text: 'No More Item',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      width: 20.w,
                                      height: 20.h,
                                      child: const CircularProgressIndicator()),
                                ));
                    }
                    final rideData = cont.qrCodeList[index];
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            cont.screenType = 3;
                            cont.rideId = rideData.id ?? 1;
                            cont.getRideDetails();
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 15,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 10.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CustomText(
                                            text: "Pickup Time: ",
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                            fontColor: const Color(0xff10C600),
                                          ),
                                          CustomText(
                                            text: rideData.pickupTime ?? "",
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                            fontColor: const Color(0xff303030),
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        Icons.more_horiz,
                                        size: 40.r,
                                        color: AppColors.kPrimaryColor,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      CustomText(
                                        text: "Pickup Date: ",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        fontColor: const Color(0xff2E8FF7),
                                      ),
                                      CustomText(
                                        text: "${rideData.pickupDate}",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        fontColor: const Color(0xff303030),
                                      ),
                                    ],
                                  ),
                                  Divider(height: 10.h, color: Colors.black),
                                  SizedBox(height: 10.h),
                                  IntrinsicHeight(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 4.0.w),
                                                  child: Icon(
                                                    Icons.location_on,
                                                    size: 20.r,
                                                    color:
                                                        AppColors.kGreenColor,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Column(
                                                  children: List.generate(
                                                    (((rideData.pickupAddress
                                                                        ?.length ??
                                                                    0) ~/
                                                                25) *
                                                            2) +
                                                        5,
                                                    (i) => Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: 8.w,
                                                          right: 12.w,
                                                          top: 4.h,
                                                        ),
                                                        child: Container(
                                                          height: 5.h,
                                                          width: 2.w,
                                                          color: Colors.grey,
                                                        )),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                SizedBox(
                                                  width: 250.w,
                                                  child: CustomText(
                                                    text: rideData
                                                            .pickupAddress ??
                                                        "N/A",
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                SizedBox(
                                                  width: 250.w,
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      CustomText(
                                                        text:
                                                            "Pickup Distance: ",
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontColor: const Color(
                                                            0xff2E8FF7),
                                                      ),
                                                      SizedBox(
                                                        width: 138.w,
                                                        child: CustomText(
                                                          text:
                                                              "${rideData.driverPickupDistance ?? 0} miles away",
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 4.0.w),
                                              child: Icon(
                                                Icons.location_on,
                                                size: 20.r,
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                SizedBox(
                                                  width: 250.w,
                                                  child: CustomText(
                                                      text: rideData
                                                              .destinationAddress ??
                                                          "N/A",
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  width: 250.w,
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      CustomText(
                                                        text:
                                                            "Drop Off Distance: ",
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontColor: const Color(
                                                            0xff2E8FF7),
                                                      ),
                                                      SizedBox(
                                                        width: 130.w,
                                                        child: CustomText(
                                                          text:
                                                              "${rideData.calculativeDistance ?? "0"} miles away",
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Padding(
                                    padding: EdgeInsets.only(left: 22.0.w),
                                    child: Visibility(
                                      visible:
                                          rideData.destinationVia!.isNotEmpty
                                              ? true
                                              : false,
                                      child: CustomText(
                                        text: "Multi destination trip",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        fontColor: const Color(0xff49965E),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  CustomText(
                                    text: "GBP:  ${rideData.bookingPrice}",
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    fontColor: AppColors.kRedColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    );
                  }));
    });
  }

  fetchMoreDataUpcoming() async {
    // controller.isRefresh = false;
    controller.noMoreUpcoming = false.obs;
    controller.update();

    if (controller.upcomingRidesModel!.upcomingRides!.currentPage! <
        controller.upcomingRidesModel!.upcomingRides!.lastPage!) {
      controller.pageUpcoming = controller.pageUpcoming + 1;
    } else {
      controller.noMoreUpcoming = true.obs;
      controller.update();
      return;
    }
    await controller.getUpcomingRides();
    controller.update();
  }

  fetchMoreDataQrCode() async {
    // controller.isRefresh = false;
    controller.noMoreQrCode = false.obs;
    controller.update();
    if (controller.qRCodeModel!.qrCodeRide!.currentPage! <
        controller.qRCodeModel!.qrCodeRide!.lastPage!) {
      controller.pageQrCode = controller.pageQrCode + 1;
    } else {
      controller.noMoreQrCode = true.obs;
      controller.update();
      return;
    }
    await controller.getQrCodeRides();
    controller.update();
  }

  fetchMoreDataRunning() async {
    //controller.isRefresh = false;
    controller.noMoreRunning = false.obs;
    controller.update();
    if (controller.runningRidesModel!.runningRides!.currentPage! <
        controller.runningRidesModel!.runningRides!.lastPage!) {
      controller.pageRunning = controller.pageRunning + 1;
    } else {
      controller.noMoreRunning = true.obs;
      controller.update();
      return;
    }
    await controller.getRunningRides();
    controller.update();
  }

  fetchMoreDataRide() async {
    //controller.isRefresh = false;
    controller.noMoreRide = false.obs;
    controller.update();
    if (controller.rideRequestModel!.rideRequest!.currentPage! <
        controller.rideRequestModel!.rideRequest!.lastPage!) {
      controller.pageRide = controller.pageRide + 1;
    } else {
      controller.noMoreRide = true.obs;
      controller.update();
      return;
    }
    await controller.getRideRequest();
    controller.update();
  }
}
// Card(
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(10)
// ),
// elevation: 15,
// child:Padding(
// padding: EdgeInsets.symmetric(
// horizontal: 15.w, vertical: 10.h),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Row(
// mainAxisAlignment:
// MainAxisAlignment.spaceBetween,
// children: [
// Row(
// children: [
// CustomText(
// text:
// "Reference # ",
// fontSize: 18.sp,
// fontColor: Color(0xff303030),
// ),
// CustomText(
// text:
// rideData.referenceNo ?? "",
// fontSize: 18.sp,
// fontWeight: FontWeight.w600,
// fontColor: Color(0xff303030),
// ),
// ],
// ),
// Icon(
// Icons.more_horiz,
// size: 40.r,
// color: AppColors.kPrimaryColor,
// )
// ],
// ),
// Row(
// children: [
// CustomText(
// text:
// "Pickup Time:",
// fontSize: 16.sp,
// fontWeight: FontWeight.w500,
// fontColor: const Color(0xff10C600),
// ),
// CustomText(
// text: rideData.pickupTime ?? "",
// fontSize: 16.sp,
// fontWeight: FontWeight.w600,
// fontColor:
// Color(0xff303030),
// ),
// ],
// ),
// SizedBox(height: 10.h),
// Row(
// children: [
// CustomText(
// text:
// "Pickup Distance: ",
// fontSize: 16.sp,
// fontWeight: FontWeight.w600,
// fontColor: const Color(0xff2E8FF7),
// ),
// CustomText(
// text: "${rideData.driverPickupDistance} km",
// fontSize: 16.sp,
// fontWeight: FontWeight.w400,
// fontColor:
// Color(0xff303030),
// ),
// ],
// ),
// Divider(height: 10.h, color: Colors.black),
// SizedBox(height: 15.h),
// Padding(
// padding:  EdgeInsets.only(left:20.0.w),
// child: CustomText(
// text:
// "${rideData.firstName} ${rideData
//     .lastName}",
// fontSize: 18.sp,
// fontWeight: FontWeight.w600,
// fontColor:const Color(0xffF40D04),
// ),
// ),
// SizedBox(height: 15.h),
// IntrinsicHeight(
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Row(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Column(
// children: [
// Padding(
// padding:  EdgeInsets.only(right:4.0.w),
// child: Icon(
// Icons.location_on,
// size: 20.r,
// color: AppColors.kGreenColor,
// ),
// ),
// Column(
// children: List.generate(
// ((rideData.pickupAddress?.length??0)~/25)+1,
// (i) => Padding(
// padding: EdgeInsets.only(
// left: 8.w,
// right: 12.w,
// top: 5.h,
// bottom: 5.h),
// child: Container(
// height: 5.h,
// width: 2.w,
// color: Colors.grey,
// )),
// ),
// ),
// ],
// ),
// SizedBox(
// width: 250.w,
// child: CustomText(
// text: rideData
//     .pickupAddress ??
// "N/A",
// fontSize: 16.sp,
// fontWeight: FontWeight.w600,
// ),
// ),
// ],
// ),
// Column(
// children: List.generate(
// rideData.destinationVia
//     ?.length ??
// 0,
// (index) {
// final waitData =   rideData.destinationVia?[index];
// return Row(
// crossAxisAlignment:
// CrossAxisAlignment.start,
// children: [
// Column(
// children: [
// Column(
// children: [
// Padding(
// padding: EdgeInsets.only(
// left: 8.w,
// right: 12.w,
// top: 5.h,
// bottom: 5.h),
// child: Container(
// height: 5,
// width: 2,
// color: Colors.grey,
// )),
// Padding(
// padding: EdgeInsets.only(
// left: 8.w,
// right: 12.w,
// top: 5.h,
// bottom: 5.h),
// child: Container(
// height: 5,
// width: 2,
// color: Colors.grey,
// )),
// Padding(
// padding:  EdgeInsets.only(right:3.0.w),
// child: Image.asset(
// "assets/images/waitLocation.png",
// color: Colors.black,
// height:18.h,
// width: 18.w,
// ),
// ),
// ],
// ),
// Column(
// children: List.generate(
// ((waitData?.destinationAddressVia?.length??0)~/25)+2,
// (i) => Padding(
// padding: EdgeInsets.only(
// left: 8.w,
// right: 12.w,
// top: 5.h,
// bottom: 5.h),
// child: Container(
// height: 5,
// width: 2,
// color: Colors.grey,
// )),
// ),
// ),
// ],
// ),
// Column(
// children: [
// SizedBox(
// width: 250.w,
// child: Row(
// children: [
// CustomText(
// text: "Drop Off Distance: ",
// fontSize: 16.sp,
// fontWeight: FontWeight.w600,
// fontColor: const Color(0xff2E8FF7),
// ),
// CustomText(
// text: "${waitData?.destinationViaDistance.toString()} km",
// fontSize: 16.sp,
// fontWeight: FontWeight.w400,
// overflow: TextOverflow.visible,
// ),
// ],
// ),
// ),
// SizedBox(height: 8.h,),
// SizedBox(
// width: 250.w,
// child: CustomText(
// text: waitData
//     ?.destinationAddressVia ??
// "N/A",
// fontSize: 16.sp,
// fontWeight: FontWeight.bold,
// overflow: TextOverflow.visible,
// ),
// ),
// SizedBox(
// height: 3.h,
// ),
// SizedBox(
// width: 250.w,
// child: CustomText(
// text:
// "Stay Time: ${waitData?.stayTime ?? "N/A"} minutes",
// fontColor:
// const Color(0xffF40D04),
// fontSize: 13.sp,
// ),
// ),
// SizedBox(
// height: 10.h,
// )
// ],
// ),
// ],
// );
// },
// ),
// ),
// Row(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Column(
// children: [
// Padding(
// padding: EdgeInsets.only(
// left: 8.w,
// right: 12.5.w,
// top: 5.h,
// bottom: 5.h),
// child: Container(
// height: 5,
// width: 2,
// color: Colors.grey,
// )),
// Padding(
// padding: EdgeInsets.only(
// left: 8.w,
// right: 12.5.w,
// top: 5.h,
// bottom: 5.h),
// child: Container(
// height: 5,
// width: 2,
// color: Colors.grey,
// )),
// Padding(
// padding:  EdgeInsets.only(right:4.0.w),
// child: Icon(
// Icons.location_on,
// size: 20.r,
// color: Colors.black.withOpacity(0.5),
// ),
// ),
// ],
// ),
// Column(
// children: [
// SizedBox(
// width: 250.w,
// child: Row(
// children: [
// CustomText(
// text: "Drop Off Distance: ",
// fontSize: 16.sp,
// fontWeight: FontWeight.w600,
// fontColor: const Color(0xff2E8FF7),
// ),
//
// CustomText(
// text: "${rideData.driverDestinationAddressDistance.toString()} km",
// fontSize: 16.sp,
// fontWeight: FontWeight.w400,
// overflow: TextOverflow.visible,
// ),
// ],
// ),
// ),
// SizedBox(height: 10.h,),
// SizedBox(
// width: 250.w,
// child: CustomText(
// text: rideData.destinationAddress ??
// "N/A",
// fontSize: 16.sp,
// fontWeight: FontWeight.bold,
// ),
// ),
// ],
// ),
// ],
// ),
// SizedBox(height: 10.h),
// ],
// ),
// ),
// SizedBox(height: 10.h),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// CustomText(
// text: "GBP:  ${rideData.driverPrice}",
// fontSize: 16.sp,
// fontWeight: FontWeight.w600,
// fontColor: AppColors.kRedColor,
// ),
// TimerCountdown(
// enableDescriptions: false,
// format: CountDownTimerFormat.secondsOnly,
// endTime: DateTime.now().add(
// Duration(
// seconds: rideData.remainingSeconds??60,
// ),
// ),
// onEnd: () {
// },
// ),
//
// ],
// ),
// ],
// ),
// ),
// ),
