import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_answer_questions/muyu/count_panel.dart';
import 'package:flutter_answer_questions/muyu/muyu_assets_image.dart';

class MuyuPage extends StatefulWidget {
  const MuyuPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MuyuPageState();
  }
}

class _MuyuPageState extends State<MuyuPage> {

  int _counter = 0;
  final Random random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" muyu"),
        titleTextStyle: const TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        actions: [
          IconButton(onPressed: _toHistory, icon: const Icon(Icons.history))
        ],
      ),
      body: Column(
        children: [
          Expanded(child: CountPanel(count: _counter, onTapSwitchAudio: () {}, onTapSwitchImage: () {},)),
          Expanded(child: MuyuAssetsImage(image: 'assets/images/muyu.png',onTap: _onKnock,)),
        ],
      ),
    );
  }
  void _onKnock() {
    print("onTap:$_counter");
    setState(() {
      int addCount = 1 + random.nextInt(3);
      _counter += addCount;
    });
  }

  void _toHistory() {}
}
