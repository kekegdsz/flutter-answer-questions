import 'dart:math';

import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_answer_questions/muyu/animate_text.dart';
import 'package:flutter_answer_questions/muyu/count_panel.dart';
import 'package:flutter_answer_questions/muyu/muyu_assets_image.dart';

import 'models/image_option.dart';
import 'options/image_option_panel.dart';

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

  final List<ImageOption> imageOptions = const [
    ImageOption('基础版', 'assets/images/muyu.png', 1, 3),
    ImageOption('尊享版', 'assets/images/muyu2.png', 3, 6),
  ];

  int _activeImageIndex = 0;

  // 激活图像
  String get activeImage => imageOptions[_activeImageIndex].src;

  // 敲击是增加值
  int get knockValue {
    int min = imageOptions[_activeImageIndex].min;
    int max = imageOptions[_activeImageIndex].max;
    return min + random.nextInt(max+1 - min);
  }

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
            onTapSwitchImage: _onTapSwitchImage,
          )),
          Expanded(
              child: Stack(
            alignment: Alignment.topCenter,
            children: [
              MuyuAssetsImage(
                image: activeImage, // 使用激活图像
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
      _cruValue = knockValue; // 使用激活木鱼的值
      _counter += _cruValue;
    });
  }

  void _onTapSwitchImage() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return ImageOptionPanel(
          imageOptions: imageOptions,
          activeIndex: _activeImageIndex,
          onSelect: _onSelectImage,
        );
      },
    );
  }

  void _onSelectImage(int value) {
    Navigator.of(context).pop();
    if (value == _activeImageIndex) return;
    setState(() {
      _activeImageIndex = value;
    });
  }

  void _toHistory() {}
}
