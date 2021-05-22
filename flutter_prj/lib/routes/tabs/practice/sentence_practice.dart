import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/serializers/index.dart';


class SentencePracticePage extends StatefulWidget {
  SentencePracticePage({Key key}) : super(key: key);

  @override
  _SentencePracticePageState createState() => _SentencePracticePageState();
}


class _SentencePracticePageState extends State<SentencePracticePage> {
  SentencePaginationSerializer _sentences = SentencePaginationSerializer();

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        title: Text('句子练习'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          children: Global.sentenceTagOptions.map((e) =>
            _card(context, e, () async {
              _sentences.filter.tag__icontains = e;
              bool ret = await _sentences.retrieve(queries:{'page_size':50, 'page_index':1});
              if(ret && _sentences.results.isNotEmpty)
                Navigator.pushNamed(context, '/practice_sentence', arguments: {'title': null, 'sentences': _sentences.results});
            })
          ).toList() + [
            _card(context, '收藏的句子', () async {
              List<SentenceSerializer> sentences = [];
              await Future.forEach<StudySentenceSerializer>(Global.localStore.user.studySentenceSet, (e) async {
                  SentenceSerializer ste = SentenceSerializer()..id = e.sentence;
                  bool ret = await ste.retrieve();
                  if(ret) sentences.add(ste);
              });
              if(sentences.isNotEmpty)
                Navigator.pushNamed(context, '/practice_sentence', arguments: {'title': null, 'sentences': sentences});
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
