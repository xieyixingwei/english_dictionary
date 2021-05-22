import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/serializers/word_pagination.dart';


class WordPracticePage extends StatefulWidget {
  WordPracticePage({Key key}) : super(key: key);

  @override
  _WordPracticePageState createState() => _WordPracticePageState();
}


class _WordPracticePageState extends State<WordPracticePage> {
  WordPaginationSerializer _words = WordPaginationSerializer();

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        title: Text('单词练习'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          children: Global .wordTagOptions.map((e) =>
            _card(context, e, () async {
              _words.filter.tag__icontains = e;
              bool ret = await _words.retrieve(queries:{'page_size':50, 'page_index':1});
              if(ret && _words.results.isNotEmpty)
                Navigator.pushNamed(context, '/practice_word', arguments: {'title': null, 'words': _words.results});
            })
          ).toList() + [
            _card(context, '收藏的单词', () async {
              List<WordSerializer> words = [];
              await Future.forEach<StudyWordSerializer>(Global.localStore.user.studyWordSet, (e) async {
                  WordSerializer word = WordSerializer()..name = e.word;
                  bool ret = await word.retrieve();
                  if(ret) words.add(word);
              });
              if(words.isNotEmpty)
                Navigator.pushNamed(context, '/practice_word', arguments: {'title': null, 'words': words});
            })
          ],
        ),
      ),
    );

  Widget _card(BuildContext context, String title, Function onPressed) =>
    Container(
      padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
      alignment: Alignment.center,
      height: 160,
      width: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        /*boxShadow: [
          BoxShadow(color: Colors.black26, offset: Offset(5.0, 5.0), blurRadius: 5.0, spreadRadius: 1.0),
          BoxShadow(color: Colors.black26, offset: Offset(1.0, 1.0)), BoxShadow(color: Colors.black26)
        ],*/
      ),
      child: InkWell(
        child: Text(title, style: TextStyle(fontSize: 17),),
        onTap: onPressed,
      ),
    );
}
