import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ylab_demodemo/resusable_widget/reusable_widget.dart';
import 'package:ylab_demodemo/screens/home_screen.dart';
import 'package:ylab_demodemo/screens/home_screen_basic.dart';
import 'package:ylab_demodemo/screens/signup_screen.dart';
import 'package:ylab_demodemo/utils/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: CustomPaint(
            size: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height),
            painter: login_painter(),
            child: SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.fromLTRB(41, 187, 39, 0),
              child: Column(
                children: <Widget>[
                  Align(
                      child: logoWidget("assets/images/logo.png"),
                      alignment: Alignment.center),
                  Padding(padding: EdgeInsets.only(top: 46)),
                  Text(
                    "LOG IN",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 56, 118, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  Padding(padding: EdgeInsets.only(top: 38)),
                  Align(
                      child: resuableTextField("Yonsei Mail Address",
                          Icons.mail, false, _emailTextController),
                      alignment: Alignment.center),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Align(
                      child: resuableTextField("Password", Icons.lock, true,
                          _passwordTextController),
                      alignment: Alignment.center),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  signIn_signUp_Button(context, true, () {
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: _emailTextController.text,
                            password: _passwordTextController.text)
                        .then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen_basic()));
                    }).onError((error, stackTrace) {
                      print("Error ${error.toString()}");
                    });
                  }),
                  Padding(padding: EdgeInsets.only(top: 8)),
                  Align(child: signUpOption(), alignment: Alignment.center),
                ],
              ),
            )),
          )),
    );
  }

  Row signUpOption() {
    return Row(
      children: [
        const Text("Don't have an account?",
            textAlign: TextAlign.center,
            style: TextStyle(color: Color.fromRGBO(0, 56, 118, 1))),
        Padding(padding: EdgeInsets.only(left: 78)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(
                color: Color.fromRGBO(0, 56, 118, 1),
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
