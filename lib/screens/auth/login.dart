import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_app/screens/auth/widgets/coustom_text_form.dart';
import 'package:note_app/screens/auth/widgets/custom_button.dart';
import 'package:note_app/screens/auth/widgets/logo_widget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isObscure = true;
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
                    TextFeild(
                      prefixIcon: Icon(Icons.email),
                      hintText: 'Enter your email',
                      controller: emailController,
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
                    TextFeild(
                      obscureText: isObscure,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                        icon: isObscure
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                      ),
                      hintText: 'Enter your password',
                      controller: passwordController,
                    ),

                    // password textfield
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
                CustomButton(
                  title: 'Login with Email',
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );

                      Navigator.pushReplacementNamed(context, 'home');
                    } on FirebaseAuthException catch (e) {
                      String message;

                      switch (e.code) {
                        case 'user-not-found':
                          message = 'No user found for that email.';
                          break;

                        case 'wrong-password':
                          message = 'Wrong password provided.';
                          break;

                        case 'invalid-credential':
                          message = 'Email or password is incorrect.';
                          break;

                        case 'invalid-email':
                          message = 'Invalid email format.';
                          break;

                        default:
                          message = e.message ?? 'Login failed.';
                      }

                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Error',
                        desc: message,
                        btnOkOnPress: () {},
                      ).show();
                    }
                  },
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
                  onTap: () {
                    Navigator.pushNamed(context, 'signup');
                  },
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
