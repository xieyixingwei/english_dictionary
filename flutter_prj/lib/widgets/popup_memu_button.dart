import 'package:flutter/material.dart';


popupMenuButton({BuildContext context, List<String> options, Function(String) onSelected}) =>
  PopupMenuButton<String> (
    elevation: 5,               // 设置立体效果的阴影
    padding: EdgeInsets.all(5), // 菜单项的内边距
    offset: Offset(0, 0),       // 控制菜单弹出的位置()
    itemBuilder: (context) =>
      options.map((String e) =>
        PopupMenuItem<String>(
          value: e,
          textStyle: const TextStyle(fontWeight: FontWeight.w600), // 文本样式
          child: Text(e, style: const TextStyle(color: Colors.blue) ),    // 子控件
        )
      ).toList(),
    onSelected: onSelected,              // 选中某个值退出的回调函数,
    // onCanceled: () => print("---- cancel"), // 没有选择任何值的回调函数
  );
