import 'package:flutter/material.dart';

class MuyuPage extends StatefulWidget {
  const MuyuPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MuyuPageState();
  }
}

class _MuyuPageState extends State<MuyuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" muyu"),
        titleTextStyle: const TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        actions: [
          IconButton(onPressed: _toHistory,icon: const Icon(Icons.history))
        ],
      ),
      body: Column(
        children: [
          Expanded(child: _buildTopContent()),
          // Expanded(child: _buildImage()),
        ],
      ),
    );
  }

  Widget _buildTopContent() {
    return const Stack(
      children: [
        Center(
          child: Text(
            '功德数：0',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  void _toHistory() {}

}