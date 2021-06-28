import 'dart:async';
import 'package:audioplayers/audioplayers_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prj/common/http.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/column_space.dart';
import 'package:flutter_prj/widgets/row_space.dart';


class PracticeWord extends StatefulWidget {
  PracticeWord({Key key, this.title, this.studyWords}) : super(key: key);

  final Widget title;
  final List<StudyWordSerializer> studyWords;

  @override
  _PracticeWordState createState() => _PracticeWordState();
}

class _PracticeWordState extends State<PracticeWord> {
  final GlobalKey _formKey =  GlobalKey<FormState>();
  num index = 0;
  bool auto = false;
  bool cycle = true;
  bool autoPronun = false;
  var textCtrl = TextEditingController();
  WrappedPlayer _audioPlayer = WrappedPlayer();
  final _style = TextStyle(fontSize: 14, color: Colors.black45);
  Timer timer;

  void _timerCallback(Timer t) {
    _next();

    _playCurWordAudio();
    if(cycle == false && (index == widget.studyWords.length - 1)) {timer.cancel(); auto = false;}
    setState((){});
  }

  @override
  void dispose() {
    if(timer != null && timer.isActive) timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        titleSpacing: 3,
        title: Text(
          '${index+1}/${widget.studyWords.length}  |  ${_preWord.name}',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black45
          ),
        ),
        leading: IconButton(
          splashRadius: 1,
          icon: Icon(Icons.arrow_back_ios, color: Colors.black54),
          onPressed: ()=> Navigator.pop(context),
        ),
        centerTitle: false,
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('自动发音', style: _style,),
              SizedBox(width: 3,),
              Switch(
                value: autoPronun,
                onChanged: (v) {
                  autoPronun = v;
                  setState(() {});
                  if(autoPronun) {
                    _playCurWordAudio();
                  }
                },
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('自动', style: _style,),
              SizedBox(width: 3,),
              Switch(
                value: auto,
                onChanged: (v) {
                  if(v) {
                    timer = Timer.periodic(Duration(seconds: 3), _timerCallback);
                    _playCurWordAudio();
                  } else {
                    timer.cancel();
                  }
                  setState(() {auto = v;});
                },
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.fromLTRB(10, 20, 10, 30),
            decoration: BoxDecoration(
              //border: BoxBorde()
            ),
            child: ColumnSpace(
              divider: SizedBox(height: 15,),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PopupMenuButton<String> (
                      padding: EdgeInsets.all(5), // 菜单项的内边距
                      offset: Offset(0, 0),       // 控制菜单弹出的位置()
                      initialValue: _curStudyWord.familiarity.toString(),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${_curStudyWord.familiarity}',
                              style: TextStyle(color: Colors.blueAccent, fontSize: 17)
                            ),
                            TextSpan(
                              text: ' 熟悉度',
                              style: TextStyle(color: Colors.black45, fontSize: 14)
                            ),
                          ]
                        )
                      ),
                      itemBuilder: (context) =>
                        ['0', '1', '2', '3', '4', '5'].map((String e) =>
                          PopupMenuItem<String>(
                            value: e,
                            textStyle: const TextStyle(fontWeight: FontWeight.w600), // 文本样式
                            child: Text(e, style: const TextStyle(color: Colors.blue) ),    // 子控件
                          )
                        ).toList(),
                      onSelected: (v) async {
                        _curStudyWord.familiarity = num.parse(v);
                        await _curStudyWord.save();
                        setState(() {});
                      }
                    ),
                    SizedBox(width: 100,),
                  ],
                ),
                SizedBox(height: 10,),
                _word(context),
                _sentences,
                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.disabled, //关闭开启自动校验
                  child: Container(
                    margin: EdgeInsets.only(left: 50, right: 50),
                    child: TextFormField(
                      maxLines: 1,
                      controller: textCtrl,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: '单词拼写',
                        isDense: true,
                        border: OutlineInputBorder(),
                        suffix: TextButton(
                          child: Text('确定'),
                          onPressed: () => (_formKey.currentState as FormState).validate(),
                        )
                      ),
                      validator: (v) => v.trim() != _curWord.name ? 'Wrong' : null,
                    )
                  )
                ),
                auto ? null : _goto,
              ],
            ),
          )
        ),
      )
    );

  Widget _word(BuildContext context) =>
    ColumnSpace(
      divider: SizedBox(height: 10,),
      children: [
        RowSpace(
          mainAxisSize: MainAxisSize.min,
          divider: SizedBox(width: 8),
          children: [
            Offstage(
              offstage: !_curWord.offstage,
              child: IconButton(
                icon: Icon(Icons.more_horiz),
                onPressed: () => setState(() => _curWord.offstage = false)
              ),
            ),
            Offstage(
              offstage: _curWord.offstage,
              child: InkWell(
                child: Text(
                  _curWord.name,
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                  ),
                ),
                onTap: () => setState(() => _curWord.offstage = true),
                onDoubleTap: () async {
                  if(timer != null && timer.isActive) timer.cancel();
                  if(_curWord.studyWordSet.isEmpty) {
                    var sw = StudyWordSerializer()..id = _curStudyWord.id
                                                  ..foreignUser = _curStudyWord.foreignUser
                                                  ..inplan = _curStudyWord.inplan;
                    _curWord.studyWordSet.add(sw);
                  }
                  await Navigator.pushNamed(context, '/show_word', arguments: {'title': '', 'word': _curWord});
                  if(auto) timer = Timer.periodic(Duration(seconds: 3), _timerCallback);
                },
              )
            ),
            IconButton(
              icon: Icon(Icons.volume_up),
              onPressed: () => _playCurWordAudio(),
            )
          ]
        ),
        _curWord.voiceUs.isNotEmpty ?
        Text(
          _curWord.voiceUs,
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.normal,
            fontFamily: 'Arial',
            fontSize: 20,
          ),
        ) : null,
        _curWord.shorthand.isNotEmpty ?
        Text(
          _curWord.shorthand,
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.normal,
            fontSize: 15,
          ),
        ) : null,
      ],
    );

  void _next() {
    var dt = DateTime.now().toLocal().toString().substring(0, 10);
    if(!_curStudyWord.learnRecord.contains(dt)) _curStudyWord.learnRecord.insert(0, dt);
    if(_curStudyWord.learnRecord.length > 7) _curStudyWord.learnRecord.removeRange(7, _curStudyWord.learnRecord.length);
    _curStudyWord.repeats++;
    _curStudyWord.save();
    textCtrl.text = '';
    if(cycle && (index == widget.studyWords.length - 1)) index = 0;
    else if(index < (widget.studyWords.length - 1)) index += 1;
  }

  void _previous() {
    textCtrl.text = '';
    if(cycle && index == 0) index = widget.studyWords.length - 1;
    else if(index > 0) index -= 1;
  }
  WordSerializer get _curWord => widget.studyWords[index].word;
  StudyWordSerializer get _curStudyWord => widget.studyWords[index];
  WordSerializer get _preWord {
    num preIndex = index;
    if(cycle && index == 0) preIndex = widget.studyWords.length - 1;
    else if(index > 0) preIndex = index - 1;
    else preIndex = 0;
    return  widget.studyWords[preIndex].word;
  }

  Widget get _sentences =>
    ColumnSpace(
      divider: SizedBox(height: 7,),
      children: _curWord.paraphraseSet.map<Widget>((e) =>
        Column(
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: '${e.partOfSpeech}  ', style: TextStyle(fontSize: 17, color: Colors.black87)),
                  TextSpan(text: e.interpret, style: TextStyle(fontSize: 17, color: Colors.black87, fontWeight: FontWeight.w800)),
                ]
              )
            ),
            ColumnSpace(
              divider: SizedBox(height: 3,),
              children: e.sentenceSet.map((s) =>
                _sentence(s)
              ).toList(),
            ),
          ],
        )
      ).toList(),
    );

  Widget _sentence(SentenceSerializer s) =>
    ColumnSpace(
      children: [
        InkWell(
          child: Text(s.cn, style: TextStyle(fontSize: 14, color: Colors.black54),),
          onTap: () => setState(() => s.offstage = !s.offstage),
        ),
        Offstage(
          offstage: s.offstage,
          child: InkWell(
            child: Text(s.en, style: TextStyle(fontSize: 14, color: Colors.black54),),
            onTap: () {
              if(s.enVoice.isEmpty) return;
              _audioPlayer.setUrl(s.enVoice);
              _audioPlayer.start(0);
            },
          ),
        )
      ]
    );

  Widget get _goto =>
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 30, color: Colors.blueAccent,),
          splashRadius: 17,
          onPressed: () {
            _previous();
            setState(() {});
            if(autoPronun) {
              _playCurWordAudio();
            }
          },
        ),
        IconButton(
          icon: Icon(Icons.arrow_forward_ios, size: 30, color: Colors.blueAccent),
          splashRadius: 17,
          onPressed: () {
            _next();
            setState(() {});
            if(autoPronun) {
              _playCurWordAudio();
            }
          },
        ),
      ],
    );

  void _playCurWordAudio() {
    if(_curWord.audioUsMan.isEmpty) return;
    _audioPlayer.setUrl(Http.baseUrl + _curWord.audioUsMan);
    _audioPlayer.start(0);
  }
}
