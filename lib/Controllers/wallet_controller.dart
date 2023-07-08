import 'package:get/get.dart';

import '../api/api_client.dart';
import '../models/WalletModel.dart';
import '../utils/functions.dart';
import '../view/Wallet/wallet_screen.dart';
import 'auth_controller.dart';
class WalletController extends GetxController {
  ApiClient api = ApiClient(appBaseUrl: baseUrl);
  var auth = Get.find<AuthController>();
  RxInt  currentState = 0.obs;
  int currentType=0;
  String paymentType="payment_link";
  int walletPage=1;
  bool isNavigate=false;
  bool pagination=false;
  WalletModel? walletModel;
  List<WalletData> walletDataList=[];
  RxString? fromDate;
  RxString? toDate;
  int type=1;
 // List<WalletData> walletDataListCash=[];
  // List<WalletData> walletDataListCard=[];
  // List<WalletData> walletDataListPayment=[];
  Future<void> weeklyEarningReport() async {
    Response response = await api.postData(
        "api/weekly-earning-report?page=${walletPage.toString()}",
        {
          "paymentType":paymentType,
          "startDate":fromDate?.value,
          "endDate":toDate?.value,
        },
        showdialog: true);
    if (response == null) {
      errorAlert('Check your internet connection.');
    } else if (response.statusCode == 200) {
      var json = response.body;
      walletModel=WalletModel.fromJson(json);
      if(currentType==0){
        if(!pagination){
          walletDataList.clear();
        }
        if (json['PaymentTypeTransactions']['data'] != null) {
          json['PaymentTypeTransactions']['data'].forEach((v) {
            walletDataList.add(WalletData.fromJson(v));
          });
        }
        currentState = 0.obs;
        if(isNavigate){
          Get.to(const WalletScreen());
        }
        update();
      }else if(currentType==1){
        if(!pagination){
          walletDataList.clear();
        }
        if (json['PaymentTypeTransactions']['data'] != null) {
          json['PaymentTypeTransactions']['data'].forEach((v) {

            walletDataList.add(WalletData.fromJson(v));
          });
        }
        currentState = 1.obs;
        update();
      }else{
        if(!pagination){
          walletDataList.clear();
        }
        if (json['PaymentTypeTransactions']['data'] != null) {
          json['PaymentTypeTransactions']['data'].forEach((v) {
            walletDataList.add(WalletData.fromJson(v));
          });
        }
        currentState = 2.obs;
        update();
      }
    } else {
      errorAlert('Something went wrong\nPlease try again!');
    }
    update();
  }
}
