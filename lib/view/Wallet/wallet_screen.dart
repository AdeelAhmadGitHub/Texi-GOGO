import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:taxi_gogo/Controllers/home_controller.dart';
import 'package:taxi_gogo/components/custom_card.dart';
import 'package:taxi_gogo/components/custom_text.dart';
import 'package:taxi_gogo/const/app_color.dart';
import 'package:get/get.dart';
import '../../Controllers/wallet_controller.dart';
import '../job_preview/job_preview_screen.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final walletCont = Get.put(WalletController());
  final homeCont = Get.put(HomeController());
  ScrollController scrollControllerRunning = ScrollController();
  bool noMoreDataList = true;

  @override
  initState() {
    super.initState();
    print("sasadASddgxyubIQUXBDOxnkl");
    if (walletCont.walletDataList.length > 15) {
      noMoreDataList = false;
    }
    scrollControllerRunning.addListener(() {
      if (scrollControllerRunning.position.maxScrollExtent ==
          scrollControllerRunning.offset) {
        fetchMoreDataList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: WalletController(),
        builder: (cont) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    height: 198.h,
                    width: double.infinity,
                    color: AppColors.kBlackColor,
                    child: Padding(
                      padding: EdgeInsets.only(top: 30.0.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 20.w,
                          ),
                          InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Color(0xffFFFFFF),
                              )),
                          SizedBox(
                            width: 100.w,
                          ),
                          CustomText(
                            text: "Ride Details",
                            fontSize: 20.sp,
                            fontColor: Colors.white,
                            fontWeight: FontWeight.bold,
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 105.0.h),
                    child: Center(
                      child: Container(
                        height: 123.h,
                        width: 330.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xffDDCA7F)),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 30.h),
                              child: CustomText(
                                text: "Total Earning in week",
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomText(
                              text:
                                  "GBP ${cont.walletModel?.totalEarningInWeek.toString() ?? "0"}",
                              fontWeight: FontWeight.w700,
                              fontSize: 24.sp,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  SizedBox(width: 20.w,),
                 const CustomText(
                    text: "Search Filter",
                    fontSize: 14,
                    fontColor: Color(0xff474747),
                  ),
                  SizedBox(width: 20.w,),
                  InkWell(
                    onTap: (){
                      cont.type=0;
                      _selectDate(context);

                    },
                    child: Card(
                      child:Padding(
                        padding: EdgeInsets.symmetric(horizontal:10.0.h,vertical: 5.h),
                        child: CustomText(
                          text: cont.fromDate?.value??"From",
                          fontSize: 14,
                          fontColor:const Color(0xff474747),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w,),
                  InkWell(
                    onTap: (){
                      cont.type=1;
                      _selectDate(context);
                    },
                    child: Card(
                      child:Padding(
                        padding: EdgeInsets.symmetric(horizontal:10.0.h,vertical: 5.h),
                        child: CustomText(
                          text: cont.toDate?.value??"To",
                          fontSize: 14,
                          fontColor: Color(0xff474747),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        noMoreDataList = true;
                        cont.walletPage = 1;
                        cont.pagination = false;
                        cont.isNavigate = false;
                        cont.paymentType = "payment_link";
                        cont.currentType = 0;
                        cont.weeklyEarningReport();
                      },
                      child: Column(
                        children: [
                          CustomText(
                            text: 'Online\nPayment',
                            fontSize: 16,
                            fontColor: cont.currentState.value == 0
                                ? const Color(0xffDDCA7F)
                                : AppColors.kBlackColor,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Container(
                            height: 2.w,
                            width: 70.w,
                            color: cont.currentState.value == 0
                                ? const Color(0xffDDCA7F)
                                : const Color(0xffC4C4C4),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        noMoreDataList = true;
                        cont.walletPage = 1;
                        cont.pagination = false;
                        cont.isNavigate = false;
                        cont.paymentType = "credit_card";
                        cont.currentType = 1;
                        cont.weeklyEarningReport();
                      },
                      child: Column(
                        children: [
                          CustomText(
                            text: 'Card\nPayment',
                            fontSize: 16,
                            fontColor: cont.currentState.value == 1
                                ? const Color(0xffDDCA7F)
                                : AppColors.kBlackColor,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Container(
                            height: 2.w,
                            width: 70.w,
                            color: cont.currentState.value == 1
                                ? const Color(0xffDDCA7F)
                                : const Color(0xffC4C4C4),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        noMoreDataList = true;
                        cont.walletPage = 1;
                        cont.pagination = false;
                        cont.isNavigate = true;
                        cont.paymentType = "cash";
                        cont.currentType = 3;
                        cont.weeklyEarningReport();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            CustomText(
                              textAlign: TextAlign.center,
                              text: 'Cash\nPayment',
                              fontSize: 16,
                              fontColor: cont.currentState.value == 2
                                  ? const Color(0xffDDCA7F)
                                  : AppColors.kBlackColor,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Container(
                              height: 2.w,
                              width: 70.w,
                              color: cont.currentState.value == 2
                                  ? const Color(0xffDDCA7F)
                                  : const Color(0xffC4C4C4),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  height: 86.h,
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: Card(
                      color: const Color(0xff000000),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        //color: Color(0xff000000),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text:
                                      "${cont.currentType == 0 ? "Online" : cont.currentType == 1 ? "Card" : "Cash"} Earning \n in week",
                                  fontSize: 20.sp,
                                  fontColor: const Color(0xffFFFFFF),
                                  fontWeight: FontWeight.w500,
                                  textAlign: TextAlign.center,
                                ),
                                CustomText(
                                  text:
                                      "GBP  \n ${cont.walletModel?.paymentTypeEarningInWeek.toString() ?? "0"}",
                                  fontSize: 20.sp,
                                  fontColor: const Color(0xffFFFFFF),
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Reference # ",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      fontColor: const Color(0xff303030),
                    ),
                    CustomText(
                      text: "Amount",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      fontColor: const Color(0xff303030),
                    ),
                    CustomText(
                      text: "Date",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      fontColor: const Color(0xff303030),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              SizedBox(
                height: 3.h,
              ),
              cont.walletDataList.isEmpty
                  ? Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 140.h),
                        child: const CustomText(
                          text: "No Data Found",
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          controller: scrollControllerRunning,
                          // shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: cont.walletDataList.length + 1 ?? 0,
                          itemBuilder: (context, index) {
                            print(cont.walletDataList.length);
                            if (index >= cont.walletDataList.length) {
                              return Center(
                                  child: noMoreDataList
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
                            final value = cont.walletDataList[index];
                            return Column(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  child: const Divider(
                                    thickness: 2,
                                    color: Color(0xffC4C4C4),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomText(
                                        text: value.referenceNo ?? "N/A",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500,
                                        fontColor: const Color(0xff303030),
                                      ),
                                      CustomText(
                                        text:
                                            "GBP : ${value.driverAmount ?? "0"}",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500,
                                        fontColor: const Color(0xff303030),
                                      ),
                                      SizedBox(
                                        width: 60.w,
                                        child: CustomText(
                                          text: value.createdAt ?? "N/A",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500,
                                          fontColor: const Color(0xff303030),
                                        ),
                                      ),
                                      CustomButton(
                                          onTap: () {
                                            homeCont.screenType = 4;
                                            homeCont.rideId = value.id ?? 0;
                                            homeCont.getRideDetails();
                                          },
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          buttonColor: const Color(0xffDDCA7F),
                                          height: 30.h,
                                          width: 48.w,
                                          child: Center(
                                            child: Text(
                                              "View",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14.sp,
                                                  color:
                                                      const Color(0xff000000)),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  child: const Divider(
                                    thickness: 2,
                                    color: Color(0xffC4C4C4),
                                  ),
                                ),
                              ],
                            );
                          }),
                    )
            ],
          );
        },
      ),
    );
  }
  fetchMoreDataList() async {
    walletCont.pagination = true;
    noMoreDataList = false;
    setState(() {});
    if (walletCont.walletModel!.paymentTypeTransactions!.currentPage! <
        walletCont.walletModel!.paymentTypeTransactions!.lastPage!) {
      walletCont.walletPage = walletCont.walletPage + 1;
    } else {
      noMoreDataList = true;
      setState(() {});
      return;
    }
    await walletCont.weeklyEarningReport();
    noMoreDataList = true;
    setState(() {});
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1947),
        lastDate: DateTime(3000));
    if (picked != null) {
     if(walletCont.type==0){
       walletCont.fromDate=DateFormat('yyyy-MM-dd').format(picked).obs;
       walletCont.update();
       walletCont.weeklyEarningReport();
     }else{
       walletCont.toDate=DateFormat('yyyy-MM-dd').format(picked).obs;
       walletCont.update();
       walletCont.weeklyEarningReport();
     }

    }
  }
}
