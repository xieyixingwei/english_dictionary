import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/serializers/index.dart';


class SentencePracticePage extends StatefulWidget {
  SentencePracticePage({Key key, this.studySentences}) : super(key: key);
  final List<StudySentenceSerializer> studySentences;

  @override
  _SentencePracticePageState createState() => _SentencePracticePageState();
}


class _SentencePracticePageState extends State<SentencePracticePage> {

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        title: Text('句子练习'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
        child: Center(
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            children: Global.localStore.user.studyPlan.sentenceCategories.map((category) {
              var studySentences = widget.studySentences.where((e) => e.categories.contains(category)).toList();
              return _card(context, category, studySentences.length, () {
                if(studySentences.isEmpty) return;
                studySentences.sort((a, b) => a.familiarity.compareTo(b.familiarity));
                Navigator.pushNamed(context, '/practice_sentence', arguments: {'title': null, 'studySentences': studySentences});
              });
            }).toList(),
          ),
        ),
      ),
    );

  Widget _card(BuildContext context, String title, num count, Function onPressed) =>
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
      child: Center(
        child: InkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(count.toString(), style: TextStyle(fontSize: 17),),
              Text(title, style: TextStyle(fontSize: 17),),
            ]
          ),
          onTap: onPressed,
        ),
      ),
    );
}
