import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ylab_demodemo/resusable_widget/reusable_widget.dart';
import 'package:ylab_demodemo/resusable_widget/reservation_data.dart';
import 'package:ylab_demodemo/screens/reservation.dart';
import 'package:ylab_demodemo/utils/color_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class reservation_scroll extends StatefulWidget {
  const reservation_scroll({Key? key}) : super(key: key);

  @override
  State<reservation_scroll> createState() => _reservation_scrollState();
}

var lab_num = 0;
var student_num;
var user_id;
var phone;
var name;
var lab_numnum = 357;
var tool_numnum = 0;
var tool_name_fin;
List<int> time_selected = [];
List<String> tool_name = [];
Set<String> selected = {};
Set<String> tool = {};
Set<String> selected_time = {};
Set<String> selected_date = {};
int date = 0;
int month = 0;

class _reservation_scrollState extends State<reservation_scroll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///위에 앱 상태바 투명하게 만들기
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          size: 30, //change size on your need
          color: Colors.black, //change color on your need
        ),
      ),
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
        SingleChildScrollView(
          child: Column(children: [
            //간격띄우기
            SizedBox(
              height: 62,
            ),
            //화면 타이틀 글씨
            Text("Reservation Detail",
                style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20)),
            //간격띄우기
            SizedBox(
              height: 7,
            ),
            //로고 밑 실선
            Container(width: 222, height: 1, color: hexStringToColor("002753")),
            //간격띄우기
            SizedBox(
              height: 34,
            ),
            //첫번째 선택지 제목
            Row(
              children: [
                SizedBox(
                  width: 26,
                ),
                Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 56, 118, 1),
                      shape: BoxShape.circle),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "실습실 선택",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'NotoSansKR Bold',
                      fontSize: 16),
                )
              ],
            ),
            //패딩
            SizedBox(
              height: 18,
            ),
            // 첫번째 horizontal scroll
            Container(
              padding: const EdgeInsets.only(left: 18),
              width: double.maxFinite,
              height: 125,
              child: ListView.builder(
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: GestureDetector(
                        onTap: () {
                          switch (index) {
                            case 0:
                              lab_numnum = 357;
                              break;
                            case 1:
                              lab_numnum = 457;
                              break;
                            case 2:
                              lab_numnum = 359;
                              break;
                          }
                          lab_num = index;
                          tool.clear();
                          setState(() {});
                          print("$lab_num");
                          print("$tool");
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          width: 159,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: lab_color[index],
                          ),
                          child: Column(children: [
                            SizedBox(
                              height: 22,
                            ),
                            lab_icon[index],
                            lab_name[index],
                          ]),
                        ),
                      ),
                    );
                  }),
            ),
            //패딩
            SizedBox(
              height: 27,
            ),
            //두번째 선택지 제목
            Row(
              children: [
                SizedBox(
                  width: 26,
                ),
                Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 56, 118, 1),
                      shape: BoxShape.circle),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "사용 장비 선택 (중복선택가능)",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'NotoSansKR Bold',
                      fontSize: 16),
                )
              ],
            ),
            //패딩
            SizedBox(
              height: 18,
            ),
            // 두번째 horizontal scroll
            Container(
              padding: const EdgeInsets.only(left: 18),
              width: double.maxFinite,
              height: 65,
              child: ListView.builder(
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: GestureDetector(
                        onTap: () {
                          if (tool.contains("$index")) {
                            if ((index + 1) % 2 == 1) {
                              tool_color[index] = Color.fromRGBO(0, 56, 118, 1);
                              tool_text_color[index] =
                                  Color.fromRGBO(255, 255, 255, 1);
                            } else {
                              tool_color[index] =
                                  Color.fromRGBO(255, 255, 255, 1);
                              tool_text_color[index] =
                                  Color.fromRGBO(0, 56, 118, 1);
                            }
                            tool.remove("$index");
                            setState(() {});
                          } else {
                            tool_color[index] =
                                Color.fromARGB(255, 116, 116, 116);
                            tool_text_color[index] = Colors.black;
                            tool.add("$index");
                            setState(() {});
                          }
                          print("tool : $tool");
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          width: 157,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: tool_color[index],
                          ),
                          child: Column(children: [
                            SizedBox(
                              height: 22,
                            ),
                            if (lab_num == 0)
                              Text(first_tool[index],
                                  style: TextStyle(
                                      fontFamily: 'NotoSansKR Medium',
                                      fontSize: 16,
                                      color: tool_text_color[index]))
                            else if (lab_num == 1)
                              Text(second_tool[index],
                                  style: TextStyle(
                                      fontFamily: 'NotoSansKR Medium',
                                      fontSize: 16,
                                      color: tool_text_color[index]))
                            else
                              Text(third_tool[index],
                                  style: TextStyle(
                                      fontFamily: 'NotoSansKR Medium',
                                      fontSize: 16,
                                      color: tool_text_color[index]))
                          ]),
                        ),
                      ),
                    );
                  }),
            ),

            //패딩
            SizedBox(
              height: 27,
            ),
            //세번째 선택지 제목
            Row(
              children: [
                SizedBox(
                  width: 26,
                ),
                Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(40, 112, 148, 1),
                      shape: BoxShape.circle),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "예약일 선택",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'NotoSansKR Bold',
                      fontSize: 16),
                )
              ],
            ),
            //패딩
            SizedBox(
              height: 18,
            ),
            // 세번째 horizontal scroll
            Container(
              padding: const EdgeInsets.only(left: 18),
              width: double.maxFinite,
              height: 60,
              child: ListView.builder(
                  itemCount: 21,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: GestureDetector(
                        onTap: () {
                          month = month_data[index];
                          date = date_data[index];
                          if (selected_date.isEmpty) {
                            date_color[index] =
                                Color.fromARGB(255, 116, 116, 116);
                            date_text_color[index] = Colors.black;
                            selected_date.add("$month/$date");
                            setState(() {});
                          } else {
                            if (selected_date.contains("$month/$date")) {
                              if ((index + 1) % 2 == 1) {
                                date_color[index] =
                                    Color.fromRGBO(126, 169, 191, 1);
                                date_text_color[index] =
                                    Color.fromRGBO(255, 255, 255, 1);
                              } else {
                                date_color[index] =
                                    Color.fromRGBO(255, 255, 255, 1);
                                date_text_color[index] =
                                    Color.fromRGBO(126, 169, 191, 1);
                              }
                              selected_date.remove("$month/$date");
                              setState(() {});
                            }
                          }
                          print("date : $selected_date");
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          width: 73,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: date_color[index],
                          ),
                          child: Column(children: [
                            SizedBox(
                              height: 16,
                            ),
                            if ((index + 1) % 2 == 1)
                              Text("${month_data[index]}/${date_data[index]}",
                                  style: TextStyle(
                                      fontFamily: 'NotoSansKR Medium',
                                      fontSize: 18,
                                      color: date_text_color[index]))
                            else
                              Text("${month_data[index]}/${date_data[index]}",
                                  style: TextStyle(
                                      fontFamily: 'NotoSansKR Medium',
                                      fontSize: 18,
                                      color: date_text_color[index])),
                          ]),
                        ),
                      ),
                    );
                  }),
            ),
            //패딩
            SizedBox(
              height: 27,
            ),
            //네번째 선택지 제목
            Row(
              children: [
                SizedBox(
                  width: 26,
                ),
                Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(40, 112, 148, 1),
                      shape: BoxShape.circle),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "사용 시간 선택",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'NotoSansKR Bold',
                      fontSize: 16),
                )
              ],
            ),
            //패딩
            SizedBox(
              height: 18,
            ),

            // 네번째 horizontal scroll
            Container(
              padding: const EdgeInsets.only(left: 18),
              width: double.maxFinite,
              height: 60,
              child: ListView.builder(
                  itemCount: 12,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: GestureDetector(
                        onTap: () {
                          if (selected_time.contains("$index")) {
                            if ((index + 1) % 2 == 1) {
                              time_color[index] =
                                  Color.fromRGBO(40, 112, 148, 1);
                              time_text_color[index] =
                                  Color.fromRGBO(255, 255, 255, 1);
                            } else {
                              time_color[index] =
                                  Color.fromRGBO(255, 255, 255, 1);
                              time_text_color[index] =
                                  Color.fromRGBO(40, 112, 148, 1);
                            }
                            selected_time.remove("$index");
                            setState(() {});
                            print("time : $selected_time");
                          } else {
                            if (selected_time.length < 1) {
                              time_color[index] =
                                  Color.fromARGB(255, 116, 116, 116);
                              time_text_color[index] = Colors.black;

                              selected_time.add("$index");
                              setState(() {});
                            }
                          }
                          print("time : $selected_time");
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          width: 73,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: time_color[index],
                          ),
                          child: Column(children: [
                            SizedBox(
                              height: 16,
                            ),
                            if ((index + 1) % 2 == 1)
                              Text("${timetable[index]}",
                                  style: TextStyle(
                                      fontFamily: 'NotoSansKR Medium',
                                      fontSize: 18,
                                      color: time_text_color[index]))
                            else
                              Text("${timetable[index]}",
                                  style: TextStyle(
                                      fontFamily: 'NotoSansKR Medium',
                                      fontSize: 18,
                                      color: time_text_color[index])),
                          ]),
                        ),
                      ),
                    );
                  }),
            ),
            //패딩
            SizedBox(
              height: 32,
            ),

            //제출하기 버튼

            submit_Button(context, () async {
              //사용장비이름 데이터 넣기

              switch (lab_num) {
                case 0:
                  var i = 0;
                  while (i < 4) {
                    if (tool.contains('$i')) {
                      var name = first_tool[i];
                      tool_name.add(name);
                    }
                    i++;
                  }
                  break;
                case 1:
                  var i = 0;
                  while (i < 4) {
                    if (tool.contains('$i')) {
                      var name = second_tool[i];
                      tool_name.add(name);
                    }
                    i++;
                  }
                  break;
                case 2:
                  var i = 0;
                  while (i < 4) {
                    if (tool.contains('$i')) {
                      var name = third_tool[i];
                      tool_name.add(name);
                    }
                    i++;
                  }
                  break;
              }
              print(lab_numnum);
              print(tool_name);

              //예약일 데이터
              //월 - month, 일 - date
              print(month);
              print(date);

              //시간 데이터 부르기
              selected_time.forEach((element) {
                int temp = int.parse('$element');
                time_selected.add(temp + 9);
              });
              print(time_selected);

              User? user = await FirebaseAuth.instance.currentUser;
              user_id = user!.uid;
              var collection = FirebaseFirestore.instance.collection('users');
              collection
                  .doc(user.uid)
                  .collection('data')
                  .doc('data')
                  .snapshots()
                  .listen((docSnapshot) {
                if (docSnapshot.exists) {
                  Map<String, dynamic> data = docSnapshot.data()!;

                  // You can then retrieve the value from the Map like this:
                  student_num = data['studentnumber'];
                  name = data['name'];
                  phone = data['phonenumber'];
                }
              });
              print(student_num);
              print(name);
              print(phone);

              for (int i = 0; i < tool_name.length; i++) {
                if (i == 0) {
                  tool_name_fin = tool_name[i];
                } else {
                  var gap = ", ";
                  tool_name_fin = tool_name_fin + gap + tool_name[i];
                }
              }
              print("tool name fin = $tool_name_fin");
              var temp_time = time_selected[0];
              print("temptime: $temp_time");
              //예약 데이터 생성하기
              //데이터 있는지 확인
              final booking_state = FirebaseFirestore.instance
                  .collection('booking')
                  .doc("$lab_numnum")
                  .collection("$month")
                  .doc("$date")
                  .collection('$temp_time');
              var book_true = await booking_state.doc('true').get();
              var book_false = await booking_state.doc('false').get();
              if (book_true.exists) {
                // true로 예약이 있을때
                print(1);
              } else {
                //true로 예약이 없을때
                if (book_false.exists) {
                  //true 는 없고, false는 존재
                  //false를  true로 변경해야함
                  print(2);
                  makedata_false_to_true(lab_numnum, month, date, temp_time,
                      user_id, student_num, name, phone, tool_name_fin);
                } else {
                  //true와 false 모두 없음
                  //새로운 false 데이터를 만들어야함.
                  print(3);
                  makedata_false(lab_numnum, month, date, temp_time, user_id,
                      student_num, name, phone, tool_name_fin);
                }
              }
            })
          ]),
        )
      ]),
    );
  }
}
