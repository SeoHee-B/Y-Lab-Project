import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:ylab_demodemo/utils/color_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:ylab_demodemo/resusable_widget/reusable_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ylab_demodemo/screens/reservation_scroll.dart';
import 'package:ylab_demodemo/utils/color_utils.dart';

class reservation_check_page extends StatefulWidget {
  const reservation_check_page({Key? key}) : super(key: key);

  @override
  State<reservation_check_page> createState() => _reservation_check_pageState();
}

var user_id;
List<String> reserve_text = [
  'a',
  'b',
  'c',
  'a',
  'b',
  'c',
  'a',
  'b',
  'c',
  'a',
  'b',
  'c'
];
List<String> reserve_colors = [
  '000000',
  '000001',
  '000002',
  '000000',
  '000001',
  '000002',
  '000000',
  '000001',
  '000002',
  '000000',
  '000001',
  '000002',
];

class _reservation_check_pageState extends State<reservation_check_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///위에 앱 상태바 투명하게 만들기
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(size: 30, color: Colors.black),
      ),
      //메인화면구현
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          // 배경화면
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(color: hexStringToColor("F3F6F9")),
          ),

          //화면구성시작
          SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(children: [
                //간격띄우기
                SizedBox(
                  height: 20,
                ),
                //화면 타이틀 글씨
                Text(
                  "Reservation Check",
                  style: GoogleFonts.notoSans(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20),
                ),
                //간격띄우기
                SizedBox(
                  height: 7,
                ),
                //로고 밑 실선
                Container(
                  width: 222,
                  height: 1,
                  color: Colors.black,
                ),
                //간격띄우기
                SizedBox(
                  height: 102,
                ),
                //예약내용 리스트에 추가하는 버튼
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 7, 47, 79),
                      onPrimary: Colors.white,
                    ),
                    onPressed: () async {
                      if (reserve_text.isNotEmpty) {
                        reserve_text.clear();
                      }
                      User? user = await FirebaseAuth.instance.currentUser;
                      user_id = user!.uid;
                      Future<QuerySnapshot<Map<String, dynamic>>>
                          querySnapshot = FirebaseFirestore.instance
                              .collection('user')
                              .doc('KgujCy7r4zMkZg4W0G2aesc8zdh1')
                              .collection('reservation')
                              .doc('false')
                              .collection('collectionPath')
                              .get();
                      print('$querySnapshot');
                    },
                    child: Text("Get Reserve Data")),
                //간격띄우기
                SizedBox(
                  height: 40,
                ),
                ////예약 내역 출력
                Container(
                  padding: const EdgeInsets.only(left: 18),
                  width: MediaQuery.of(context).size.width,
                  height: (reserve_text.length) * 35,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: reserve_text.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                        color: Color.fromARGB(255, 106, 132, 154),
                        child: Center(child: Text('${reserve_text[index]}')),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
                )
              ]),
            ),
          )
        ],
      ),
    );
  }
}
