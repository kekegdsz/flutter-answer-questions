import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GuessAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onCheck;
  final TextEditingController controller;

  const GuessAppBar({Key? key, required this.onCheck, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const Icon(
        Icons.menu,
        color: Colors.black,
      ), // 左侧
      actions: [
        // 右侧列表
        IconButton(
            splashRadius: 20,
            onPressed: onCheck,
            icon: const Icon(
              Icons.run_circle_outlined,
              color: Colors.blue,
            ))
      ],
      title: TextField(
        controller: controller,
        keyboardType: TextInputType.number, //键盘类型: 数字
        decoration: const InputDecoration(
            //装饰
            filled: true,
            //填充
            fillColor: Color(0xffF3F6F9),
            //填充颜色
            constraints: BoxConstraints(maxHeight: 35),
            //约束信息
            border: UnderlineInputBorder(
              //边线信息
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            hintText: "输入 0~99 数字",
            //提示字
            hintStyle: TextStyle(fontSize: 14) //提示字样式
            ),
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
