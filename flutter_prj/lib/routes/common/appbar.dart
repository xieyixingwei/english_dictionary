import 'package:flutter/material.dart';


Widget appBarOfSet({
  BuildContext context,
  Widget title,
  Function ok
}) =>
  AppBar(
    title: Text('学习计划设置'),
    centerTitle: true,
    leading: TextButton(
      child: Text('取消', style: TextStyle(color: Colors.white),),
      onPressed: () => Navigator.pop(context),
    ),
    actions: [
      TextButton(
        child: Text('确定', style: TextStyle(color: Colors.white),),
        onPressed: ok,
      ),
    ],
  );
