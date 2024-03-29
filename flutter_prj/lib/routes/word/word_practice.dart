import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/routes/common/common.dart';
import 'package:flutter_prj/routes/common/practice_item_card.dart';
import 'package:flutter_prj/serializers/index.dart';


class WordPracticePage extends StatefulWidget {
  WordPracticePage({Key key, this.categories, this.studiedCount, this.reviewCount}) : super(key: key);

  final Map<String, num> categories;
  final num studiedCount;
  final num reviewCount;

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
            children: <Widget>[todayStudy(context), review(context)] + widget.categories.map((k, v) =>
              MapEntry(
                k,
                practiceItemCard(context, k, v.toString(), () async {
                  var studyWord = StudyWordSerializer();
                  studyWord.filter..foreignUser = Global.localStore.user.id
                                      ..familiarity__lte = 4
                                      ..categories__icontains = k
                                      ..inplan = true;
                  studyWord.queryset.clear();
                  studyWord.queryset.ordering = "familiarity";
                  var studyWords = await studyWord.list();
                  if(studyWords.isEmpty) return;
                  Navigator.pushNamed(context,
                                      '/practice_word',
                                      arguments: {
                                        'title': null,
                                        'studyWords': studyWords,
                                        'isReview': false});
              }))
            ).values.toList(),
          ),
        ),
      ),
    );

  Widget review(BuildContext context) =>
    practiceItemCard(context, '复习', widget.reviewCount.toString(), () async {
      var studyWords = <StudyWordSerializer>[];
      var studyWord = StudyWordSerializer();
      studyWord.filter..foreignUser = Global.localStore.user.id
                          ..familiarity__lte = 4
                          ..repeats__gte = 1
                          ..inplan = true;
      studyWord.queryset.clear();
      studyWord.queryset.ordering = "familiarity";
      await Future.forEach(reviewDates(), (e) async {
        studyWord.filter.learnRecord__icontains = e;
        var sw = await studyWord.list();
        if(sw.isNotEmpty) studyWords.insertAll(0, sw);
      });

      if(studyWords.isEmpty) return;
      Navigator.pushNamed(context,
                          '/practice_word',
                          arguments: {
                            'title': null,
                            'studyWords': studyWords,
                            'isReview': true});
  });

  Widget todayStudy(BuildContext context) {
    var count = '${widget.studiedCount}/${Global.localStore.user.studyPlan.onceWords}';
    return practiceItemCard(context, '今天任务', count, () async {
      var studyWordPagen = StudyWordPaginationSerializer();
      studyWordPagen.filter..foreignUser = Global.localStore.user.id
                          ..familiarity__lte = 0
                          ..repeats__lte = 0
                          ..inplan = true;
      studyWordPagen.queryset.page_size = Global.localStore.user.studyPlan.onceWords;
      studyWordPagen.queryset.ordering = "familiarity";
      var ret = await studyWordPagen.retrieve();

      if(!ret && studyWordPagen.results.isEmpty) return;
      Navigator.pushNamed(context,
                          '/practice_word',
                          arguments: {
                            'title': null,
                            'studyWords': studyWordPagen.results,
                            'isReview': false});
    });
  }
}

Future<num> reviewWordCount() async {
  num count = 0;
  var studyWordPagen = StudyWordPaginationSerializer();
    studyWordPagen.filter..foreignUser = Global.localStore.user.id
                        ..familiarity__lte = 4
                        ..repeats__gte = 1
                        ..inplan = true;
    studyWordPagen.queryset.page_size = 1;

    await Future.forEach(reviewDates(), (e) async {
      studyWordPagen.filter.learnRecord__icontains = e;
      var ss = await studyWordPagen.retrieve();
      if(ss) count += studyWordPagen.count;
    });
    return count;
}
