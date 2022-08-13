import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ylab_demodemo/screens/reservation_check.dart';
import 'package:ylab_demodemo/screens/reservation_scroll.dart';
import 'package:ylab_demodemo/screens/test_start.dart';
import 'package:ylab_demodemo/screens/video.dart';
import 'package:ylab_demodemo/utils/color_utils.dart';

Image logoWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 262,
  );
}

Image iconWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    height: 83,
  );
}

Image personal_detail_Widget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    height: 29,
  );
}

TextField resuableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white.withOpacity(0.8)),
    decoration: InputDecoration(
      isDense: true,
      contentPadding: EdgeInsets.all(0),
      prefixIcon: Padding(
        padding: EdgeInsets.only(left: 20, right: 17),
        child: Icon(
          icon,
          size: 23,
          color: Colors.white70,
        ),
      ),
      labelText: text,
      labelStyle: TextStyle(fontSize: 15, color: Colors.white.withOpacity(0.8)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: hexStringToColor("809CBB"),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(
            style: BorderStyle.none,
            width: 0,
          )),
    ),
    keyboardType:
        isPasswordType ? TextInputType.visiblePassword : TextInputType.text,
  );
}

class login_painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint_1 = Paint()..color = hexStringToColor("1A4C84");
    var paint_2 = Paint()..color = hexStringToColor("809CBB");
    var paint_3 = Paint()..color = hexStringToColor("D8DFE7");

    canvas.drawCircle(Offset(-10, 30), 197, paint_2);
    canvas.drawCircle(Offset(350, 92), 212, paint_1);
    canvas.drawCircle(Offset(104.5, 796.5), 387.5, paint_3);
  }

  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class signUp_painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint_1 = Paint()..color = hexStringToColor("1A4C84");
    var paint_2 = Paint()..color = hexStringToColor("809CBB");
    var paint_3 = Paint()..color = hexStringToColor("D8DFE7");
    canvas.drawCircle(Offset(319, 672), 212, paint_1);
    canvas.drawCircle(Offset(49.5, 183.5), 387.5, paint_3);
    canvas.drawCircle(Offset(23, 844), 197, paint_2);
  }

  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

Container signIn_signUp_Button(
    BuildContext context, bool isLogin, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 45,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        isLogin ? 'LOG IN' : 'SIGN UP',
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return hexStringToColor("003876");
            }
            return hexStringToColor("336091");
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    ),
  );
}

//메인 화면 중 옆으로 넘기는 메뉴 구현을 위한 자료
var colors = [
  [
    Color.fromRGBO(0, 56, 118, 1),
    Color.fromRGBO(102, 136, 173, 0.91),
    Color.fromRGBO(165, 187, 212, 0.52)
  ],
  [
    Color.fromRGBO(9, 39, 73, 1),
    Color.fromRGBO(70, 94, 121, 1),
    Color.fromRGBO(92, 100, 102, 0.18)
  ],
  [
    Color.fromRGBO(0, 56, 118, 1),
    Color.fromRGBO(102, 136, 173, 0.91),
    Color.fromRGBO(165, 187, 212, 0.52)
  ],
  [
    Color.fromRGBO(9, 39, 73, 1),
    Color.fromRGBO(70, 94, 121, 1),
    Color.fromRGBO(92, 100, 102, 0.18)
  ]
];

//메인 화면 중 옆으로 넘기는 메뉴 구현을 위한 자료
var icons = [
  iconWidget("assets/images/calendar.png"),
  iconWidget("assets/images/reserved_check.png"),
  iconWidget("assets/images/education_video.png"),
  iconWidget("assets/images/test_apply.png"),
];

//메인 화면 중 옆으로 넘기는 메뉴 구현을 위한 자료
var button_text_main = [
  Text(
    "예약하기",
    style: TextStyle(
      fontFamily: 'Nanum Gothic bold',
      fontSize: 24,
      color: Colors.white,
    ),
  ),
  Text(
    "예약확인",
    style: TextStyle(
      fontFamily: 'Nanum Gothic bold',
      fontSize: 24,
      color: Colors.white,
    ),
  ),
  Text(
    "교육영상시청",
    style: TextStyle(
      fontFamily: 'Nanum Gothic bold',
      fontSize: 24,
      color: Colors.white,
    ),
  ),
  Text(
    "자격시험응시",
    style: TextStyle(
      fontFamily: 'Nanum Gothic bold',
      fontSize: 24,
      color: Colors.white,
    ),
  ),
];

var button_text_sub = [
  Text(
    "- 3층 실습실 \n- 4층 실습실 \n- 인간공학실습실",
    style: TextStyle(
      fontFamily: 'Nanum Gothic bold',
      fontSize: 13,
      letterSpacing: 1,
      height: 1.6,
      color: Colors.white,
    ),
  ),
  Text(
    "- 예약 내역 확인 \n- 승인 여부 확인 \n",
    style: TextStyle(
      fontFamily: 'Nanum Gothic bold',
      fontSize: 13,
      letterSpacing: 1,
      height: 1.6,
      color: Colors.white,
    ),
  ),
  Text(
    "자격시험을 응시하기 전에\n    교육영상을 충분히 \n   학습하고 응시하세요.",
    style: TextStyle(
      fontFamily: 'Nanum Gothic bold',
      fontSize: 13,
      letterSpacing: 1,
      height: 1.6,
      color: Colors.white,
    ),
  ),
  Text(
    "시험 결과에 따라서\n 예약을 할 수 있는\n자격이 부여됩니다.",
    style: TextStyle(
      fontFamily: 'Nanum Gothic bold',
      fontSize: 13,
      letterSpacing: 1,
      height: 1.6,
      color: Colors.white,
    ),
  ),
];

//메인 화면 중 옆으로 넘기는 메뉴 구현을 위한 자료
var screen = [
  reservation_scroll(),
  reservation_check_page(),
  video_page(),
  test_start_page()
];
