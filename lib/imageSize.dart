import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taxi_gogo/components/custom_text.dart';

class ImageSizeC extends StatefulWidget {
  const ImageSizeC({Key? key}) : super(key: key);

  @override
  State<ImageSizeC> createState() => _ImageSizeCState();
}

class _ImageSizeCState extends State<ImageSizeC> {
  File? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             InkWell(
               onTap: (){
                 _showChoiceDialog(context);
               },
               child: Container(
                height: 200,
                width: 300,
                 child:image==null?CustomText(
                   text: "Image show be\n less then 500Kb",
                 ):Image.file(image!),
            ),
             )
          ],
        ),
      ),
    );
  }

  _openCamera(BuildContext context) async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      if (((File(pickedFile.path).lengthSync()) / 1024) < 501) {
        image = File(pickedFile.path);
      }
      else {
        Get.defaultDialog(title: "Size less then 500",

        );
      }
      print((image?.lengthSync())! / 1024);
      setState(() {

      });
    }
  }
    _openGallery(BuildContext context) async {
      final pickedFile =
      await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        if (((File(pickedFile.path).lengthSync()) / 1024) < 501) {
          image = File(pickedFile.path);
        }
        else {
          Get.defaultDialog(title: "Size less then 500",

          );
        }
      }

      print("////////////////////////////////////////////");
      print((image?.lengthSync())! / 1024);
      print("////////////////////////////////////////////");

      setState(() {

      });
    }

    Future _showChoiceDialog(BuildContext context) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Choose option",
              style: TextStyle(color: const Color(0xff000000).withOpacity(.6)),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  ListTile(
                    onTap: () {
                      _openGallery(context);
                      Navigator.pop(context);
                    },
                    title: const Text("Gallery"),
                    leading: const Icon(
                      Icons.account_box,
                      color: Color(0xff8C8FA5),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      _openCamera(context);
                      Navigator.pop(context);
                    },
                    title: const Text("Camera"),
                    leading: const Icon(
                      Icons.camera,
                      color: Color(0xff8C8FA5),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }
