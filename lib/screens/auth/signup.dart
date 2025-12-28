import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_app/screens/auth/widgets/coustom_text_form.dart';
import 'package:note_app/screens/auth/widgets/custom_button.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isObscure = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 70.h,
                    ),
                    Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'Please Sign up to your account',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Text(
                      'Name',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    // name textfield
                    TextFeild(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Enter your name';
                        }
                        return null;
                      },
                      prefixIcon: Icon(Icons.person),
                      hintText: 'Enter your name',
                      controller: nameController,
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
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Enter your email';
                        }
                        return null;
                      },
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
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Enter your password';
                        }
                        return null;
                      },
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
              ),
              // signup button
              CustomButton(
                title: 'Sign Up',
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );

                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        animType: AnimType.rightSlide,
                        title: 'Success',
                        desc: 'Account created successfully',
                        btnOkOnPress: () {
                          Navigator.pushReplacementNamed(context, 'login');
                        },
                      ).show();
                    } on FirebaseAuthException catch (e) {
                      String message;

                      switch (e.code) {
                        case 'weak-password':
                          message =
                              'Password is too weak (minimum 6 characters).';
                          break;

                        case 'email-already-in-use':
                          message = 'This email is already registered.';
                          break;

                        case 'invalid-email':
                          message = 'Invalid email format.';
                          break;

                        default:
                          message = e.message ?? 'Registration failed.';
                      }

                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Error',
                        desc: message,
                        btnOkOnPress: () {},
                      ).show();
                    } catch (e) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        title: 'Error',
                        desc: 'Unexpected error occurred',
                        btnOkOnPress: () {},
                      ).show();
                    }
                  }
                  else {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.rightSlide,
                      title: 'Error',
                      desc: 'Please fill all the fields',
                      btnOkOnPress: () {},
                    ).show();
                  }
                },
              ),
              SizedBox(
                height: 20.h,
              ),

              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'login');
                },
                child: Text.rich(
                  TextSpan(
                    text: "Already have an account? ",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey,
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign In',
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
    );
  }
}
