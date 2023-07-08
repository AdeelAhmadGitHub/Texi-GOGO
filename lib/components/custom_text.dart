import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? fontColor;

  const CustomText(
      {Key? key,
      this.text,
      this.overflow,
      this.textAlign,
      this.fontSize,
      this.fontWeight,
      this.fontColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      overflow: overflow,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: fontColor,
        fontFamily: "Montserrat-Light",
      ),
    );
  }
}
