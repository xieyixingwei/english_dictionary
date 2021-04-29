import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/routes/edit/common/utils.dart';
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
            InkWell(
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Icon(Icons.star, color: getStudySentence(sentence.id) == null ? Colors.black54 : Colors.redAccent, size: 14),
              onTap: () async {
                var ss = getStudySentence(sentence.id);
                if(ss == null) {
                  var newSs = StudySentenceSerializer()..sentence = sentence.id
                                                  ..foreignUser = Global.localStore.user.id;
                  Global.localStore.user.studySentenceSet.add(newSs);
                  await newSs.save();
                } else {
                  await ss.delete();
                  Global.localStore.user.studySentenceSet.remove(ss);
                }
                Global.saveLocalStore();
                if(update != null) update();
              },
            ),
          ].where((e) => e != null).toList(),
        ),
        SizedBox(height: 8,),
        SelectableText(
          sentence.cn,
          style: TextStyle(fontSize: 12, color: Colors.black87, height: 1),
        ),
      ]
    );
