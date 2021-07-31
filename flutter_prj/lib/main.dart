import 'package:flutter/material.dart';
import 'package:flutter_prj/markdown/markdown.dart';
import 'package:flutter_prj/routes/routes.dart';
import 'package:flutter_prj/routes/tabs/home.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'common/global.dart';
import 'dictionary_app.dart';


void main() {
  try {
    Global.init().then((e) => runApp(MyApp()));
  } catch (e) {
    print('--- Exception: $e');
  }
}


class MyApp extends StatelessWidget {
  final _appTheme = ThemeData.light(); // 定义APP的全局主题

/*
  final _providers = <SingleChildWidget>[
      ChangeNotifierProvider.value(value: UserModel()),
      ChangeNotifierProvider.value(value: WordModel()),
      ChangeNotifierProvider.value(value: SentencesModel()),
      ChangeNotifierProvider.value(value: MiscModel()),
    ];*/

  @override
  Widget build(BuildContext context) {
    return //MultiProvider(
      //providers: _providers,
      //child: 
      MaterialApp(
        //initialRoute: "/",
        home: DictionaryApp(),
        onGenerateRoute: onGenerateRoute,  // 生成器路由(可以实现 命名路由传参)
        debugShowCheckedModeBanner: false, // 去掉debug图标
        theme: _appTheme,                  // 设置App的主题
      //),
    );
  }
}

class MarkDownWidget extends StatelessWidget {

  String _text = '''
# 1. Flutter简#介

**Flutter**是google推出的一款跨平台UI框架adasdsadasdasssssssssssssssssssssssssssssssssssssssssssssssssssssssss。

- Flutter的特点有:
  1. 跨平台
    - Linux
    - Windows 桌面dfgdfgfdgfdgsdfgfdsgfdsgsdfgdfsgdsfgdsfgfdddddddddddddddddddddddddddddddddddddddddddddddd
      dfgdfgfdsgsfdgsfdgfdsgfdsgfdsgdfsgdfsgfd
    - 嵌入式
  2. 热更新
    + 重加载
    + 二进制编译
      - 速度很快
      - 原生编译
    + 热加载
  3. **dart**语言
    - 面向对象
    - 静态类型检查

## 1.1 Flutter入门
''';
  @override
  Widget build(BuildContext context) =>
    Scaffold(
      body: MarkDown(text:_text).render()
    );

}
