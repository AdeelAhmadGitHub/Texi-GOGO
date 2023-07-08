import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class CustomCard extends StatelessWidget {
  final List<BoxShadow>? boxShadow;

  final double? height;
  final double? width;
  final Widget cardChild;
  final Color? cardColor;
  final BoxBorder? border;
  final BorderRadius? borderRadius;

  const CustomCard(
      {Key? key,
      this.boxShadow,
      this.height,
      this.width,
      required this.cardChild,
      this.cardColor,
      this.border,
      this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: cardColor,
        boxShadow: boxShadow,
        border: border,
        borderRadius: borderRadius,
      ),
      child: cardChild,
    );
  }
}

class CustomButton extends StatelessWidget {
  final List<BoxShadow>? boxShadow;

  final double? height;
  final double? width;
  final Widget child;
  final Color? buttonColor;
  final BoxBorder? border;
  final BorderRadius? borderRadius;
  final Callback? onTap;

  const CustomButton(
      {Key? key,
      this.boxShadow,
      this.height,
      this.width,
      required this.child,
      this.buttonColor,
      this.border,
      this.onTap,
      this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: buttonColor,
          boxShadow: boxShadow,
          border: border,
          borderRadius:borderRadius??BorderRadius.circular(10),
        ),
        child: child,
      ),
    );
  }
}
