import 'dart:math';

import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_answer_questions/muyu/animate_text.dart';
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
  int _cruValue = 0;

  final Random random = Random();
  AudioPool? pool;

  @override
  void initState() {
    super.initState();
    _initAudioPool();
  }

  void _initAudioPool() async {
    pool = await FlameAudio.createPool(
      'muyu_1.mp3',
      maxPlayers: 4,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("muyu"),
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
          Expanded(
              child: CountPanel(
            count: _counter,
            onTapSwitchAudio: () {},
            onTapSwitchImage: () {},
          )),
          Expanded(
              child: Stack(
            alignment: Alignment.topCenter,
            children: [
              MuyuAssetsImage(
                image: 'assets/images/muyu.png',
                onTap: _onKnock,
              ),
              if (_cruValue != 0) AnimateText(text: '功德+$_cruValue')
            ],
          )),
        ],
      ),
    );
  }

  void _onKnock() {
    print("onTap:$_counter");

    pool?.start();

    setState(() {
      _cruValue = 1 + random.nextInt(3);
      _counter += _cruValue;
    });
  }

  void _toHistory() {}
}
