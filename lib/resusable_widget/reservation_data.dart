import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ylab_demodemo/screens/reservation_check.dart';
import 'package:ylab_demodemo/screens/reservation_scroll.dart';
import 'package:ylab_demodemo/screens/test_start.dart';
import 'package:ylab_demodemo/screens/video.dart';
import 'package:ylab_demodemo/utils/color_utils.dart';

var uid_1;
var student_num_1;
var name_1;
var phone_1;
var tool_1;

// 실습실 예약 화면에서의 첫번쨰 horizontal scroll 선택 자료

// 실습실 로고 & 글씨
var lab_icon = [
  Text(
    "357",
    style: GoogleFonts.oxanium(
        fontWeight: FontWeight.bold,
        fontSize: 40,
        color: hexStringToColor("003876")),
  ),
  Text(
    "457",
    style: GoogleFonts.oxanium(
        fontWeight: FontWeight.bold,
        fontSize: 40,
        color: hexStringToColor("003876")),
  ),
  Text(
    "359",
    style: GoogleFonts.oxanium(
        fontWeight: FontWeight.bold,
        fontSize: 40,
        color: hexStringToColor("003876")),
  ),
];

var lab_name = [
  Text("제품제작실습실",
      style: TextStyle(
          fontFamily: 'NotoSansKR Medium',
          fontSize: 16,
          color: hexStringToColor("233F5E"))),
  Text("모형제작실습실",
      style: TextStyle(
          fontFamily: 'NotoSansKR Medium',
          fontSize: 16,
          color: hexStringToColor("233F5E"))),
  Text("인간공학실습실",
      style: TextStyle(
          fontFamily: 'NotoSansKR Medium',
          fontSize: 16,
          color: hexStringToColor("233F5E"))),
];
//실습실 버튼 색깔
var lab_color = [
  Color.fromRGBO(216, 228, 240, 1),
  Color.fromRGBO(255, 255, 255, 1),
  Color.fromRGBO(216, 228, 240, 1)
];

//// 실습실 예약 화면에서의 두번쨰 horizontal scroll 선택 자료
/// 장비버튼 색깔
var tool_color = [
  Color.fromRGBO(0, 56, 118, 1),
  Color.fromRGBO(255, 255, 255, 1),
  Color.fromRGBO(0, 56, 118, 1),
  Color.fromRGBO(255, 255, 255, 1),
];

var tool_text_color = [
  Color.fromRGBO(255, 255, 255, 1),
  Color.fromRGBO(0, 56, 118, 1),
  Color.fromRGBO(255, 255, 255, 1),
  Color.fromRGBO(0, 56, 118, 1),
];

///
///이중배열 장비
var tools = [
  // 357 사용가능 장비
  ["열선커터기", "샌딩 부스", "스프레이부스", "기기사용없음"],
  // 457 사용가능 장비
  ["드릴프레스", "띠톱(밴드쏘)", "진공성형기", "기기사용없음"],
  // 359 사용가능 장비
  ["촬영용 조명", "공유용 모니터", "인간공학실습도구", "기기사용없음"]
];

var date_color = [
  Color.fromRGBO(126, 169, 191, 1),
  Color.fromRGBO(255, 255, 255, 1),
  Color.fromRGBO(126, 169, 191, 1),
  Color.fromRGBO(255, 255, 255, 1),
  Color.fromRGBO(126, 169, 191, 1),
  Color.fromRGBO(255, 255, 255, 1),
  Color.fromRGBO(126, 169, 191, 1),
  Color.fromRGBO(255, 255, 255, 1),
  Color.fromRGBO(126, 169, 191, 1),
  Color.fromRGBO(255, 255, 255, 1),
  Color.fromRGBO(126, 169, 191, 1),
  Color.fromRGBO(255, 255, 255, 1),
  Color.fromRGBO(126, 169, 191, 1),
  Color.fromRGBO(255, 255, 255, 1),
  Color.fromRGBO(126, 169, 191, 1),
  Color.fromRGBO(255, 255, 255, 1),
  Color.fromRGBO(126, 169, 191, 1),
  Color.fromRGBO(255, 255, 255, 1),
  Color.fromRGBO(126, 169, 191, 1),
  Color.fromRGBO(255, 255, 255, 1),
  Color.fromRGBO(126, 169, 191, 1),
];

