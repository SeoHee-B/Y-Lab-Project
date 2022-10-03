import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ylab_demodemo/screens/reservation_check.dart';
import 'package:ylab_demodemo/screens/reservation_scroll.dart';
import 'package:ylab_demodemo/screens/test_start.dart';
import 'package:ylab_demodemo/screens/video.dart';
import 'package:ylab_demodemo/utils/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

void data_get() async {
  //사용자 uid받기
  if (reserve_text.isNotEmpty) {
    reserve_text.clear();
  }
  User? user = await FirebaseAuth.instance.currentUser;
  var user_id = user!.uid;

  List<int> month = [];
  List<int> date = [];
  List<int> time = [];
  final userRef = FirebaseFirestore.instance
      .collection('user')
      .doc('$user_id')
      .collection('reservation')
      .doc('false');
}
