import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ylab_demodemo/resusable_widget/reusable_widget.dart';
import 'package:ylab_demodemo/screens/reservation.dart';
import 'package:ylab_demodemo/screens/reservation_check.dart';
import 'package:ylab_demodemo/screens/signin_screen.dart';
import 'package:ylab_demodemo/screens/test_start.dart';
import 'package:ylab_demodemo/screens/video.dart';
import 'package:ylab_demodemo/utils/color_utils.dart';
import 'package:google_fonts/google_fonts.dart';

var data1;
var user_uid;

class HomeScreen_basic extends StatefulWidget {
  const HomeScreen_basic({Key? key}) : super(key: key);

  @override
  State<HomeScreen_basic> createState() => _HomeScreen_basicState();
}

var testpass;

class _HomeScreen_basicState extends State<HomeScreen_basic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        ///위에 앱 상태바 투명하게 만들기
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(
            size: 25, //change size on your need
            color: Colors.black, //change color on your need
          ),
        ),
        //메뉴탭 구현
        drawer: Drawer(
            backgroundColor: Colors.white,
            child: Padding(
                padding: EdgeInsets.only(left: 30, top: 80),
                child: ListView(
                  children: [
                    //첫번째 요소
                    ListTile(
                      leading: personal_detail_Widget(
                          "assets/images/personal_detail.png"),
                      title: Text("개인정보수정",
                          style: TextStyle(
                              fontFamily: 'Nanum Gothic bold',
                              fontSize: 13,
                              color: Colors.black)),
                    ),
                    Padding(padding: EdgeInsets.only(top: 80)),
                    //두번째 요소
                    ListTile(
                        leading:
                            personal_detail_Widget("assets/images/log_out.png"),
                        title: Text("로그아웃 / Log Out",
                            style: TextStyle(
                                fontFamily: 'Nanum Gothic bold',
                                fontSize: 13,
                                color: Colors.black)),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInScreen()));
                        }),
                    //세번째 요소
                    Padding(padding: EdgeInsets.only(top: 119)),
                    ListTile(
                      title: Text("About Y-LAB",
                          style: TextStyle(
                              fontFamily: 'Nanum Gothic extra bold',
                              fontSize: 13,
                              color: Colors.black)),
                    ),
                  ],
                ))),
        //메인화면구현
        body: Stack(children: [
          //배경화면
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: hexStringToColor("F3F6F9"),
            ),
          ),
          //내부 요소 시작
          SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
              //패딩
              SizedBox(
                height: 66.5,
              ),
              //메인 로고
              Text(
                "Reservation System",
                style: GoogleFonts.notoSans(
                  fontWeight: FontWeight.bold,
                  color: hexStringToColor("002753"),
                  fontSize: 24,
                ),
              ),
              //패딩
              SizedBox(
                height: 11,
              ),
              //로고 밑 실선
              Container(
                  width: 287, height: 1, color: hexStringToColor("002753")),
              //패딩
              SizedBox(
                height: 67,
              ),
              //밑의 옆으로 넘기는 메뉴들 구현
              Container(
                padding: const EdgeInsets.only(left: 10),
                width: double.maxFinite,
                height: 317,
                child: ListView.builder(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          child: GestureDetector(
                              onTap: () async {
                                //test pass 여부 확인해서 data1값에 넣음
                                User? user =
                                    await FirebaseAuth.instance.currentUser;
                                user_uid = user!.uid;
                                String title = "";
                                var collection = FirebaseFirestore.instance
                                    .collection('users');
                                collection
                                    .doc(user_uid)
                                    .collection("data")
                                    .doc("data")
                                    .snapshots()
                                    .listen((docSnapshot) {
                                  if (docSnapshot.exists) {
                                    Map<String, dynamic> data =
                                        docSnapshot.data()!;

                                    // You can then retrieve the value from the Map like this:
                                    data1 = data['testpass'];
                                  }
                                });
                                //test pass여부에 따라 메뉴 접근 여부 결정 및 toast 메세지 띄우기
                                if (index == 0 && data1 == true) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => screen[index],
                                  ));
                                } else if (index == 1 && data1 == true) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => screen[index],
                                  ));
                                } else if (index == 2) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => screen[index],
                                  ));
                                } else if (index == 3) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => screen[index],
                                  ));
                                } else {
                                  print("not move");
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                      "자격 시험에서 합격하시면 실습실을 예약할 수 있습니다. ",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Nanum Gothic bold',
                                          color: Colors.black),
                                    ),
                                    backgroundColor:
                                        Color.fromARGB(30, 0, 0, 0),
                                    elevation: 0,
                                    duration: Duration(seconds: 2),
                                  ));
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 20),
                                width: 200,
                                height: 317,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: <Color>[
                                          colors[index][0],
                                          colors[index][1],
                                          colors[index][2]
                                        ])),
                                child: Column(children: [
                                  SizedBox(
                                    height: 45,
                                  ),
                                  icons[index],
                                  SizedBox(
                                    height: 30,
                                  ),
                                  button_text_main[index],
                                  SizedBox(
                                    height: 16,
                                  ),
                                  button_text_sub[index],
                                ]),
                              )));
                    }),
              )
            ])),
          )
        ]));
  }
}
