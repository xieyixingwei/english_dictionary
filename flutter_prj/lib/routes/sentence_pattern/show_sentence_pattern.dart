import 'package:flutter/material.dart';
import 'package:flutter_prj/routes/paraphrase/show_paraphrase.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/row_space.dart';


class ShowSentencePatternPage extends StatelessWidget {
  ShowSentencePatternPage({Key key, this.title, this.sentencePattern}) : super(key: key);

  final String title;
  final SentencePatternSerializer sentencePattern;

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
        child: sentencePatternShow(context, null, sentencePattern, null),
      ),
    );
}


Widget sentencePattrenItem({BuildContext context, SentencePatternSerializer sp, Widget trailing}) {
  return ListTile(
    dense: true,
    horizontalTitleGap: 0,
    minVerticalPadding: 0,
    minLeadingWidth: 30,
    contentPadding: EdgeInsets.only(left: 14, right: 14, top: 0, bottom: 0),
    leading: Text('${sp.id}', style: TextStyle(fontSize: 14, color: Colors.black54),),
    title: Text(sp.content, style: TextStyle(fontSize: 14, color: Colors.black87)),
    trailing: trailing,
  );
}


Widget sentencePatternShow(BuildContext context, num index, SentencePatternSerializer sp, Function update) =>
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      RowSpace(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          index == null ? null :
          SelectableText(
            '[$index]. ',
            style: TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.bold, height: 1),
          ),
          SelectableText(
            sp.content,
            style: TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.bold, height: 1),
          ),
        ].where((e) => e != null).toList(),
      ),
      sp.paraphraseSet.isNotEmpty ?
      Container(
        padding: EdgeInsets.only(left: 16, top: 8),
        child: paraphraseListShow(context, sp.paraphraseSet, update),
      ) : null,
    ].where((e) => e != null).toList(),
  );
