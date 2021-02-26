import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/common/http.dart';
import 'package:flutter_prj/routes/edit/edit_sentence.dart';
import 'package:flutter_prj/routes/edit/edit_tags.dart';
import 'package:flutter_prj/routes/edit/list_sentences.dart';
import 'package:flutter_prj/routes/login.dart';
import 'package:flutter_prj/routes/manage_users.dart';
import 'package:flutter_prj/routes/register.dart';
import 'package:flutter_prj/serializers/index.dart';

import '../dictionary_app.dart';
import 'setting.dart';


// 定义命名路由
final _routes = {
  "/": (context, {arguments}) => DictionaryApp(index: arguments),
  "/login": (context) => LoginPage(),
  "/register": (context) => RegisterPage(),
  "/setting": (context) => Setting(),
  "/manage_users": (context) => ManageUsers(),
  //"/edit_word": (context) => EditWord(),
  "/edit_word_tags": (context) => EditTags(
    title: Text("编辑单词 Tags",),
    tags: Global.wordTagOptions,
    add: (String tag) => Http().createWordTag(tag),
    remove: (String tag) => Http().deleteWordTag(tag),
    ),
  "/edit_sentence": (context, {arguments}) => EditSentence(sentence:arguments),
  "/list_sentences": (context) => ListSentence(),
  "/edit_sentence_tags": (context) => EditTags(
    title: Text("编辑句子 Tags",),
    tags: Global.sentenceTagOptions,
    add: (String tag) => SentenceTagsSerializer().create(data:{"t_name":tag}),
    remove: (String tag) => SentenceTagsSerializer()..t_name = tag ..delete(),
    ),
};

// 实现命名路由传参的函数
Route<dynamic> onGenerateRoute(RouteSettings settings) {
  final String routeName = settings.name;
  final Function widgetBuilder = _routes[routeName];

  return settings.arguments != null ?
    MaterialPageRoute(
      builder: (context) => widgetBuilder(context, arguments:settings.arguments)
    ) :
    MaterialPageRoute(
      builder: (context) => widgetBuilder(context),
    );
}