var date_text_color = [
  Color.fromRGBO(255, 255, 255, 1),
  Color.fromRGBO(126, 169, 191, 1),
  Color.fromRGBO(255, 255, 255, 1),
  Color.fromRGBO(126, 169, 191, 1),
  Color.fromRGBO(255, 255, 255, 1),
  Color.fromRGBO(126, 169, 191, 1),
  Color.fromRGBO(255, 255, 255, 1),
  Color.fromRGBO(126, 169, 191, 1),
  Color.fromRGBO(255, 255, 255, 1),
  Color.fromRGBO(126, 169, 191, 1),
  Color.fromRGBO(255, 255, 255, 1),
  Color.fromRGBO(126, 169, 191, 1),
  Color.fromRGBO(255, 255, 255, 1),
  Color.fromRGBO(126, 169, 191, 1),
  Color.fromRGBO(255, 255, 255, 1),
  Color.fromRGBO(126, 169, 191, 1),
  Color.fromRGBO(255, 255, 255, 1),
  Color.fromRGBO(126, 169, 191, 1),
  Color.fromRGBO(255, 255, 255, 1),
  Color.fromRGBO(126, 169, 191, 1),
  Color.fromRGBO(255, 255, 255, 1),
];

var time = DateTime.now();
var date = List<int>.filled(21, 0, growable: true);
var month = List<int>.filled(21, 0, growable: true);

var time_data = [
  time.add(Duration(days: 2)),
  time.add(Duration(days: 3)),
  time.add(Duration(days: 4)),
  time.add(Duration(days: 5)),
  time.add(Duration(days: 6)),
  time.add(Duration(days: 7)),
  time.add(Duration(days: 8)),
  time.add(Duration(days: 9)),
  time.add(Duration(days: 10)),
  time.add(Duration(days: 11)),
  time.add(Duration(days: 12)),
  time.add(Duration(days: 13)),
  time.add(Duration(days: 14)),
  time.add(Duration(days: 15)),
  time.add(Duration(days: 16)),
  time.add(Duration(days: 17)),
  time.add(Duration(days: 18)),
  time.add(Duration(days: 19)),
  time.add(Duration(days: 20)),
  time.add(Duration(days: 21)),
  time.add(Duration(days: 22)),
];

var month_data = [
  time_data[0].month,
  time_data[1].month,
  time_data[2].month,
  time_data[3].month,
  time_data[4].month,
  time_data[5].month,
  time_data[6].month,
  time_data[7].month,
  time_data[8].month,
  time_data[9].month,
  time_data[10].month,
  time_data[11].month,
  time_data[12].month,
  time_data[13].month,
  time_data[14].month,
  time_data[15].month,
  time_data[16].month,
  time_data[17].month,
  time_data[18].month,
  time_data[19].month,
  time_data[20].month,
];

var date_data = [
  time_data[0].day,
  time_data[1].day,
  time_data[2].day,
  time_data[3].day,
  time_data[4].day,
  time_data[5].day,
  time_data[6].day,
  time_data[7].day,
  time_data[8].day,
  time_data[9].day,
  time_data[10].day,
  time_data[11].day,
  time_data[12].day,
  time_data[13].day,
  time_data[14].day,
  time_data[15].day,
  time_data[16].day,
  time_data[17].day,
  time_data[18].day,
  time_data[19].day,
  time_data[20].day,
];

var timetable = [
  "9 : 00",
  "10 : 00",
  "11 : 00",
  "12 : 00",
  "13 : 00",
  "14 : 00",
  "15 : 00",
  "16 : 00",
  "17 : 00",
  "18 : 00",
  "19 : 00",
  "20 : 00",
];

