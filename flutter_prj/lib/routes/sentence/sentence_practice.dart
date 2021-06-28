import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/routes/common/practice_item_card.dart';
import 'package:flutter_prj/serializers/index.dart';


class SentencePracticePage extends StatefulWidget {
  SentencePracticePage({Key key, this.categories}) : super(key: key);
  final Map<String, num> categories;

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
            children: widget.categories.map((k, v) =>
              MapEntry(
                k,
                practiceItemCard(context, k, v, () async {
                  var studySentence = StudySentenceSerializer();
                  studySentence.filter..foreignUser = Global.localStore.user.id
                                      ..familiarity__lte = 4
                                      ..categories__icontains = k
                                      ..inplan = true;
                  studySentence.queryset.ordering = "familiarity";
                  studySentence.queryset.page_size = null;
                  studySentence.queryset.page_index = null;
                  var studySentences = await studySentence.list();
                  if(studySentences.isEmpty) return;
                  Navigator.of(context).pushNamed('/practice_sentence', arguments: {'title': null, 'studySentences': studySentences});
              }))
            ).values.toList(),
          ),
        ),
      ),
    );
}
