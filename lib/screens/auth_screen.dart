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
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      width: deviceWidth,
      height: deviceHeight,
      child: Center(
        child: Container(
          width: deviceWidth,
          height: deviceHeight * 0.8,
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
                    child: isLogin ? LogInScreen() : SignUpScreen(),
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
    );
  }
}
