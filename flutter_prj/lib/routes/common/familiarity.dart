import 'package:flutter/material.dart';

Widget familiarityWidget(BuildContext context, num familiarity, Function(int) onSelected) =>
  PopupMenuButton<int> (
    padding: EdgeInsets.all(5), // 菜单项的内边距
    offset: Offset(0, 0),       // 控制菜单弹出的位置()
    initialValue: familiarity,
    child: Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$familiarity',
            style: const TextStyle(fontSize: 17, color: Colors.blueAccent,)
          ),
          TextSpan(
            text: ' 熟悉度',
            style: TextStyle(fontSize: 14, color: Colors.black45)
          ),
        ]
      )
    ),
    itemBuilder: (context) =>
      [0, 1, 2, 3, 4, 5].map((e) =>
        PopupMenuItem<int>(
          value: e,
          textStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),        // 文本样式
          child: Text('$e', style: const TextStyle(fontSize: 17, color: Colors.blue) ),    // 子控件
        )
      ).toList(),
    onSelected: onSelected
  );
