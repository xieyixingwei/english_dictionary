import 'package:flutter/material.dart';
import 'package:flutter_prj/routes/edit/sentence/show_sentences.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/OnOffWidget.dart';
import 'package:flutter_prj/widgets/RatingStar.dart';
import 'package:flutter_prj/widgets/column_space.dart';
import 'package:flutter_prj/widgets/row_space.dart';


class ShowWordPage extends StatelessWidget {
  ShowWordPage({Key key, this.title, this.word}) : super(key: key);

  final String title;
  final WordSerializer word;

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
        child: ShowWord(word: word,),
      ),
    );
}


class ShowWord extends StatelessWidget {
  ShowWord({Key key, this.word}) : super(key: key);

  final WordSerializer word;
  final _labelStyle = TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) => _wordShow(context);

  Widget _wordShow(BuildContext context) => word.name.isNotEmpty ?
    ColumnSpace(
      crossAxisAlignment: CrossAxisAlignment.start,
      divider: SizedBox(height: 14,),
      children: [
        _wordNameShow,
        RowSpace(
          divider: SizedBox(width: 10,),
          children: [
            _voiceUsShow,
            _voiceUkShow,
          ],
        ),
        RowSpace(
          divider: SizedBox(width: 10,),
          children: [
            _tagShow,
            _etymaShow(context),
          ],
        ),
        Divider(height: 1, thickness: 1, color: Colors.black12,),
        ColumnSpace(
          crossAxisAlignment: CrossAxisAlignment.start,
          divider: Container(
            margin: EdgeInsets.only(top: 14, bottom: 14),
            child: Divider(height: 1, thickness: 1, color: Colors.black12,),
          ),
          children: [
            _morphShow(context),
            _originShow,
            _shorthandShow,
            _paraphraseSetShow(context),
            _sentencePatternSetShow(context),
            _grammerSetShow,
            _distinguishSetShow(context),
            _synonymsShow(context),
            _antonymsShow(context),
          ],
        ),
      ],
    ) : null;

  Widget get _wordNameShow => word.name.isNotEmpty ?
    Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SelectableText(
          word.name,
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w700,
            fontSize: 28,
            height: 1,
          ),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(Icons.star, color: Colors.redAccent, size: 24),
          tooltip: '收藏',
          splashRadius: 5.0,
          onPressed: () => print("收藏"),
        ),
        //ratingStar(3.3,5),
      ],
    ) : null;

  Widget get _voiceUsShow => word.voiceUs.isNotEmpty ?
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SelectableText(
          '美 ${word.voiceUs}',
          style: TextStyle(fontSize: 12, color: Colors.black87, height: 1,),
        ),
        SizedBox(width: 6,),
        InkWell(
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Icon(Icons.volume_up_outlined, color: Colors.blue, size: 20,),
          onTap: () => print("发音"),
        ),
      ]
    ) : null;

  Widget get _voiceUkShow => word.voiceUk.isNotEmpty ?
    Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SelectableText(
          '英 ${word.voiceUk}',
          style: TextStyle(fontSize: 12, color: Colors.black87, height: 1,),
        ),
        SizedBox(width: 6,),
        InkWell(
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Icon(Icons.volume_up_outlined, color: Colors.blue, size: 20,),
          onTap: () => print("发音"),
        ),
      ]
    ) : null;

  Widget get _tagShow => word.tag.isNotEmpty ?
    Text(
      word.tag.join(' / '),
      style: TextStyle(
        fontSize: 10,
        color: Colors.black54,
      ),
    ) : null;

  Widget _etymaShow(BuildContext context) => word.etyma.isNotEmpty ?
    Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text('词根词缀: ', style: TextStyle(fontSize: 10, color: Colors.black54,)),
        Row(
          children: word.etyma.map((e) =>
            InkWell(
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Text(e,  style: TextStyle(fontSize: 10, color: Colors.blueAccent,)),
              onTap: () => Navigator.pushNamed(context, '/show_etyma', arguments: {'title': '${word.name}的词根词缀 $e', 'etyma': e}),
            )
          ).toList(),
        ),
      ],
    ) : null;

  Widget _morphShow(BuildContext context) => word.morph.isNotEmpty ?
    OnOffWidget(
      label: Text('单词变形', style: _labelStyle),
      child: Container(
        padding: EdgeInsets.only(top:14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: word.morph.map<Widget>((e) =>
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  e.split(':').first.trim(),
                  style: TextStyle(fontSize: 12, color: Colors.black54,),
                ),
                SizedBox(width: 6,),
                InkWell(
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Text(
                    e.split(':').last.trim(),
                    style: TextStyle(fontSize: 12, color: Colors.blueAccent,),
                  ),
                  onTap: () async {
                    var w = WordSerializer()..name = e.split(':').last.trim();
                    bool ret = await w.retrieve();
                    if(ret) {
                      Navigator.pushNamed(context, '/show_word', arguments: {'title': '${word.name}的$e', 'word': w});
                    }
                  },
                ),
              ],
            )
          ).toList(),
        ),
      ),
    ) : null;

  Widget get _originShow => word.origin.isNotEmpty ?
    OnOffWidget(
      label: Text('词源', style: _labelStyle),
      child: Container(
        padding: EdgeInsets.only(top:14),
        child: SelectableText(
          word.origin,
          style: TextStyle(
            fontSize: 12,
            color: Colors.black87,
            height: 1,
          ),
        ),
      ),
    ) : null;

  Widget get _shorthandShow => word.shorthand.isNotEmpty ?
    OnOffWidget(
      label: Text('速记', style: _labelStyle),
      child: Container(
        padding: EdgeInsets.only(top:14),
        child: SelectableText(
          word.shorthand,
          style: TextStyle(
            fontSize: 12,
            color: Colors.black87,
            height: 1,
          ),
        ),
      ),
    ) : null;

  Widget _paraphraseSetShow(BuildContext context) => word.paraphraseSet.isNotEmpty ?
    OnOffWidget(
      label: Text('详细释义', style: _labelStyle),
      child: Container(
        padding: EdgeInsets.only(top:14),
        child: _paraphraseListShow(context, word.paraphraseSet),
      ),
    ) : null;

  Widget _paraphraseListShow(BuildContext context, List<ParaphraseSerializer> paraphraseSet) =>
    Column(
      children: sortParaphraseSet(paraphraseSet).map((e) =>
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              e.keys.first,
              style: TextStyle(fontSize: 14, color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(12, 8, 0, 0),
              child: ColumnSpace(
                divider: SizedBox(height: 8,),
                children: e.values.first.asMap().map((i, v) =>
                  MapEntry(i, _paraphraseShow(context, i+1, v))
                ).values.toList(),
              )
            ),
          ]
        )
      ).toList(),
    );

