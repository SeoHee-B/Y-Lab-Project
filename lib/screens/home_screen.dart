import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:ylab_demodemo/screens/signin_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text("LOG OUT"),
        onPressed: () {
          FirebaseAuth.instance.signOut().then((value) {
            print("Signed Out");
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignInScreen()));
          });
        },
      ),
    );
  }
}