var time_color = [
  Color.fromRGBO(40, 112, 148, 1),
  Color.fromRGBO(255, 255, 255, 1),
  Color.fromRGBO(40, 112, 148, 1),
  Color.fromRGBO(255, 255, 255, 1),
  Color.fromRGBO(40, 112, 148, 1),
  Color.fromRGBO(255, 255, 255, 1),
  Color.fromRGBO(40, 112, 148, 1),
  Color.fromRGBO(255, 255, 255, 1),
  Color.fromRGBO(40, 112, 148, 1),
  Color.fromRGBO(255, 255, 255, 1),
  Color.fromRGBO(40, 112, 148, 1),
  Color.fromRGBO(255, 255, 255, 1),
];

var time_text_color = [
  Color.fromRGBO(255, 255, 255, 1),
  Color.fromRGBO(40, 112, 148, 1),
  Color.fromRGBO(255, 255, 255, 1),
  Color.fromRGBO(40, 112, 148, 1),
  Color.fromRGBO(255, 255, 255, 1),
  Color.fromRGBO(40, 112, 148, 1),
  Color.fromRGBO(255, 255, 255, 1),
  Color.fromRGBO(40, 112, 148, 1),
  Color.fromRGBO(255, 255, 255, 1),
  Color.fromRGBO(40, 112, 148, 1),
  Color.fromRGBO(255, 255, 255, 1),
  Color.fromRGBO(40, 112, 148, 1),
];

Container submit_Button(BuildContext context, Function onTap) {
  return Container(
    width: 355,
    height: 45,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        "제출하기",
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
          fontFamily: 'NotoSansKR Medium',
        ),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Color.fromARGB(255, 31, 59, 85);
            }
            return Color.fromRGBO(24, 48, 71, 1);
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))),
    ),
  );
}

void makedata_false(int lab_numnum, int month, int date, int time, String uid,
    String studentnum, String name, String phonenum, String tool) {
  //새로운 false데이터 생성
  FirebaseFirestore.instance
      .collection('booking')
      .doc('$lab_numnum')
      .collection('$month')
      .doc('$date')
      .collection('$time')
      .doc('false')
      .set({
    "uid": uid,
    "studentnumber": studentnum,
    "phonenumber": phonenum,
    "name": name,
    "tool": tool
  });

  //신청자 개인정보에 false데이터 생성
  FirebaseFirestore.instance
      .collection('users')
      .doc('$uid')
      .collection('reservation')
      .doc('false')
      .collection('$month')
      .doc('$date')
      .collection('$time')
      .doc('$lab_numnum')
      .set({"tool": tool});
}

void makedata_false_other(
    int lab_numnum, int month, int date, int time, String uid, String tool) {
  //새로운 false데이터 생성
  FirebaseFirestore.instance
      .collection('booking')
      .doc('$lab_numnum')
      .collection('$month')
      .doc('$date')
      .collection('$time')
      .doc('$time')
      .set({
    "status": false,
    "date": "$month/$date",
    "time": time,
    "tool": tool,
    "students": [uid],
  });
  print('false step 1');

  //신청자 개인정보에 false데이터 생성
  FirebaseFirestore.instance
      .collection('users')
      .doc('$uid')
      .collection('reservation')
      .doc('$month')
      .collection('$date')
      .doc('$time')
      .set({
    "status": false,
    "date": "$month/$date",
    "time": time,
    "tool": tool,
    "lab num": lab_numnum
  });

  print('false step 2');
}

