
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'package:login_ui/widgets/login_form.dart';
import 'package:login_ui/widgets/signup_form.dart';


class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  var _isLoading = false;
  final _auth = FirebaseAuth.instance;
  void _submitAuthForm(
      String email, String password, bool isLoggedIn, BuildContext ctx) async {
    var authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLoggedIn) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        _isLoading = false;
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        setState(() {
          isLogin = !isLogin;
        });
      }
    }
    // on PlatformException catch (err) {
    //   var message = 'An error occured, please check your credentials.';
    //   if (err.message != null) {
    //     message = err.message!;
    //   }
    //   final snackBar = SnackBar(
    //     content: Text(message),
    //   );
    //   print('message' + message);
    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //   // Scaffold.of(ctx).showSnackBar(
    //   //   SnackBar(
    //   //     content: Text(message),
    //   //     backgroundColor: Theme.of(context).errorColor,
    //   //   ),
    //   // );
    //   setState(() {
    //     _isLoading = false;
    //   });
    // }
    catch (err) {
      var message = 'An error occured, please check your credentials';
      if (err != null) {
        message = err.toString();
      }
      final snackBar = SnackBar(
        content: Text(message),
      );
      print('message' + message);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: deviceWidth,
        height: deviceHeight,
        child: Center(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeIn,
            width: deviceWidth,
            height: isLogin ? deviceHeight * 0.8 : deviceHeight * 0.731,
            padding: EdgeInsets.symmetric(
                horizontal: deviceWidth * 0.05, vertical: deviceHeight * 0.1),
            child: Card(
              color: Colors.white,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: FlutterSwitch(
                        activeText: "Log In",
                        inactiveText: "Sign Up",
                        value: isLogin,
                        activeTextColor: Colors.white,
                        inactiveTextColor: Colors.white,
                        valueFontSize: 25.0,
                        width: deviceWidth * 0.4,
                        height: deviceHeight * 0.06,
                        borderRadius: 30.0,
                        showOnOff: true,
                        toggleSize: 40,
                        inactiveColor: Colors.pink,
                        activeTextFontWeight: FontWeight.w400,
                        inactiveTextFontWeight: FontWeight.w400,
                        onToggle: (val) {
                          setState(() {
                            isLogin = val;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: isLogin
                          ? LogInScreen(_isLoading, _submitAuthForm)
                          : SignUpScreen(_isLoading, _submitAuthForm),
                    ),
                  )
                  // Container(6
                  //   alignment: Alignment.centerRight,
                  //   child: Text(
                  //     "Value: $isLogin",
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
        // color: Colors.blueAccent,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(0.8, 0.0),
                colors: <Color>[Colors.blueAccent, Colors.purpleAccent])),
      ),
    );
  }
}
