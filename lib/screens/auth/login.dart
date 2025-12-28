import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_app/screens/auth/widgets/logo_widget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Container(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 70.h,
                    ),
                    Logo(),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'Please Sign in to your account',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    // email textfield
                    TextField(
                      decoration: InputDecoration(
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
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20.h,
                    ),

                    Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    // password textfield
                    TextField(
                      decoration: InputDecoration(
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
                        hintText: 'Enter your password',
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 10.h, bottom: 20.h),
                      alignment: Alignment.topRight,
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.orange.shade200,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                // login button
                MaterialButton(
                  height: 40.h,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  textColor: Colors.white,
                  color: Colors.orange,
                  onPressed: () {},
                  child: Text('Login'),
                ),
                SizedBox(
                  height: 20.h,
                ),
                // Text('Or Continue with'),
                MaterialButton(
                  height: 40.h,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  textColor: Colors.white,
                  color: Colors.red.shade700,
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/google.png', height: 20.h),
                      SizedBox(width: 10.w),
                      Text('Continue with Google'),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                InkWell(
                  
                  onTap: () {},
                  child: Text.rich(
                    TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.orange.shade200,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
