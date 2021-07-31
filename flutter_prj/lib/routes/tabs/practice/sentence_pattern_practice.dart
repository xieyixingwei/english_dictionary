import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/routes/sentence_pattern/practice_sentence_pattern.dart';
import 'package:flutter_prj/serializers/index.dart';


class SentencePatternPracticePage extends StatefulWidget {
  SentencePatternPracticePage({Key key, this.studySentencePatterns}) : super(key: key);

  final List<StudySentencePatternSerializer> studySentencePatterns;

  @override
  _SentencePatternPracticePageState createState() => _SentencePatternPracticePageState();
}


class _SentencePatternPracticePageState extends State<SentencePatternPracticePage> {

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        title: Text('固定表达练习'),
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
            children: Global.localStore.user.studyPlan.sentencePatternCategories.map((category) {
              var studySentencePatterns = widget.studySentencePatterns.where((e) => e.categories.contains(category)).toList();
              return _card(context, category, studySentencePatterns.length, () {
                if(studySentencePatterns.isEmpty) return;
                studySentencePatterns.sort((a, b) => a.familiarity.compareTo(b.familiarity));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PracticeSentencePattern(studySentencePatterns: studySentencePatterns)
                  )
                );
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
