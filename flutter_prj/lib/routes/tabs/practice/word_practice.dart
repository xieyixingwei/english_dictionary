import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/serializers/index.dart';


class WordPracticePage extends StatefulWidget {
  WordPracticePage({Key key, this.studyWords}) : super(key: key);
  final List<StudyWordSerializer> studyWords;

  @override
  _WordPracticePageState createState() => _WordPracticePageState();
}


class _WordPracticePageState extends State<WordPracticePage> {

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        title: Text('单词练习'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
        child: Center(
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            children: Global.localStore.user.studyPlan.wordCategory.map((category) {
              var studyWords = widget.studyWords.where((e) => e.category.contains(category)).toList();
              studyWords.sort((a, b) => a.familiarity.compareTo(b.familiarity));
              return _card(context, category, studyWords.length, () {
                if(studyWords.isEmpty) return;
                Navigator.pushNamed(context, '/practice_word', arguments: {'title': null, 'studyWords': studyWords});
              });
            }).toList()
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
