import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:note_app/screens/auth/widgets/coustom_text_form.dart';
import 'package:note_app/screens/auth/widgets/custom_button.dart';
import 'package:note_app/screens/auth/widgets/forget_password_widget.dart';
import 'package:note_app/screens/auth/widgets/logo_widget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    await GoogleSignIn().signOut();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    if (googleUser == null) {
      return;
    }
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.of(context).pushNamedAndRemoveUntil('home', (route) => false);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isObscure = true;
  GlobalKey<FormState> formstate = GlobalKey();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                  strokeWidth: 2,
                ),
              )
            : Padding(
                padding: EdgeInsets.all(20),
                child: ListView(
                  children: [
                    Form(
                      key: formstate,
                      child: Column(
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
                          GestureDetector(
                            onTap: () => showForgotPasswordDialog(context),
                            child: Container(
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
                          ),
                        ],
                      ),
                    ),
                    // login button
                    CustomButton(
                      title: 'Login with Email',
                      onPressed: () async {
                        if (formstate.currentState!.validate()) {
                          try {
                            isLoading = true;
                            setState(() {});
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                );
                            isLoading = false;
                            setState(() {});
                            if (FirebaseAuth
                                    .instance
                                    .currentUser!
                                    .emailVerified &&
                                FirebaseAuth.instance.currentUser != null) {
                              Navigator.of(
                                context,
                              ).pushReplacementNamed('home');
                            } else {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.info,
                                animType: AnimType.rightSlide,
                                title: 'Error',
                                desc: 'Please verify your email.',
                                btnOkOnPress: () async {
                                  await FirebaseAuth.instance.currentUser!
                                      .sendEmailVerification();
                                },
                              ).show();
                            }
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
                        } else {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc: 'Please fill all the fields.',
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
                      onPressed: () {
                        signInWithGoogle();
                      },
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
    );
  }
}
