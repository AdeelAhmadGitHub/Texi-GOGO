import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Controllers/RegisterController.dart';
import '../../components/custom_card.dart';
import '../../components/custom_text.dart';
import '../Account/RegisterAccount/register_account.dart';

class ConfirmPassword extends StatefulWidget {
  const ConfirmPassword({Key? key}) : super(key: key);

  @override
  State<ConfirmPassword> createState() => _ConfirmPasswordState();
}

class _ConfirmPasswordState extends State<ConfirmPassword> {
  final key = GlobalKey<FormState>();
  bool showPassword=false;
  bool showConfirmPassword=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
          key: key,
          child: GetBuilder<RegisterController>(builder: (cont) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Padding(
                        padding:  EdgeInsets.only(top: 30.h,bottom: 20.h),
                        child: Image.asset(
                          "assets/images/logo.png",
                          height: 172.h,
                          width: 189.h,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const CustomText(
                      text: "Create Account",
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 15.h),
                      child: const CustomText(
                        text: "Please enter your Password",
                        fontSize: 12,
                        textAlign: TextAlign.center,
                        fontColor:  Color(0xffAEAEAE),
                      ),
                    ),
                    const CustomText(text: "Password",
                      fontSize: 16,
                    ),
                    SizedBox(height: 5.h,),
                    TextFormField(
                      cursorColor: const Color(0xff000000),
                      controller: cont.passwordCont,
                      obscureText: showPassword,
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                            onTap: (){
                              setState(() {
                                showPassword= !showPassword;
                              });
                            },
                            child: Icon(!showPassword?Icons.visibility_off:Icons.visibility)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:const BorderSide(
                              color:  Color(0xffA8ADB1),
                            )),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide:const BorderSide(
                            color:  Color(0xffA8ADB1),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide:const BorderSide(
                            color:  Color(0xffA8ADB1),
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Colors.red,
                            )),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Colors.red,
                            )),
                        contentPadding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 20.w),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Password";
                        }else if(value.length <8){
                          return "The password must be at least 8 characters.";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15.h,),
                    const CustomText(text: "Confirm Password",
                      fontSize: 16,
                    ),
                    SizedBox(height: 5.h,),
                    TextFormField(
                      cursorColor: const Color(0xff000000),
                      controller: cont.confirmPasswordCont,
                      obscureText: showConfirmPassword,
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                            onTap: (){
                              setState(() {
                                showConfirmPassword= !showConfirmPassword;
                              });
                            },
                            child: Icon(!showConfirmPassword?Icons.visibility_off:Icons.visibility)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:const BorderSide(
                              color:  Color(0xffA8ADB1),
                            )),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide:const BorderSide(
                            color:  Color(0xffA8ADB1),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide:const BorderSide(
                            color:  Color(0xffA8ADB1),
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Colors.red,
                            )),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Colors.red,
                            )),
                        contentPadding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 20.w),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Confirm Password";
                        }else if(cont.passwordCont.text !=value){
                          return "Password dose not match";
                        }else if(value.length <8){
                          return "The password must be at least 8 characters.";
                        }else{
                          return null;
                        }
                      },
                    ),
                    Padding(
                      padding:  EdgeInsets.only(top: 144.h,),
                      child: CustomButton(
                        height: 54.h,
                        width: double.infinity.w,
                        buttonColor: const Color(0xffDDCA7F),
                        child: const Center(
                            child: CustomText(
                              text: "Submit",
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            )),
                        onTap: () async {
                          if(key.currentState!.validate()){
                            cont.createPassword();
                          }

                        },
                      ),
                    ),
                  ],
                ),
              ),
            );

          },),
        ));
  }
}
