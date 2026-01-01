import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          Navigator.of(context).pushNamed('addCategory');
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        elevation: 5,
        title: Text('Home Screen'),
        actions: [
          IconButton(
            onPressed: () async {
              GoogleSignIn googleSignIn = GoogleSignIn();
              googleSignIn.disconnect();
              await FirebaseAuth.instance.signOut();
              Navigator.of(
                context,
              ).pushReplacementNamed('login');
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          mainAxisExtent: 160,
        ),

        children: [
          Card(
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Image.asset(
                    'assets/categorys.png',
                    height: 100,
                  ),

                  Text('Category'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
