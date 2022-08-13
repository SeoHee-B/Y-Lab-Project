import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ylab_demodemo/resusable_widget/reusable_widget.dart';
import 'package:ylab_demodemo/screens/reservation.dart';
import 'package:ylab_demodemo/utils/color_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

var now = DateTime.now();

class reservation_page extends StatefulWidget {
  const reservation_page({Key? key}) : super(key: key);

  @override
  State<reservation_page> createState() => _reservation_pageState();
}

class _reservation_pageState extends State<reservation_page> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        ///위에 앱 상태바 투명하게 만들기
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(
            size: 30,
            color: Colors.black,
          ),
        ),
        //메인 화면 구현
        body: Stack(
          children: [
            //배경화면
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: hexStringToColor("F3F6F9"),
              ),
            ),
            SafeArea(
                child: SingleChildScrollView(
              child: Column(children: [
                //간격띄우기
                SizedBox(
                  height: 75,
                ),
                //제품제작실습실 글씨
                Text(
                  '제품제작실습실 예약하기',
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontSize: 22,
                  ),
                ),
                //간격띄우기
                SizedBox(
                  height: 10,
                ),
                //글씨밑 실선
                Container(
                    width: 287, height: 1, color: hexStringToColor("002753")),
                //간격띄우기
                SizedBox(
                  height: 66,
                ),
                // 버튼안내글
                Text(
                  '예약 날짜 선택하기',
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
                //간격띄우기
                SizedBox(width: 20),
                //날짜 선택 창
                ElevatedButton(
                  onPressed: () async {
                    DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: now.add(const Duration(days: 2)),
                        firstDate: now.add(const Duration(days: 2)),
                        lastDate: now.add(const Duration(days: 23)));

                    //cancel 했을때 Null 값 변환
                    if (newDate == null) return;
                    // ok 했을때 Date값 업데이트
                    setState(() => date = newDate);
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return hexStringToColor("003876");
                        }
                        return hexStringToColor("336091");
                      }),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)))),
                  child: Text('${date.year}/${date.month}/${date.day}',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Nanum Gothic',
                          fontSize: 20)),
                ),
                //간격띄우기
                SizedBox(width: 66),
                //시간선택 버튼
              ]),
            ))
          ],
        ));
  }
}