void makedata_false_to_true_other(int lab_numnum, int month, int date, int time,
    String uid, String tool) async {
  final dataRef = FirebaseFirestore.instance
      .collection('booking')
      .doc('$lab_numnum')
      .collection('$month')
      .doc('$date')
      .collection('$time')
      .doc('$time');

  //false데이터에 있는 학생 데이터 받아오기
  //학생들 uid 모으는 list선언
  List<dynamic> pastStudents = [];
  //list에 학생들 데이터 넣기
  dataRef.snapshots().listen((docSnapshot) {
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;

      // You can then retrieve the value from the Map like this:
      pastStudents.add(data['students']);
      print(pastStudents);
    }
  });

  print('falsetotrue step 1');

  if (pastStudents.contains(uid)) {
    print('예약한 기록이 있습니다.');
    return_snackbar = '예약한 기록이 있습니다.';
  } else {
    print(pastStudents);
    //기존 데이터 true로 변경
    dataRef.update({"status": true});

    //false데이터에 있는 학생 개인정보 true로 변경
    pastStudents.forEach((element) {
      FirebaseFirestore.instance
          .collection('users')
          .doc('$element')
          .collection('reservation')
          .doc('$month')
          .collection('$date')
          .doc('$time')
          .set({"status": true});
    });
    print('falsetotrue step 2');

    // 학생 데이터 추가
    dataRef.update({
      "student": FieldValue.arrayUnion([uid])
    });
    print('falsetotrue step 3');

    //신청자 개인정보에 true데이터 생성
    FirebaseFirestore.instance
        .collection('users')
        .doc('$uid')
        .collection('reservation')
        .doc('$month')
        .collection('$date')
        .doc('$time')
        .set({
      "status": true,
      "date": "$month/$date",
      "time": time,
      "tool": tool,
      "lab num": lab_numnum
    });
    print('falsetotrue step 4');
  }
}

void makedata_false_to_true(
    int lab_numnum,
    int month,
    int date,
    int time,
    String uid,
    String studentnum,
    String name,
    String phonenum,
    String tool) async {
  //기존 false 데이터에 들어있는 내용 저장
  var collection = FirebaseFirestore.instance
      .collection('booking')
      .doc('$lab_numnum')
      .collection('$month')
      .doc('$date')
      .collection('$time');

  final datas = await collection.doc('fasle').get();
  var uidid = datas.data().toString().contains('uid') ? datas.get('uid') : '';
  print(uidid);

  collection.doc('false').get().then(
    (value) {
      uidid = value['uid'];
      //true데이터에 기존 false데이터 입력
      FirebaseFirestore.instance
          .collection('booking')
          .doc('$lab_numnum')
          .collection('$month')
          .doc('$date')
          .collection('$time')
          .doc('true')
          .collection('$uidid}')
          .doc('data')
          .set({
        "uid": value['uid'],
        "studentnumber": value['studentnumber'],
        "phonenumber": value['phonenumber'],
        "name": value['name'],
        "tool": value['tool']
      });

      //기존 false신청자 개인정보로 가서 true데이터 생성
      FirebaseFirestore.instance
          .collection('users')
          .doc('${value['uid']}')
          .collection('reservation')
          .doc('true')
          .collection('$month')
          .doc('$date')
          .collection('$time')
          .doc('$lab_numnum')
          .set({"tool": value['tool']});
    },
  );
  ////기존 false데이터 삭제
  FirebaseFirestore.instance
      .collection('booking')
      .doc('$lab_numnum')
      .collection('$month')
      .doc('$date')
      .collection('$time')
      .doc('false')
      .delete();

  //true데이터에 새로운 신청자 추가
  FirebaseFirestore.instance
      .collection('booking')
      .doc('$lab_numnum')
      .collection('$month')
      .doc('$date')
      .collection('$time')
      .doc('true')
      .collection('$uidid')
      .doc('data')
      .set({
    "uid": uid,
    "studentnumber": studentnum,
    "phonenumber": phonenum,
    "name": name,
    "tool": tool
  });

  //신청자 개인정보에 true 데이터 생성
  FirebaseFirestore.instance
      .collection('users')
      .doc('$uidid')
      .collection('reservation')
      .doc('true')
      .collection('$month')
      .doc('$date')
      .collection('$time')
      .doc('$lab_numnum')
      .set({"tool": tool});
}
