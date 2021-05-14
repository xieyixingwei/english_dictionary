import 'package:audioplayers/audioplayers_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/markdown/markdown.dart';
import 'package:flutter_prj/routes/edit/common/utils.dart';
import 'package:flutter_prj/routes/edit/sentence/show_sentences.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/OnOffWidget.dart';
import 'package:flutter_prj/widgets/column_space.dart';
import 'package:flutter_prj/widgets/row_space.dart';
import 'package:flutter_prj/widgets/vedio_player.dart';


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

class ShowWord extends StatefulWidget {
  ShowWord({Key key, this.word}) : super(key: key);

  final WordSerializer word;

  @override
  _ShowWordState createState() => _ShowWordState();
}

class _ShowWordState extends State<ShowWord> {

  final _labelStyle = TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.bold);
  //AudioPlayer _player = AudioPlayer();
  WrappedPlayer _audioPlayer = WrappedPlayer();

  @override
  Widget build(BuildContext context) => _wordShow(context);

  Widget _wordShow(BuildContext context) => widget.word.name.isNotEmpty ?
    ColumnSpace(
      crossAxisAlignment: CrossAxisAlignment.start,
      divider: SizedBox(height: 14,),
      children: [
        _wordNameShow(context),
        RowSpace(
          divider: SizedBox(width: 10,),
          children: [
            _voiceUsShow,
            _voiceUkShow,
          ],
        ),
        widget.word.tag.isNotEmpty || widget.word.etyma.isNotEmpty ?
        RowSpace(
          divider: SizedBox(width: 10,),
          children: [
            _tagShow,
            _etymaShow(context),
          ],
        ) : null,
        _originShow,
        Divider(height: 1, thickness: 1, color: Colors.black12,),
        ColumnSpace(
          crossAxisAlignment: CrossAxisAlignment.start,
          divider: Container(
            margin: EdgeInsets.only(top: 14, bottom: 14),
            child: Divider(height: 1, thickness: 1, color: Colors.black12,),
          ),
          children: [
            _morphShow(context),
            _paraphraseSetShow(context),
            _distinguishSetShow(context),
            _sentencePatternSetShow(context),
            _grammerSetShow,
            _shorthandShow,
            _synonymsShow(context),
            _antonymsShow(context),
          ],
        ),
      ],
    ) : Text('loading');

  Widget _wordNameShow(BuildContext context) => widget.word.name.isNotEmpty ?
    RowSpace(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SelectableText(
          widget.word.name,
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w700,
            fontSize: 28,
            height: 1,
          ),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(Icons.star, color: getStudyWord(widget.word.name) == null ? Colors.black54 : Colors.redAccent, size: 24),
          tooltip: '收藏',
          splashRadius: 5.0,
          onPressed: () async {
            var sw = getStudyWord(widget.word.name);
            if(sw == null) {
              var category = await popSelectWordCategoryDialog(context);
              if(category == null) return;
              var newSw = StudyWordSerializer()..word = widget.word.name
                                               ..foreignUser = Global.localStore.user.id
                                               ..category = category;
              Global.localStore.user.studyWordSet.add(newSw);
              await newSw.save();
            } else {
              await sw.delete();
              Global.localStore.user.studyWordSet.remove(sw);
            }
            Global.saveLocalStore();
            setState(() {});
          },
        ),
        Global.localStore.user.uname == 'root' ?
        InkWell(
          child: Text('修改', style: TextStyle(fontSize: 12, color: Colors.blueAccent),),
          onTap: () async {
            var word = (await Navigator.pushNamed(
              context, '/edit_word',
              arguments: {'title':'编辑单词','word':WordSerializer().from(widget.word)})
            ) as WordSerializer;
            if(word != null) await widget.word.from(word).save();
            setState(() {});
          },
        ) : null,
      ],
    ) : null;

  Widget get _voiceUsShow =>
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SelectableText(
          '美 ${widget.word.voiceUs ?? ''}',
          style: TextStyle(fontSize: 12, color: Colors.black87, height: 1,),
        ),
        SizedBox(width: 6,),
        InkWell(
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Icon(Icons.volume_up_outlined, color: widget.word.audioUsMan != null ? Colors.blue : Colors.grey, size: 20,),
          onTap: () {if(widget.word.audioUsMan == null) return; _audioPlayer.setUrl(widget.word.audioUsMan); _audioPlayer.start(0); },
        ),
        SizedBox(width: 6,),
        InkWell(
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Icon(Icons.volume_up_outlined, color: widget.word.audioUsWoman != null ? Colors.pink : Colors.grey, size: 20,),
          onTap: () async {if(widget.word.audioUsWoman == null) return; _audioPlayer.setUrl(widget.word.audioUsWoman); _audioPlayer.start(0);},
        ),
      ]
    );

  Widget get _voiceUkShow =>
    Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SelectableText(
          '英 ${widget.word.voiceUk}',
          style: TextStyle(fontSize: 12, color: Colors.black87, height: 1,),
        ),
        SizedBox(width: 6,),
        InkWell(
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Icon(Icons.volume_up_outlined, color: widget.word.audioUkMan != null ? Colors.blue : Colors.grey, size: 20,),
          onTap: () async {if(widget.word.audioUkMan == null) return; _audioPlayer.setUrl(widget.word.audioUkMan); _audioPlayer.start(0);},
        ),
        SizedBox(width: 6,),
        InkWell(
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Icon(Icons.volume_up_outlined, color: widget.word.audioUkWoman != null ? Colors.pink : Colors.grey, size: 20,),
          onTap: () async {if(widget.word.audioUkWoman == null) return; _audioPlayer.setUrl(widget.word.audioUkWoman); _audioPlayer.start(0);},
        ),
      ]
    );

  Widget get _tagShow => widget.word.tag.isNotEmpty ?
    Text(
      widget.word.tag.join(' / '),
      style: TextStyle(
        fontSize: 12,
        color: Colors.black54,
      ),
    ) : null;

  Widget _etymaShow(BuildContext context) => widget.word.etyma.isNotEmpty ?
    Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text('词根词缀: ', style: TextStyle(fontSize: 12, color: Colors.black54,)),
        RowSpace(
          divider: SizedBox(width: 4,),
          children: widget.word.etyma.map((e) =>
            InkWell(
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Text(e,  style: TextStyle(fontSize: 12, color: Colors.blueAccent,)),
              onTap: () => Navigator.pushNamed(context, '/show_etyma', arguments: {'title': '${widget.word.name}的词根词缀 $e', 'etyma': e}),
            )
          ).toList(),
        ),
      ],
    ) : null;

  Widget _morphShow(BuildContext context) => widget.word.morph.isNotEmpty ?
    OnOffWidget(
      label: Text('单词变形', style: _labelStyle),
      child: Container(
        padding: EdgeInsets.only(top:14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.word.morph.map<Widget>((e) =>
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
                      Navigator.pushNamed(context, '/show_word', arguments: {'title': '${widget.word.name}的$e', 'word': w});
                    }
                  },
                ),
              ],
            )
          ).toList(),
        ),
      ),
    ) : null;

  Widget get _originShow => widget.word.origin.isNotEmpty ?
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '词源',
          style: TextStyle(
            fontSize: 12,
            color: Colors.black87,
            fontWeight: FontWeight.bold
          ),
          strutStyle: StrutStyle(
            fontSize: 12,
            forceStrutHeight: true,
          ),
        ),
        Icon(Icons.label_important, size: 16, color: Colors.black87,),
        Flexible(
          child: MarkDown(text:widget.word.origin).render()
        ),
      ],
    ) : null;

  Widget get _shorthandShow => widget.word.shorthand.isNotEmpty || widget.word.image.url != null || widget.word.vedio.url != null ?
    OnOffWidget(
      label: Text('图文助记', style: _labelStyle),
      child: Container(
        padding: EdgeInsets.only(top:14),
        child: ColumnSpace(
          crossAxisAlignment: CrossAxisAlignment.start,
          divider: SizedBox(height: 14,),
          children: [
            widget.word.shorthand.isNotEmpty ? MarkDown(text: widget.word.shorthand).render() : null,
            widget.word.image.url != null ?
            Align(
              alignment: Alignment.center,
              child: Image.network(
                widget.word.image.url,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              )
            ) : null,
            widget.word.vedio.url != null ?
            Align(
              alignment: Alignment.center,
              child: VedioPlayerWeb(url: widget.word.vedio.url),
            ) : null,
          ],
        )
      ),
    ) : null;

  Widget _paraphraseSetShow(BuildContext context) => widget.word.paraphraseSet.isNotEmpty ?
    OnOffWidget(
      label: Text('详细释义', style: _labelStyle),
      child: Container(
        padding: EdgeInsets.only(top:14),
        child: _paraphraseListShow(context, widget.word.paraphraseSet),
      ),
    ) : null;

  Widget _paraphraseListShow(BuildContext context, List<ParaphraseSerializer> paraphraseSet) =>
    ColumnSpace(
      divider: SizedBox(height: 14,),
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
      RowSpace(
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
          SizedBox(width: 8,),
          Global.localStore.user.uname == 'root' ?
          InkWell(
            child: Text('修改', style: TextStyle(fontSize: 12, color: Colors.blueAccent),),
            onTap: () async {
             var p = (await Navigator.pushNamed(
                                  context, '/edit_paraphrase',
                                  arguments: {
                                    'title':'编辑${widget.word.name}的释义',
                                    'paraphrase': ParaphraseSerializer().from(paraphrase)})
                      ) as ParaphraseSerializer;
              if(p != null) {
                await paraphrase.from(p).save();
              }
              setState(() {});
            },
          ) : null,
        ],
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
      children: sentenceSet.map((e) => sentenceShow(context, e, ()=>setState((){}))).toList(),
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

  Widget _sentencePatternSetShow(BuildContext context) => widget.word.sentencePatternSet.isNotEmpty ?
    OnOffWidget(
      label: Text('常用句型', style: _labelStyle),
      child: Container(
        padding: EdgeInsets.only(top:14),
        child: ColumnSpace(
          divider: SizedBox(height: 8,),
          children: widget.word.sentencePatternSet.asMap().map((i, e) =>
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
          ].where((e) => e != null).toList(),
        ),
        sp.paraphraseSet.isNotEmpty ?
        Container(
          padding: EdgeInsets.only(left: 16, top: 8),
          child: _paraphraseListShow(context, sp.paraphraseSet),
        ) : null,
      ].where((e) => e != null).toList(),
    );

  Widget get _grammerSetShow => widget.word.grammarSet.isNotEmpty ?
    OnOffWidget(
      label: Text('相关语法', style: _labelStyle),
      child: Container(
        padding: EdgeInsets.only(top:14),
        child: ColumnSpace(
          divider: SizedBox(height: 8,),
          children: widget.word.grammarSet.asMap().map((i, e) =>
            MapEntry(i, _grammarShow(i+1, e))
          ).values.toList(),
        ),
      ),
    ) : null;

  Widget _grammarShow(num index, GrammarSerializer gs) =>
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
            SizedBox(width: 8,),
             SelectableText(
              gs.title,
              style: TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.bold, height: 1),
            ),
            SizedBox(width: 8,),
            SelectableText(
              gs.type.join('/'),
              style: TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.bold, height: 1),
            ),
            SizedBox(width: 8,),
            SelectableText(
              gs.tag.join('/'),
              style: TextStyle(fontSize: 10, color: Colors.black54, height: 1),
            ),
            SizedBox(width: 8,),
            InkWell(
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Icon(Icons.star, color: getStudyGrammar(gs.id) == null ? Colors.black54 : Colors.redAccent, size: 14),
              onTap: () async {
                var sg = getStudyGrammar(gs.id);
                if(sg == null) {
                  var category = await popSelectGrammarCategoryDialog(context);
                  if(category == null) return;
                  var newSg = StudyGrammarSerializer()..grammar = gs.id
                                                  ..foreignUser = Global.localStore.user.id
                                                  ..category = category;
                  Global.localStore.user.studyGrammarSet.add(newSg);
                  await newSg.save();
                } else {
                  await sg.delete();
                  Global.localStore.user.studyGrammarSet.remove(sg);
                }
                Global.saveLocalStore();
                setState(() {});
              },
            ),
          ].where((e) => e != null).toList(),
        ),
        Padding(
          padding: EdgeInsets.only(left: 14),
          child: MarkDown(text: gs.content).render(),
        ),
      ],
    );

  Widget _distinguishSetShow(BuildContext context) => widget.word.distinguishSet.isNotEmpty ?
    OnOffWidget(
      label: Text('词义辨析', style: _labelStyle),
      child: Container(
        padding: EdgeInsets.only(top:14),
        child: ColumnSpace(
          divider: SizedBox(height: 8,),
          children: widget.word.distinguishSet.asMap().map((i, e) =>
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
              child: Icon(Icons.star, color: isFavoriteDistinguish(ds.id) == false ? Colors.black54 : Colors.redAccent, size: 14),
              onTap: () async {
                if(!isFavoriteDistinguish(ds.id)) {
                  Global.localStore.user.studyPlan.distinguishes.add(ds.id);
                } else {
                  Global.localStore.user.studyPlan.distinguishes.remove(ds.id);
                }
                await Global.localStore.user.studyPlan.save();
                Global.saveLocalStore();
                setState(() {});
              }
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 14),
          child: MarkDown(text:ds.content).render()
        ),
      ],
    );

   Widget _synonymsShow(BuildContext context) => widget.word.synonym.isNotEmpty ?
    OnOffWidget(
      label: Text('近义词', style: _labelStyle),
      child: Container(
        padding: EdgeInsets.only(top:14),
        child: Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: widget.word.synonym.map((e) =>
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
                  Navigator.pushNamed(context, '/show_word', arguments: {'title': '${widget.word.name}的近义词$e', 'word': w});
                }
              },
            )
          ).toList(),
        ),
      ),
    ) : null;

  Widget _antonymsShow(BuildContext context) => widget.word.antonym.isNotEmpty ?
    OnOffWidget(
      label: Text('反义词', style: _labelStyle),
      child: Container(
        padding: EdgeInsets.only(top:14),
        child: Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: widget.word.antonym.map((e) =>
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
                  Navigator.pushNamed(context, '/show_word', arguments: {'title': '${widget.word.name}的反义词$e', 'word': w});
                }
              },
            )
          ).toList(),
        ),
      ),
    ) : null;
}