Widget _paraphraseShow(BuildContext context, int index, ParaphraseSerializer paraphrase) =>
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SelectableText(
            '$index. ',
            style: TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.bold, height: 1),
          ),
          SelectableText(
            paraphrase.interpret,
            style: TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.bold, height: 1),
          ),
        ].where((e) => e != null).toList(),
      ),
      paraphrase.sentenceSet.isNotEmpty ? 
      Container(
        padding: EdgeInsets.only(left: 16, top: 8),
        child: _sentenceSetShow(context, paraphrase.sentenceSet),
      ) : null,
    ].where((e) => e != null).toList(),
  );

  Widget _sentenceSetShow(BuildContext context, List<SentenceSerializer> sentenceSet) =>
    ColumnSpace(
      crossAxisAlignment: CrossAxisAlignment.start,
      divider: SizedBox(height: 8,),
      children: sentenceSet.map((e) => sentenceShow(context, e)).toList(),
    );

  List<Map<String, List<ParaphraseSerializer>>> sortParaphraseSet(List<ParaphraseSerializer> paraphrases) {
    List<Map<String, List<ParaphraseSerializer>>> ret = [];
    paraphrases.forEach( (e) {
      var find = ret.singleWhere((ele) => ele.keys.first == e.partOfSpeech, orElse: () => null);
      find == null
            ? ret.add({e.partOfSpeech: [e]})
            : find.values.first.add(e);
    });
    return ret;
  }

  Widget _sentencePatternSetShow(BuildContext context) => word.sentencePatternSet.isNotEmpty ?
    OnOffWidget(
      label: Text('常用句型', style: _labelStyle),
      child: Container(
        padding: EdgeInsets.only(top:14),
        child: ColumnSpace(
          divider: SizedBox(height: 8,),
          children: word.sentencePatternSet.asMap().map((i, e) =>
            MapEntry(i, _sentencePatternShow(context, i+1, e))
          ).values.toList(),
        ),
      ),
    ) : null;

  Widget _sentencePatternShow(BuildContext context, num index, SentencePatternSerializer sp) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SelectableText(
              '[$index]. ',
              style: TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.bold, height: 1),
            ),
            SelectableText(
              sp.content,
              style: TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.bold, height: 1),
            ),
            SizedBox(width: 8,),
            InkWell(
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Icon(Icons.star, color: Colors.redAccent, size: 14),
              onTap: () => print("收藏"),
            ),
          ].where((e) => e != null).toList(),
        ),
        sp.paraphraseSet.isNotEmpty ?
        Container(
          padding: EdgeInsets.only(left: 16, top: 8),
          child: _paraphraseListShow(context, sp.paraphraseSet),
        ) : null,
      ].where((e) => e != null).toList(),
    );

  Widget get _grammerSetShow => word.grammarSet.isNotEmpty ?
    OnOffWidget(
      label: Text('相关语法', style: _labelStyle),
      child: Container(
        padding: EdgeInsets.only(top:14),
        child: ColumnSpace(
          divider: SizedBox(height: 8,),
          children: word.grammarSet.asMap().map((i, e) =>
            MapEntry(i, _grammerShow(i+1, e))
          ).values.toList(),
        ),
      ),
    ) : null;

  Widget _grammerShow(num index, GrammarSerializer gs) =>
    ColumnSpace(
      crossAxisAlignment: CrossAxisAlignment.start,
      divider: SizedBox(height: 8,),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SelectableText(
              '$index. ',
              style: TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.bold, height: 1),
            ),
            SelectableText(
              gs.type.join(', '),
              style: TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.bold, height: 1),
            ),
            SizedBox(width: 8,),
            SelectableText(
              gs.tag.join(' / '),
              style: TextStyle(fontSize: 10, color: Colors.black54, height: 1),
            ),
            SizedBox(width: 8,),
            InkWell(
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Icon(Icons.star, color: Colors.redAccent, size: 14),
              onTap: () => print("收藏"),
            ),
          ].where((e) => e != null).toList(),
        ),
        Padding(
          padding: EdgeInsets.only(left: 14),
          child: SelectableText(
            gs.content,
            style: TextStyle(fontSize: 12, color: Colors.black87, height: 1),
          ),
        ),
      ],
    );

  Widget _distinguishSetShow(BuildContext context) => word.distinguishSet.isNotEmpty ?
    OnOffWidget(
      label: Text('词义辨析', style: _labelStyle),
      child: Container(
        padding: EdgeInsets.only(top:14),
        child: ColumnSpace(
          divider: SizedBox(height: 8,),
          children: word.distinguishSet.asMap().map((i, e) =>
            MapEntry(i, _distinguishShow(context, i+1, e))
          ).values.toList(),
        ),
      ),
    ) : null;

  Widget _distinguishShow(BuildContext context, num index, DistinguishSerializer ds) =>
    ColumnSpace(
      crossAxisAlignment: CrossAxisAlignment.start,
      divider: SizedBox(height: 8,),
      children: [
        RowSpace(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SelectableText(
              '$index. ',
              style: TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.bold, height: 1),
            ),
            RowSpace(
              divider: Text(', '),
              children: ds.wordsForeign.map((e) => 
                InkWell(
                  child: Text(e, style: TextStyle(fontSize: 12, color: Colors.blueAccent, fontWeight: FontWeight.bold)),
                  onTap: () async {
                    var w = WordSerializer()..name = e;
                    bool ret = await w.retrieve();
                    if(ret) {
                      Navigator.pushNamed(context, '/show_word', arguments: {'title': '$e', 'word': w});
                    }
                  },
                )
              ).toList(),
            ),
            SizedBox(width: 8.0,),
            InkWell(
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Icon(Icons.star, color: Colors.redAccent, size: 14),
              onTap: () => print("收藏"),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 14),
          child: SelectableText(
            ds.content,
            style: TextStyle(fontSize: 12, color: Colors.black87, height: 1),
          ),
        ),
      ],
    );

   Widget _synonymsShow(BuildContext context) => word.synonym.isNotEmpty ?
    OnOffWidget(
      label: Text('近义词', style: _labelStyle),
      child: Container(
        padding: EdgeInsets.only(top:14),
        child: Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: word.synonym.map((e) =>
            InkWell(
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Text(
                e,
                style: TextStyle(fontSize: 12, color: Colors.blueAccent),
              ),
              onTap: () async {
                var w = WordSerializer()..name = e;
                bool ret = await w.retrieve();
                if(ret) {
                  Navigator.pushNamed(context, '/show_word', arguments: {'title': '${word.name}的近义词$e', 'word': w});
                }
              },
            )
          ).toList(),
        ),
      ),
    ) : null;

  Widget _antonymsShow(BuildContext context) => word.antonym.isNotEmpty ?
    OnOffWidget(
      label: Text('反义词', style: _labelStyle),
      child: Container(
        padding: EdgeInsets.only(top:14),
        child: Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: word.antonym.map((e) =>
            InkWell(
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Text(
                e,
                style: TextStyle(fontSize: 12, color: Colors.blueAccent),
              ),
              onTap: () async {
                var w = WordSerializer()..name = e;
                bool ret = await w.retrieve();
                if(ret) {
                  Navigator.pushNamed(context, '/show_word', arguments: {'title': '${word.name}的反义词$e', 'word': w});
                }
              },
            )
          ).toList(),
        ),
      ),
    ) : null;
}
