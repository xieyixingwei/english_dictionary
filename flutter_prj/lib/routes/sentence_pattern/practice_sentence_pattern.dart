import 'package:audioplayers/audioplayers_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prj/routes/sentence_pattern/show_sentence_pattern.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/column_space.dart';
import 'package:flutter_prj/widgets/row_space.dart';


class PracticeSentencePattern extends StatefulWidget {
  PracticeSentencePattern({Key key, this.studySentencePatterns}) : super(key: key);

  final List<StudySentencePatternSerializer> studySentencePatterns;

  @override
  _PracticeSentencePatternState createState() => _PracticeSentencePatternState();
}

class _PracticeSentencePatternState extends State<PracticeSentencePattern> {
  final GlobalKey _formKey =  GlobalKey<FormState>();
  num index = 0;
  bool auto = false;
  bool cycle = true;
  var textCtrl = TextEditingController();
  WrappedPlayer _audioPlayer = WrappedPlayer();

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        titleSpacing: 3,
        title: Text(
          '${index+1}/${widget.studySentencePatterns.length}',
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
        centerTitle: false
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
                      initialValue: _curStudySentencePattern.familiarity.toString(),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${_curStudySentencePattern.familiarity}',
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
                        _curStudySentencePattern.familiarity = num.parse(v);
                        await _curStudySentencePattern.save();
                        setState(() {});
                      }
                    ),
                    SizedBox(width: 100,),
                  ],
                ),
                SizedBox(height: 10,),
                _sentencePattern(context),
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
                        labelText: '拼写',
                        border: OutlineInputBorder(),
                        suffix: TextButton(
                          child: Text('确定'),
                          onPressed: () {
                            (_formKey.currentState as FormState).validate();
                          }
                        )
                      ),
                      validator: (v) => v.trim() != _curSentencePattern.content ? 'Wrong' : null,
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

  Widget _sentencePattern(BuildContext context) =>
    ColumnSpace(
      divider: SizedBox(height: 10,),
      children: [
        RowSpace(
          mainAxisSize: MainAxisSize.min,
          divider: SizedBox(width: 8),
          children: [
            Offstage(
              offstage: !_curSentencePattern.offstage,
              child: IconButton(
                icon: Icon(Icons.more_horiz),
                onPressed: () => setState(() => _curSentencePattern.offstage = false)
              ),
            ),
            Offstage(
              offstage: _curSentencePattern.offstage,
              child: InkWell(
                child: Text(
                  _curSentencePattern.content,
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                  ),
                ),
                onTap: () => setState(() => _curSentencePattern.offstage = true),
                onDoubleTap: () =>
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShowSentencePatternPage(title: '固定表达', sentencePattern: _curSentencePattern,)
                    )
                  ),
              )
            )
          ]
        ),
      ],
    );

  void _next() {
    textCtrl.text = '';
    if(cycle && (index == widget.studySentencePatterns.length - 1)) index = 0;
    else if(index < (widget.studySentencePatterns.length - 1)) index += 1;
  }

  void _previous() {
    textCtrl.text = '';
    if(cycle && index == 0) index = widget.studySentencePatterns.length - 1;
    else if(index > 0) index -= 1;
  }
  SentencePatternSerializer get _curSentencePattern => widget.studySentencePatterns[index].sentencePattern;
  StudySentencePatternSerializer get _curStudySentencePattern => widget.studySentencePatterns[index];

  Widget get _sentences =>
    ColumnSpace(
      divider: SizedBox(height: 7,),
      children: _curSentencePattern.paraphraseSet.map<Widget>((e) =>
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
          },
        ),
        IconButton(
          icon: Icon(Icons.arrow_forward_ios, size: 30, color: Colors.blueAccent),
          splashRadius: 17,
          onPressed: () {
            _next();
            setState(() {});
          },
        ),
      ],
    );
}
