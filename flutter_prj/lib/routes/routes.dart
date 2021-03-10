import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/routes/edit/etyma/edit_etymas.dart';
import 'package:flutter_prj/routes/edit/sentence/edit_sentence.dart';
import 'package:flutter_prj/routes/edit/sentence/edit_sentences.dart';
import 'package:flutter_prj/routes/edit/edit_tags.dart';
import 'package:flutter_prj/routes/edit/grammar/edit_grammar.dart';
import 'package:flutter_prj/routes/edit/grammar/edit_grammars.dart';
import 'package:flutter_prj/routes/edit/etyma/edit_etyma.dart';
import 'package:flutter_prj/routes/edit/word/edit_word.dart';
import 'package:flutter_prj/routes/edit/word/edit_words.dart';
import 'package:flutter_prj/routes/login.dart';
import 'package:flutter_prj/routes/manage_users.dart';
import 'package:flutter_prj/routes/register.dart';
import 'package:flutter_prj/serializers/index.dart';
import '../dictionary_app.dart';
import 'setting.dart';


// 定义命名路由
final _routes = {
  '/': (context, {arguments}) => DictionaryApp(index: arguments),
  '/login': (context) => LoginPage(),
  '/register': (context) => RegisterPage(),
  '/setting': (context) => Setting(),
  '/manage_users': (context) => ManageUsers(),
  '/edit_words': (context) => EditWords(),
  '/edit_word': (context, {arguments}) => EditWord(title:arguments['title'], word:arguments['word']),
  '/edit_word_tags': (context) => EditTags(
                                    title: Text('编辑单词 Tags',),
                                    tags: Global.wordTagOptions,
                                    add: (String tag) => WordTagsSerializer().create(data:{'t_name':tag}),
                                    remove: (String tag) => WordTagsSerializer()..t_name = tag ..delete(),
                                    ),
  '/edit_sentences': (context) => EditSentences(),
  '/edit_sentence': (context, {arguments}) => EditSentence(title:arguments['title'], sentence:arguments['sentence']),
  '/edit_sentence_tags': (context) => EditTags(
                                        title: Text('编辑句子 Tags',),
                                        tags: Global.sentenceTagOptions,
                                        add: (String tag) => SentenceTagsSerializer().create(data:{'t_name':tag}),
                                        remove: (String tag) => SentenceTagsSerializer()..t_name = tag ..delete(),
                                        ),
  '/edit_grammars': (context) => EditGrammers(),
  '/edit_grammar': (context, {arguments}) => EditGrammar(title:arguments['title'], grammar:arguments['grammar']),
  '/edit_grammar_type': (context) => EditTags(
                                        title: Text('编辑语法 Type',),
                                        tags: Global.grammarTypeOptions,
                                        add: (String tag) => GrammarTypeSerializer().create(data:{'g_name':tag}),
                                        remove: (String tag) => GrammarTypeSerializer()..g_name = tag ..delete(),
                                        ),
  '/edit_grammar_tags': (context) => EditTags(
                                        title: Text('编辑语法 Tags',),
                                        tags: Global.grammarTagOptions,
                                        add: (String tag) => GrammarTagsSerializer().create(data:{'g_name':tag}),
                                        remove: (String tag) => GrammarTagsSerializer()..g_name = tag ..delete(),
                                        ),
  '/edit_etymas': (context) => EditEtymas(),
  '/edit_etyma': (context, {arguments}) => EditEtyma(title:arguments['title'], etyma:arguments['etyma']),
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
