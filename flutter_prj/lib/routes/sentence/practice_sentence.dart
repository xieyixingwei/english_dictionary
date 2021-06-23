import 'package:audioplayers/audioplayers_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prj/common/http.dart';
import 'package:flutter_prj/markdown/style.dart';
import 'package:flutter_prj/routes/common/common.dart';
import 'package:flutter_prj/routes/common/familiarity.dart';
import 'package:flutter_prj/routes/common/practice_actions.dart';
import 'package:flutter_prj/routes/sentence/edit_study_sentence.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/column_space.dart';
import 'package:flutter_prj/widgets/row_space.dart';


class PracticeSentence extends StatefulWidget {
  PracticeSentence({Key key, this.title, this.studySentences}) : super(key: key);

  final Widget title;
  final List<StudySentenceSerializer> studySentences;

  @override
  _PracticeSentenceState createState() => _PracticeSentenceState();
}

class _PracticeSentenceState extends State<PracticeSentence> {
  num index = 0;
  bool _hide = true;
  num tabIndex = 0;
  WrappedPlayer _audioPlayer = WrappedPlayer();
  final _textCtrl = TextEditingController();

  final _actions = [
      {
        'label': '英汉',
        'value': false
      },
      {
        'label': '循环',
        'value': true,
      },
      {
        'label': '自动',
        'value': false,
      },
    ];

  _actionValue(String label) => _actions.singleWhere((e) => e['label'] == label)['value'];

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    await Future.forEach<StudySentenceSerializer>(widget.studySentences, (e) async {
      if(e.sentence.updateSynonum == false) {
        var ret = await e.sentence.retrieve();
        if(ret) e.sentence.updateSynonum = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        titleSpacing: 3,
        title: Text(
          '${index + 1}/${widget.studySentences.length}',
          style: TextStyle(fontSize: 14, color: Colors.black45),
        ),
        leading: IconButton(
          splashRadius: 1,
          icon: Icon(Icons.arrow_back_ios, color: Colors.black54),
          onPressed: ()=> Navigator.pop(context),
        ),
        centerTitle: false,
        actions: practiceActionsWidget(_actions, () => setState(() {})),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(6, 30, 6, 30),
          child: ColumnSpace(
            divider: SizedBox(height: 14,),
            children: [
              _sentence,
              _attached(context),
              _bottom(context),
              _actionValue('自动') ? null : _goto,
            ],
          ),
        )
      ),
    );

  _next() {
    if(index < (widget.studySentences.length - 1)) index += 1;
    else if(_actionValue('循环')) index = 0;
    _textCtrl.text = '';
    tabIndex = 0;
  }

  _previous() {
    if(index > 0) index -= 1;
    else if(_actionValue('循环')) index = widget.studySentences.length - 1;
    _textCtrl.text = '';
    tabIndex = 0;
  }

  SentenceSerializer get _curSentence => widget.studySentences[index].sentence;
  StudySentenceSerializer get _curStudySentence => widget.studySentences[index];

  _playCurSentenceEn(SentenceSerializer s) {
    if(s.enVoice.isEmpty) return;
    var url = s.enVoice.startsWith('http') ? s.enVoice : Http.baseUrl + s.enVoice;
    _audioPlayer.setUrl(url);
    _audioPlayer.start(0);
  }

  void _playCurWordAudio(WordSerializer w) {
    if(w.audioUsMan.isEmpty) return;
    var url = w.audioUsMan.startsWith('http') ? w.audioUsMan : Http.baseUrl + w.audioUsMan;
    _audioPlayer.setUrl(url);
    _audioPlayer.start(0);
  }

