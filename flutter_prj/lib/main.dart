import 'package:flutter/material.dart';
import 'package:flutter_prj/models/misc_model.dart';
import 'package:flutter_prj/models/sentence_model.dart';
import 'package:flutter_prj/routes/Routes.dart';
import 'package:flutter_prj/models/word_model.dart';
import 'package:flutter_prj/routes/tabs/home/home.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'common/global.dart';
import 'dictionary_app.dart';
import 'models/user_model.dart';


void main() => Global.init().then((e) => runApp(MyApp()));


class MyApp extends StatelessWidget {
  final _appTheme = ThemeData.light(); // 定义APP的全局主题

  final _providers = <SingleChildWidget>[
      ChangeNotifierProvider.value(value: UserModel()),
      ChangeNotifierProvider.value(value: WordModel()),
      ChangeNotifierProvider.value(value: SentencesModel()),
      ChangeNotifierProvider.value(value: MiscModel()),
    ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: _providers,
      child: MaterialApp(
        //initialRoute: "/",
        home: DictionaryApp(),
        onGenerateRoute: onGenerateRoute,  // 生成器路由(可以实现 命名路由传参)
        debugShowCheckedModeBanner: false, // 去掉debug图标
        theme: _appTheme,                  // 设置App的主题
      ),
    );
  }
}
