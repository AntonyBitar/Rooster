import 'package:flutter/material.dart';

import '../const/colors.dart';
class ReusableButtonWithColorSupplier extends StatelessWidget {
  const ReusableButtonWithColorSupplier({
    super.key,
    required this.btnText,
    required this.onTapFunction,
    required this.width,
    required this.height,
    this.radius = 4,
    this.isDisable = false,
    this.isLoading = false,
  });
  final String btnText;
  final Function onTapFunction;
  final double width;
  final double height;
  final double radius;
  final bool isDisable;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
      isDisable
          ? null
          : () {
        onTapFunction();
      },
      child: Container(
        // padding: EdgeInsets.all(5),
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Primary.primary,
          border: Border.all(color: Primary.p0),
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Center(
          child:isLoading? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          ) : Text(
            btnText,
            style: TextStyle(fontSize: 12, color: Primary.p0),
          ),
        ),
      ),
    );
  }
}
