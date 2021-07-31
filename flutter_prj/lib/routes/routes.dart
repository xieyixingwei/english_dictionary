import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/routes/dialog/edit_dialog.dart';
import 'package:flutter_prj/routes/dialog/list_dialog.dart';
import 'package:flutter_prj/routes/dialog/practice_dialog.dart';
import 'package:flutter_prj/routes/distinguish/edit_distinguish.dart';
import 'package:flutter_prj/routes/distinguish/list_distinguishes.dart';
import 'package:flutter_prj/routes/distinguish/show_distinguish.dart';
import 'package:flutter_prj/routes/etyma/list_etymas.dart';
import 'package:flutter_prj/routes/etyma/show_etyma.dart';
import 'package:flutter_prj/routes/grammar/show_grammar.dart';
import 'package:flutter_prj/routes/paraphrase/edit_paraphrase.dart';
import 'package:flutter_prj/routes/sentence/edit_sentence.dart';
import 'package:flutter_prj/routes/sentence/list_sentences.dart';
import 'package:flutter_prj/routes/common/edit_tags.dart';
import 'package:flutter_prj/routes/grammar/edit_grammar.dart';
import 'package:flutter_prj/routes/grammar/list_grammars.dart';
import 'package:flutter_prj/routes/etyma/edit_etyma.dart';
import 'package:flutter_prj/routes/sentence/practice_sentence.dart';
import 'package:flutter_prj/routes/sentence/show_sentences.dart';
import 'package:flutter_prj/routes/sentence_pattern/edit_sentence_pattern.dart';
import 'package:flutter_prj/routes/sentence_pattern/list_sentence_patterns.dart';
import 'package:flutter_prj/routes/sentence_pattern/show_sentence_pattern.dart';
import 'package:flutter_prj/routes/user/edit_user.dart';
import 'package:flutter_prj/routes/user/list_users.dart';
import 'package:flutter_prj/routes/word/edit_word.dart';
import 'package:flutter_prj/routes/word/list_words.dart';
import 'package:flutter_prj/routes/word/practice_word.dart';
import 'package:flutter_prj/routes/word/show_word.dart';
import 'package:flutter_prj/routes/tabs/user_tab/favorite_page.dart';
import 'package:flutter_prj/routes/user/login.dart';
import 'package:flutter_prj/routes/user/register.dart';
import 'package:flutter_prj/serializers/index.dart';
import '../dictionary_app.dart';
import 'tabs/user_tab/setting.dart';


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
                                    remove: (String tag) => WordTagSerializer()..delete(pk:tag),
                                    ),
  '/list_sentences': (context) => ListSentences(),
  '/edit_sentence': (context, {arguments}) => EditSentence(title:arguments['title'], sentence:arguments['sentence']),
  '/edit_sentence_tag': (context) => EditTags(
                                        title: Text('编辑句子 Tag',),
                                        tags: Global.sentenceTagOptions,
                                        add: (String tag) => SentenceTagSerializer().create(data:{'name':tag}),
                                        remove: (String tag) => SentenceTagSerializer()..delete(pk:tag),
                                        ),
  '/list_grammars': (context) => ListGrammers(),
  '/edit_grammar': (context, {arguments}) => EditGrammar(title:arguments['title'], grammar:arguments['grammar']),
  '/edit_grammar_type': (context) => EditTags(
                                        title: Text('编辑语法 Type',),
                                        tags: Global.grammarTypeOptions,
                                        add: (String tag) => GrammarTypeSerializer().create(data:{'name':tag}),
                                        remove: (String tag) => GrammarTypeSerializer()..delete(pk:tag),
                                        ),
  '/edit_grammar_tag': (context) => EditTags(
                                        title: Text('编辑语法 Tag',),
                                        tags: Global.grammarTagOptions,
                                        add: (String tag) => GrammarTagSerializer().create(data:{'name':tag}),
                                        remove: (String tag) => GrammarTagSerializer()..delete(pk:tag),
                                        ),
  '/list_etymas': (context) => ListEtymas(),
  '/edit_etyma': (context, {arguments}) => EditEtyma(title:arguments['title'], etyma:arguments['etyma']),
  '/edit_paraphrase': (context, {arguments}) => EditParaphrase(title:arguments['title'], paraphrase:arguments['paraphrase']),
  '/list_sentence_patterns': (context) => ListSentencePatterns(),
  '/edit_sentence_pattern': (context, {arguments}) => EditSentencePattern(title:arguments['title'], sentencePattern:arguments['sentence_pattern']),
  '/show_sentence_pattern': (context, {arguments}) => ShowSentencePatternPage(title: arguments['title'], sentencePattern: arguments['sentencePattern'],),
  '/list_distinguishes': (context) => ListDistinguishes(),
  '/edit_distinguish': (context, {arguments}) => EditDistinguish(title:arguments['title'], distinguish:arguments['distinguish']),

  '/show_word': (context, {arguments}) => ShowWordPage(title:arguments['title'], word: arguments['word'],),
  '/show_sentences': (context, {arguments}) => ShowSentencesPage(title: arguments['title'], ids: arguments['ids'],),
  '/show_etyma': (context, {arguments}) => ShowEtymaPage(title: arguments['title'], etyma: arguments['etyma'],),

  '/favorite_page': (context) => FavoritePage(),

  '/show_grammar': (context, {arguments}) => ShowGrammarPage(title: arguments['title'], grammar: arguments['grammar'],),
  '/show_distinguish': (context, {arguments}) => ShowDistinguishPage(title: arguments['title'], distinguish: arguments['distinguish'],),

  '/practice_word': (context, {arguments}) => PracticeWord(title: arguments['title'], studyWords: arguments['studyWords'], isReview: arguments['isReview']),
  '/practice_sentence': (context, {arguments}) => PracticeSentence(title: arguments['title'], studySentences: arguments['studySentences'], isReview: arguments['isReview']),

  '/list_dialog': (context) => ListDialog(),
  '/edit_dialog': (context, {arguments}) => EditDialog(title: arguments['title'], dialog: arguments['dialog'],),
  '/edit_dialog_tag': (context) => EditTags(
                                        title: Text('编辑对话 Tag',),
                                        tags: Global.dialogTagOptions,
                                        add: (String tag) => DialogTagSerializer().create(data:{'name':tag}),
                                        remove: (String tag) => DialogTagSerializer()..delete(pk:tag),
                                        ),

  '/practice_dialog': (context, {arguments}) => PracticeDialog(title: arguments['title'], dialog: arguments['dialog'],),
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
