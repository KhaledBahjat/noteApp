import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_app/screens/auth/login.dart';
import 'package:note_app/screens/auth/signup.dart';
import 'package:note_app/screens/home_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              // Loading
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }

              // User logged in
              if (snapshot.hasData) {
                final user = snapshot.data!;

                if (user.emailVerified) {
                  return HomeScreen();
                } else {
                  return Login();
                }
              }

              // User not logged in
              return Login();
            },
          ),
          routes: {
            'login': (context) => Login(),
            'signup': (context) => SignUp(),
            'home': (context) => HomeScreen(),
            
          },
        );
      },
    );
  }
}
