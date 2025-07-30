import 'dart:math';

import 'package:flutter/material.dart';

import 'guess_app_bar.dart';

class GuessPage extends StatefulWidget {
  const GuessPage({super.key, required this.title});

  final String title;

  @override
  State<GuessPage> createState() => _GuessPageState();
}

class _GuessPageState extends State<GuessPage> {
  int _value = 0;
  bool _guessing = false;
  bool? _isBig;

  Random random = Random();

  void _generateRandomValue() {
    setState(() {
      _guessing = true; // 点击按钮时，表示游戏开始
      _value = random.nextInt(100);
    });
  }
  final TextEditingController _guessCtrl = TextEditingController();
  void _onTap(){
    print("=====Check:目标数值:$_value=====${_guessCtrl.text}============");

    int guessValue = int.parse(_guessCtrl.text);
    // 游戏未开始，或者输入非整数，无视
    if (!_guessing || guessValue == null) return;
    // 输入数值与目标数值比较

    //猜对了
    if (guessValue == _value) {
      setState(() {
        _isBig = null;
        _guessing = false;
      });
      return;
    }

    // 猜错了
    setState(() {
      _isBig = guessValue > _value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:GuessAppBar(
        controller: _guessCtrl,
        onCheck: _onTap,
      ),
      body: Stack(children: [
        if(_isBig!=null)
        Column(
          children: [
            if(_isBig!)
            _buildResultNotice(Colors.redAccent, '大了'),
            const Spacer(),
            if(!_isBig!)
            _buildResultNotice(Colors.blueAccent, '小了'),
          ],
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                '点击生成随机数值',
              ),
              Text(
                _guessing?'**':'$_value',
                style: const TextStyle(fontSize: 68,fontWeight: FontWeight.bold),
              ),
            ],
          ),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _guessing ? null : _generateRandomValue,
        backgroundColor: _guessing ? Colors.grey : Colors.blue,
        tooltip: 'Increment',
        child: const Icon(Icons.generating_tokens_outlined),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  dispose(){
    _guessCtrl.dispose();
    super.dispose();
  }

  Widget _buildResultNotice(Color color, String info) {
    return Expanded(
        child: Container(
      alignment: Alignment.center,
      color: color,
      child: Text(
        info,
        style: const TextStyle(
            fontSize: 54, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ));
  }
}
