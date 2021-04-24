import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/routes/edit/distinguish_word/edit_distinguish.dart';
import 'package:flutter_prj/routes/edit/distinguish_word/list_distinguishes.dart';
import 'package:flutter_prj/routes/edit/etyma/list_etymas.dart';
import 'package:flutter_prj/routes/edit/etyma/show_etyma.dart';
import 'package:flutter_prj/routes/edit/paraphrase/edit_paraphrase.dart';
import 'package:flutter_prj/routes/edit/sentence/edit_sentence.dart';
import 'package:flutter_prj/routes/edit/sentence/list_sentences.dart';
import 'package:flutter_prj/routes/edit/edit_tags.dart';
import 'package:flutter_prj/routes/edit/grammar/edit_grammar.dart';
import 'package:flutter_prj/routes/edit/grammar/list_grammars.dart';
import 'package:flutter_prj/routes/edit/etyma/edit_etyma.dart';
import 'package:flutter_prj/routes/edit/sentence/show_sentences.dart';
import 'package:flutter_prj/routes/edit/sentence_pattern/edit_sentence_pattern.dart';
import 'package:flutter_prj/routes/edit/sentence_pattern/list_sentence_patterns.dart';
import 'package:flutter_prj/routes/edit/user/edit_user.dart';
import 'package:flutter_prj/routes/edit/user/list_users.dart';
import 'package:flutter_prj/routes/edit/word/edit_word.dart';
import 'package:flutter_prj/routes/edit/word/list_words.dart';
import 'package:flutter_prj/routes/edit/word/show_word.dart';
import 'package:flutter_prj/routes/login.dart';
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
  '/list_users': (context) => ListUsers(),
  '/edit_user': (context, {arguments}) => EditUser(title:arguments['title'], user:arguments['user']),
  '/list_words': (context) => ListWords(),
  '/edit_word': (context, {arguments}) => EditWord(title:arguments['title'], word:arguments['word']),
  '/edit_word_tag': (context) => EditTags(
                                    title: Text('编辑单词 Tag',),
                                    tags: Global.wordTagOptions,
                                    add: (String tag) => WordTagSerializer().create(data:{'name':tag}),
                                    remove: (String tag) => WordTagSerializer()..name = tag ..delete(),
                                    ),
  '/list_sentences': (context) => ListSentences(),
  '/edit_sentence': (context, {arguments}) => EditSentence(title:arguments['title'], sentence:arguments['sentence']),
  '/edit_sentence_tag': (context) => EditTags(
                                        title: Text('编辑句子 Tag',),
                                        tags: Global.sentenceTagOptions,
                                        add: (String tag) => SentenceTagSerializer().create(data:{'name':tag}),
                                        remove: (String tag) => SentenceTagSerializer()..name = tag ..delete(),
                                        ),
  '/list_grammars': (context) => ListGrammers(),
  '/edit_grammar': (context, {arguments}) => EditGrammar(title:arguments['title'], grammar:arguments['grammar']),
  '/edit_grammar_type': (context) => EditTags(
                                        title: Text('编辑语法 Type',),
                                        tags: Global.grammarTypeOptions,
                                        add: (String tag) => GrammarTypeSerializer().create(data:{'name':tag}),
                                        remove: (String tag) => GrammarTypeSerializer()..name = tag ..delete(),
                                        ),
  '/edit_grammar_tag': (context) => EditTags(
                                        title: Text('编辑语法 Tag',),
                                        tags: Global.grammarTagOptions,
                                        add: (String tag) => GrammarTagSerializer().create(data:{'name':tag}),
                                        remove: (String tag) => GrammarTagSerializer()..name = tag ..delete(),
                                        ),
  '/list_etymas': (context) => ListEtymas(),
  '/edit_etyma': (context, {arguments}) => EditEtyma(title:arguments['title'], etyma:arguments['etyma']),
  '/edit_paraphrase': (context, {arguments}) => EditParaphrase(title:arguments['title'], paraphrase:arguments['paraphrase']),
  '/list_sentence_patterns': (context) => ListSentencePatterns(),
  '/edit_sentence_pattern': (context, {arguments}) => EditSentencePattern(title:arguments['title'], sentencePattern:arguments['sentence_pattern']),
  '/list_distinguishes': (context) => ListDistinguishes(),
  '/edit_distinguish': (context, {arguments}) => EditDistinguish(title:arguments['title'], distinguish:arguments['distinguish']),

  '/show_word': (context, {arguments}) => ShowWordPage(title:arguments['title'], word: arguments['word'],),
  '/show_sentences': (context, {arguments}) => ShowSentencesPage(title: arguments['title'], ids: arguments['ids'],),
  '/show_etyma': (context, {arguments}) => ShowEtymaPage(title: arguments['title'], etyma: arguments['etyma'],),
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
