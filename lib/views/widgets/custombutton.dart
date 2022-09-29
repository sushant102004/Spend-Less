import 'package:expensetracker/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    Key? key,
    required this.onTap,
    required this.text,
    required this.fontSize,
    required this.height,
    required this.width,
  }) : super(key: key);

  final constants = Get.put(Constants());

  Function()? onTap;
  String text;
  double height;
  double width;
  double fontSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: constants.primaryColor,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: constants.textColor,
                fontWeight: FontWeight.w600,
                fontSize: fontSize),
          ),
        ),
      ),
    );
  }
}
