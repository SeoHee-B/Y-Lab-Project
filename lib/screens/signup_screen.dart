import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ylab_demodemo/resusable_widget/reusable_widget.dart';
import 'package:ylab_demodemo/screens/home_screen_basic.dart';
import 'package:ylab_demodemo/screens/signin_screen.dart';
import 'package:ylab_demodemo/screens/signup_screen.dart';
import 'package:ylab_demodemo/utils/color_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var ret;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _phonenumberTextController = TextEditingController();
  TextEditingController _studentumberTextController = TextEditingController();
  TextEditingController _usernameTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: CustomPaint(
            size: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height),
            painter: signUp_painter(),
            child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(40, 109, 40, 0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "SIGN UP",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(0, 56, 118, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        Padding(padding: EdgeInsets.only(top: 40)),
                        resuableTextField("Name", Icons.person, false,
                            _usernameTextController),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        resuableTextField("Phone Number", Icons.phone, false,
                            _phonenumberTextController),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        resuableTextField("Student Number", Icons.school, false,
                            _studentumberTextController),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        resuableTextField("Yonsei Mail Address", Icons.mail,
                            false, _emailTextController),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        resuableTextField("Password", Icons.lock, true,
                            _passwordTextController),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        signIn_signUp_Button(context, false, () {
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: _emailTextController.text,
                                  password: _passwordTextController.text)
                              .then((value) async {
                            print("Created New Account");
                            User? user =
                                await FirebaseAuth.instance.currentUser;

                            await FirebaseFirestore.instance
                                .collection("users")
                                .doc(user!.uid)
                                .collection("data")
                                .doc("data")
                                .set({
                              "uid": user.uid,
                              "email": _emailTextController.text,
                              "name": _usernameTextController.text,
                              "phonenumber": _phonenumberTextController.text,
                              "studentnumber": _studentumberTextController.text,
                              "testpass": false,
                            });

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen_basic()));
                          }).onError((error, stackTrace) {
                            print("Error ${error.toString()}");
                          });
                        })
                      ],
                    ))),
          ),
        ));
  }
}
