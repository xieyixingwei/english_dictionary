import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/routes/common/practice_item_card.dart';
import 'package:flutter_prj/routes/sentence/sentence_practice.dart';
import 'package:flutter_prj/routes/tabs/practice/sentence_pattern_practice.dart';
import 'package:flutter_prj/routes/word/word_practice.dart';
import 'package:flutter_prj/serializers/index.dart';


class TabPractice extends StatefulWidget {
  TabPractice({Key key}) : super(key: key);

  @override
  _TabPractice createState() => _TabPractice();
}


class _TabPractice extends State<TabPractice> {

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        title: Text('练习'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
        child: Center(
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.spaceAround,
            runAlignment: WrapAlignment.spaceAround,
            children: [
              practiceItemCard(context, '单词', null, () async {
                if(Global.localStore.user.studyPlan.wordCategories.isEmpty) return;
                var studyWordPagen = StudyWordPaginationSerializer();
                studyWordPagen.filter..foreignUser = Global.localStore.user.id
                                          ..familiarity__lte = 4
                                          ..inplan = true;
                var categories = Map<String, num>();
                await Future.forEach(Global.localStore.user.studyPlan.wordCategories, (c) async {
                  studyWordPagen.filter.categories__icontains = c;
                  var ret = await studyWordPagen.retrieve();
                  if(ret) categories[c] = studyWordPagen.count;
                });

                var reviewCount = await reviewWordCount();

                studyWordPagen = StudyWordPaginationSerializer();
                studyWordPagen.filter..foreignUser = Global.localStore.user.id
                                    ..learnRecord__icontains = DateTime.now().toString().substring(0, 10)
                                    ..inplan = true;
                await studyWordPagen.retrieve();

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => WordPracticePage(categories: categories, studiedCount: studyWordPagen.count, reviewCount: reviewCount),
                  )
                );
              }),
              practiceItemCard(context, '句子', null, () async {
                if(Global.localStore.user.studyPlan.sentenceCategories.isEmpty) return;
                var studySentencePagen = StudySentencePaginationSerializer();
                studySentencePagen.filter..foreignUser = Global.localStore.user.id
                                          ..familiarity__lte = 4
                                          ..inplan = true;
                var categories = Map<String, num>();
                await Future.forEach(Global.localStore.user.studyPlan.sentenceCategories, (c) async {
                  studySentencePagen.filter.categories__icontains = c;
                  var ret = await studySentencePagen.retrieve();
                  if(ret) categories[c] = studySentencePagen.count;
                });
                var reviewCount = await reviewSentenceCount();

                studySentencePagen = StudySentencePaginationSerializer();
                studySentencePagen.filter..foreignUser = Global.localStore.user.id
                                          ..learnRecord__icontains = DateTime.now().toString().substring(0, 10)
                                          ..inplan = true;
                await studySentencePagen.retrieve();

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SentencePracticePage(categories: categories, studiedCount: studySentencePagen.count, reviewCount: reviewCount),
                  )
                );
              }),
              practiceItemCard(context, '固定表达', null, () async {
                if(Global.localStore.user.studyPlan.sentencePatternCategories.isEmpty) return;
                var studySentencePattern = StudySentencePatternSerializer();
                studySentencePattern.filter..foreignUser = Global.localStore.user.id
                                          ..familiarity__lte = 4
                                          ..inplan = true;
                var studySentencePatterns = await studySentencePattern.list();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SentencePatternPracticePage(studySentencePatterns: studySentencePatterns),
                  )
                );
              }),
              practiceItemCard(context, '词义辨析', null, (){}),
            ],
          ),
        ),
      ),
    );
}
