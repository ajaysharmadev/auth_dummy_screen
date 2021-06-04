import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = 'welcome-screen';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Expanded(
        child: Column(
          children: <Widget>[
            Text('Welcome Bro!'),
            SizedBox(
              height: 100,
            ),
            ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  print(FirebaseAuth.instance.currentUser!.email);
                },
                child: Text('Log out!'))
          ],
        ),
      )),
    );
  }
}
