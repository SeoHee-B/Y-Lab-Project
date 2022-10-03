import 'package:flutter/material.dart';

class reserve_check_list extends StatefulWidget {
  const reserve_check_list({Key? key}) : super(key: key);

  @override
  State<reserve_check_list> createState() => _reserve_check_listState();
}

class _reserve_check_listState extends State<reserve_check_list> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [Container()],
        ),
      ),
    );
  }
}
