import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/routes/common/common.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/column_space.dart';


class ShowSentencesPage extends StatefulWidget {

  ShowSentencesPage({Key key, this.title, this.ids}) : super(key: key);

  final String title;
  final List<num> ids;

  @override
  _ShowSentencesPageState createState() => _ShowSentencesPageState();
}

class _ShowSentencesPageState extends State<ShowSentencesPage> {

  List<SentenceSerializer> _sentences = [];

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    await Future.forEach(widget.ids, (e) async {
      var s = SentenceSerializer()..id = e;
      var ret = await s.retrieve();
      if(ret) _sentences.add(s);
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
        child: ColumnSpace(
          crossAxisAlignment: CrossAxisAlignment.start,
          divider: SizedBox(height: 16,),
          children: _sentences.map((e) =>
            sentenceShow(context, e, ()=>setState((){}))
          ).toList(),
        ),
      ),
    );
}

Widget sentenceSetShow(BuildContext context, List<SentenceSerializer> sentenceSet, Function update) =>
  ColumnSpace(
    crossAxisAlignment: CrossAxisAlignment.start,
    divider: SizedBox(height: 8,),
    children: sentenceSet.map((e) =>
      sentenceShow(context, e, update) //()=>setState((){})
    ).toList(),
  );

Widget sentenceShow(BuildContext context, SentenceSerializer sentence, Function update) =>
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Wrap(
        spacing: 8.0,
        runSpacing: 0.0,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SelectableText(
            sentence.en,
            style: TextStyle(fontSize: 12, color: Colors.black87, height: 1),
          ),
          sentence.tense != null ?
          Text(
            sentence.tense,
            style: TextStyle(fontSize: 10, color: Colors.black54,),
          ) : null,
          sentence.pattern.isNotEmpty ? Text(
            sentence.pattern.join('/'),
            style: TextStyle(fontSize: 10, color: Colors.black54,),
          ) : null,
          sentence.tag.isNotEmpty ? Text(
            sentence.tag.join('/'),
            style: TextStyle(fontSize: 10, color: Colors.black54,),
          ) : null,
          sentence.synonym.isNotEmpty ? InkWell(
            child: Text('同义句', style: TextStyle(fontSize: 10, color: Colors.blueAccent,)),
            onTap: () => Navigator.pushNamed(context, '/show_sentences', arguments: {'title': '同义句', 'ids': sentence.synonym})
          ) : null,
          sentence.antonym.isNotEmpty ? InkWell(
            child: Text('反义句', style: TextStyle(fontSize: 10, color: Colors.blueAccent,)),
            onTap: () => Navigator.pushNamed(context, '/show_sentences', arguments: {'title': '反义句', 'ids': sentence.antonym})
          ) : null,
          update != null ? InkWell(
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Icon(Icons.star, color: sentence.studySentenceSet.isEmpty ? Colors.black54 : Colors.redAccent, size: 14),
            onTap: () async {
              var categories = sentence.studySentenceSet.isEmpty ? <String>[] : sentence.studySentenceSet.first.categories;
              String category = await popSelectSentenceCategoryDialog(context, categories);
              if(category == null) return;
              if(categories.contains(category)) {
                sentence.studySentenceSet.first.categories.remove(category);
                if(sentence.studySentenceSet.first.categories.isEmpty) {
                  await sentence.studySentenceSet.first.delete();
                  sentence.studySentenceSet.clear();
                } else {
                  await sentence.studySentenceSet.first.save();
                }
              } else {
                if(sentence.studySentenceSet.isEmpty) {
                  var newSs = StudySentenceSerializer()..sentence = SentenceSerializer().from(sentence)
                                                    ..foreignUser = Global.localStore.user.id
                                                    ..inplan = true
                                                    ..categories.add(category);
                  var ret = await newSs.save();
                  if(ret) sentence.studySentenceSet.add(newSs);
                } else {
                  sentence.studySentenceSet.first.categories.add(category);
                  await sentence.studySentenceSet.first.save();
                }
              }
              if(update != null) update();
            },
          ) : null,
        ].where((e) => e != null).toList(),
      ),
      SizedBox(height: 8,),
      SelectableText(
        sentence.cn,
        style: TextStyle(fontSize: 12, color: Colors.black87, height: 1),
      ),
    ]
  );


Widget sentenceItem({BuildContext context, SentenceSerializer sentence, Widget trailing}) {
  String categories = sentence.studySentenceSet.isNotEmpty ? sentence.studySentenceSet.first.categories.join('/') : '';
  Widget subtitle = Text.rich(
    TextSpan(
        children: [
          TextSpan(text: '${sentence.cn}', style: TextStyle(fontSize: 12, color: Colors.black45)),
          TextSpan(text: '    ${sentence.tag?.join('/')}', style: TextStyle(fontSize: 10, color: Colors.black45)),
          TextSpan(text: '    ${sentence.tense ?? ""}', style: TextStyle(fontSize: 10, color: Colors.black45)),
          TextSpan(text: '   $categories', style: TextStyle(fontSize: 10, color: Colors.black45)),
        ]
      )
  );
  return ListTile(
    dense: true,
    horizontalTitleGap: 0,
    minVerticalPadding: 0,
    minLeadingWidth: 30,
    contentPadding: EdgeInsets.only(left: 14, right: 14, top: 0, bottom: 0),
    leading: Text('${sentence.id}', style: TextStyle(fontSize: 14, color: Colors.black45)),
    title: Text('${sentence.en}', style: TextStyle(fontSize: 14, color: Colors.black87)),
    subtitle: subtitle,
    trailing: trailing,
  );
}

