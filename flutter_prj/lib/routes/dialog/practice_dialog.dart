import 'package:audioplayers/audioplayers_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/column_space.dart';


class PracticeDialog extends StatefulWidget {
  PracticeDialog({Key key, this.title, this.dialog}) : super(key: key);

  final String title;
  final DialogSerializer dialog;

  @override
  _PracticeDialogState createState() => _PracticeDialogState();
}

class _PracticeDialogState extends State<PracticeDialog> {
  num index = -1;
  bool auto = false;
  bool reverse = false;
  List<SentenceSerializer> sentences = [];
  WrappedPlayer _audioPlayer = WrappedPlayer();
  final _style = TextStyle(fontSize: 14, color: Colors.black45);


  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        leading: IconButton(
          splashRadius: 1,
          icon: Icon(Icons.arrow_back_ios, color: Colors.black54),
          onPressed: ()=> Navigator.pop(context),
        ),
        titleSpacing: 3,
        centerTitle: false,
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black45
          )
        ),
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('互换', style: _style,),
              SizedBox(width: 3,),
              Switch(
                value: reverse,
                onChanged: (v) => setState(() => reverse = v),
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
                    //timer = Timer.periodic(Duration(seconds: 3), _timerCallback);
                    //if(_curWord.audioUsMan == null) return; _audioPlayer.setUrl(_curWord.audioUsMan); _audioPlayer.start(0);
                  } else {
                    //timer.cancel();
                  }
                  setState(() {auto = v;});
                },
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(6, 10, 6, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ColumnSpace(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: sentences.asMap().map((i, v) => 
                MapEntry(i, _sentence(i, v))
              ).values.toList(),
            ),
            _ok,
          ]
        )
      )
    );

  Widget _sentence(num index, SentenceSerializer s) =>
    index % 2 == 0 ? (reverse ? _sentenceB(s) : _sentenceA(s)) : (reverse ? _sentenceA(s) :_sentenceB(s));

  Widget _sentenceA(SentenceSerializer s) =>
    Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: Colors.blueAccent)
      ),
      child: ColumnSpace(
        crossAxisAlignment: reverse ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
        InkWell(
          child: Text(
            s.en,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 17,
            ),
          ),
          onTap: () {
            if(s.enVoice.isEmpty) return;
            _audioPlayer.setUrl(s.enVoice);
            _audioPlayer.start(0);
          },
        ),
        Text(
          s.cn,
          style: TextStyle(
            color: Colors.black45,
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ],
    )
  );

  Widget _sentenceB(SentenceSerializer s) =>
    Container(
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: Colors.deepOrange)
      ),
      child: ColumnSpace(
        crossAxisAlignment: reverse ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          InkWell(
            child: Text(
              s.cn,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ),
            ),
            onTap: () async {
              s.offstage = !s.offstage;
              if(s.synonym.isNotEmpty && s.synonymObjes.isEmpty) {
                await Future.forEach<num>(s.synonym, (id) async {
                  var ss = SentenceSerializer()..id = id;
                  var ret = await ss.retrieve();
                  if(ret) s.synonymObjes.add(ss);
                });
              }
              setState(() {});
            },
          ),
          Offstage(
            offstage: s.offstage,
            child: Column(
              crossAxisAlignment: reverse ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                InkWell(
                  child: Text(
                    s.en,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 17,
                    ),
                  ),
                  onTap: () {
                    if(s.enVoice.isEmpty) return;
                    _audioPlayer.setUrl(s.enVoice);
                    _audioPlayer.start(0);
                  },
                ),
              ] + s.synonymObjes.map((se) =>
                InkWell(
                  child: Text(
                    se.en,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 17,
                    ),
                  ),
                  onTap: () {
                    if(se.enVoice.isEmpty) return;
                    _audioPlayer.setUrl(se.enVoice);
                    _audioPlayer.start(0);
                  },
                )
              ).toList()
            ),
          ),
        ],
      )
    );

  void _next() {
    if(index < (widget.dialog.sentenceSet.length - 1)) index += 1;
  }

  SentenceSerializer get _curSentence => widget.dialog.sentenceSet[index];

  Widget get _ok =>
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.navigate_next, size: 30, color: Colors.blueAccent,),
          splashRadius: 17,
          onPressed: () {
            if(index >= (widget.dialog.sentenceSet.length - 1)) return;
            _next();
            sentences.add(_curSentence);
            setState(() {});
          }
        ),
      ],
    );
}
