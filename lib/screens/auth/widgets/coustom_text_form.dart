import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFeild extends StatelessWidget {
  TextFeild({
    super.key,
    this.hintText,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
  });
  final String? hintText;
  TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
   bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(
          vertical: 10.h,
          horizontal: 20.w,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.r),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.r),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
        filled: true,
        fillColor: Colors.grey.shade100,
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 14.sp,
          color: Colors.grey,
        ),
      ),
    );
  }
}
