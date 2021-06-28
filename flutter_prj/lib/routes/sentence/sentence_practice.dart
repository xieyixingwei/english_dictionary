import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/routes/common/common.dart';
import 'package:flutter_prj/routes/common/practice_item_card.dart';
import 'package:flutter_prj/serializers/index.dart';


class SentencePracticePage extends StatefulWidget {
  SentencePracticePage({Key key, this.categories, this.reviewCount}) : super(key: key);
  final Map<String, num> categories;
  final num reviewCount;

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
            children: <Widget>[todayStudy(context), review(context)] + widget.categories.map((k, v) =>
              MapEntry(
                k,
                practiceItemCard(context, k, v, () async {
                  var studySentence = StudySentenceSerializer();
                  studySentence.filter..foreignUser = Global.localStore.user.id
                                      ..familiarity__lte = 4
                                      ..categories__icontains = k
                                      ..inplan = true;
                  studySentence.queryset.clear();
                  studySentence.queryset.ordering = "familiarity";
                  var studySentences = await studySentence.list();
                  if(studySentences.isEmpty) return;
                  Navigator.of(context).pushNamed('/practice_sentence', arguments: {'title': null, 'studySentences': studySentences});
              }))
            ).values.toList(),
          ),
        ),
      ),
    );

  Widget review(BuildContext context) =>
    practiceItemCard(context, '复习', widget.reviewCount, () async {
      var studySentences = <StudySentenceSerializer>[];
      var studySentence = StudySentenceSerializer();
      studySentence.filter..foreignUser = Global.localStore.user.id
                          ..familiarity__lte = 4
                          ..repeats__gte = 1
                          ..inplan = true;
      studySentence.queryset.clear();
      studySentence.queryset.ordering = "familiarity";
      await Future.forEach(reviewDates(), (e) async {
        studySentence.filter.learnRecord__icontains = e;
        var ss = await studySentence.list();
        if(ss.isNotEmpty) studySentences.insertAll(0, ss);
      });

      if(studySentences.isEmpty) return;
      Navigator.of(context).pushNamed('/practice_sentence', arguments: {'title': null, 'studySentences': studySentences});
  });

  Widget todayStudy(BuildContext context) =>
    practiceItemCard(context, '今天任务', Global.localStore.user.studyPlan.onceSentences, () async {
      var studySentencePagen = StudySentencePaginationSerializer();
      studySentencePagen.filter..foreignUser = Global.localStore.user.id
                          ..familiarity__lte = 0
                          ..repeats__lte = 0
                          ..inplan = true;
      studySentencePagen.queryset.page_size = Global.localStore.user.studyPlan.onceSentences;
      studySentencePagen.queryset.ordering = "familiarity";
      var ret = await studySentencePagen.retrieve();

      if(ret && studySentencePagen.results.isEmpty) return;
      Navigator.of(context).pushNamed('/practice_sentence', arguments: {'title': null, 'studySentences': studySentencePagen.results});
  });
}

Future<num> reviewSentenceCount() async {
  num count = 0;
  var studySentencePagen = StudySentencePaginationSerializer();
    studySentencePagen.filter..foreignUser = Global.localStore.user.id
                        ..familiarity__lte = 4
                        ..repeats__gte = 1
                        ..inplan = true;
    studySentencePagen.queryset.page_size = 1;

    await Future.forEach(reviewDates(), (e) async {
      studySentencePagen.filter.learnRecord__icontains = e;
      var ss = await studySentencePagen.retrieve();
      if(ss) count += studySentencePagen.count;
    });
    return count;
}
