import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    this.onPressed,
    required this.title,
  });
  final void Function()? onPressed;
  final String title;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 40.h,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.r),
      ),
      textColor: Colors.white,
      color: Colors.orange,
      onPressed: onPressed,
      child: Text(title),
    );
  }
}