  Widget get _sentence =>
    ColumnSpace(
      divider: SizedBox(height: 10,),
      children: [
        _sentenceA(_curSentence, _actionValue('英汉')),
        Offstage(
          offstage: !_hide,
          child: IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () => setState(() => _hide = false),
          )
        ),
        Offstage(
          offstage: _hide,
          child: ColumnSpace(
            children: <Widget>[
              _sentenceB(_curSentence, _actionValue('英汉')),
            ] + _curSentence.synonym.map<Widget>((e) =>
              _synonymSentence(e)
            ).toList()
          ),
        ),
      ],
    );

  Widget _sentenceA(SentenceSerializer s, bool en2cn) =>
    InkWell(
      child: Text(
        en2cn ? s.en : s.cn,
        style: const TextStyle(fontSize: 17, color: Colors.black54, fontWeight: FontWeight.w700),
      ),
      onTap: () {
        if(en2cn == false) return;
        _playCurSentenceEn(s);
      }
    );

  Widget _sentenceB(SentenceSerializer s, bool en2cn) =>
    InkWell(
      child: Text(
        en2cn ? s.cn : s.en,
        style: const TextStyle(fontSize: 17, color: Colors.black54, fontWeight: FontWeight.normal),
      ),
      onTap: () {
        if(en2cn) return;
        _playCurSentenceEn(s);
      }
    );

  Widget _synonymSentence(SentenceSerializer s) =>
    InkWell(
      child: Text(
        s.en,
        style: const TextStyle(fontSize: 17, color: Colors.black54, fontWeight: FontWeight.normal),
      ),
      onTap: () {
        _playCurSentenceEn(s);
      }
    );

  String _paraphrases2Str(List<ParaphraseSerializer> paraphrases) {
    var ps = sortParaphraseSet(paraphrases);
    return ps.map((p) => p.keys.first + '  ' + p.values.first.map((ps) => ps.interpret).join('；')).join('\n');
  }

  Widget _attached(BuildContext context) {
    var labels = <String>[];
    var contents = <Widget>[];
    _curStudySentence.newWords.forEach((e) {
      labels.add(e.name);
      contents.add(
        Text(
          _paraphrases2Str(e.paraphraseSet),
          style: const TextStyle(fontSize: 17, color: Colors.black54)
        )
      );
    });
    _curStudySentence.newSentencePatterns.forEach((e) {
      labels.add(e.content);
      contents.add(
        Text(
          _paraphrases2Str(e.paraphraseSet),
          style: const TextStyle(fontSize: 17, color: Colors.black54)
        )
      );
    });

    return Offstage(
      offstage: _curStudySentence.hideNewWords,
      child: ColumnSpace(
        divider: SizedBox(height: 10,),
        children: [
        _tabs(labels, contents,
          (String label, num index) {
            if(tabIndex == index) {
              var w = _curStudySentence.newWords.singleWhere((e) => e.name == label, orElse: () => null);
              if(w != null) _playCurWordAudio(w);
            } else {
              tabIndex = index;
              setState(() {});
            }
          },
          (String label) async {
            var w = _curStudySentence.newWords.singleWhere((e) => e.name == label, orElse: () => null);
            if(w != null) {
              await Navigator.pushNamed(context, '/show_word', arguments: {'title': '', 'word': w});
              return;
            }
            var sp = _curStudySentence.newSentencePatterns.singleWhere((e) => e.content == label, orElse: () => null);
            if(sp != null) {
              await Navigator.pushNamed(context, '/show_sentence_pattern', arguments: {'title': '', 'sentencePattern': sp});
              return;
            }
          }
        ),
        Container(
          width: 240,
          child: TextFormField(
            maxLines: 1,
            controller: _textCtrl,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              isDense: true,
              labelText: '单词拼写',
              suffix: IconButton(
                icon: Icon(Icons.clear, color: Colors.black54,),
                onPressed: () => _textCtrl.text = ''
              ),
              border: OutlineInputBorder(),
            )
          )
        )],
      )
    );
  }

  Widget _tabs(List<String> labels, List<Widget> contents, Function(String, num) onTap, Function(String) onDoubleTap) =>
    ColumnSpace(
      divider: SizedBox(height: 10,),
      children: [
        Container(
          height: 20,
          child: ListView(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            scrollDirection: Axis.horizontal,
            children: labels.asMap().map((i, e) =>
              MapEntry(i,
                Container(
                  margin: EdgeInsets.only(left: 6, right: 6),
                  child: InkWell(
                    child: Text(e, style: TextStyle(fontSize: 17, color: tabIndex == i ? Colors.blueAccent : Colors.blueGrey)),
                    onTap: () => onTap(e, i),
                    onDoubleTap: () => onDoubleTap(e),
                  )
                )
              )
            ).values.toList(),
          ),
        ),
        contents.isNotEmpty ? contents[tabIndex] : null
      ],
    );

  Widget _bottom(BuildContext context) =>
    RowSpace(
      mainAxisSize: MainAxisSize.min,
      divider: SizedBox(width: 14,),
      children: [
        TextButton(
          child: Text('编辑生词'),
          onPressed: () async {
            var ss = await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EditStudySentencePage(title: '编辑生词', studySentence: _curStudySentence,),
                            )
                          );
            if(ss != null) await _curStudySentence.from(ss).save();
            setState(() {});
          },
        ),
        TextButton(
          child: Text(_curStudySentence.hideNewWords ? '显示生词' : '隐藏生词'),
          onPressed: () => setState(() => _curStudySentence.hideNewWords = !_curStudySentence.hideNewWords),
        ),
        familiarityWidget(
          context,
          _curStudySentence.familiarity,
          (v) async {
            _curStudySentence.familiarity = v;
            await _curStudySentence.save();
            setState(() {});
          }
        )
      ],
    );

  Widget get _goto =>
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 30, color: Colors.blueAccent,),
          onPressed: () => setState(() {_hide = true; _previous();}),
        ),
        IconButton(
          icon: Icon(Icons.arrow_forward_ios, size: 30, color: Colors.blueAccent),
          onPressed: () => setState(() {_hide = true; _next();}),
        ),
      ],
    );
}
