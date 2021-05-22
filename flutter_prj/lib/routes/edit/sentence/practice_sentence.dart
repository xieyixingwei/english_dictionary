import 'dart:async';

import 'package:audioplayers/audioplayers_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/column_space.dart';


class PracticeSentence extends StatefulWidget {
  PracticeSentence({Key key, this.title, this.sentences}) : super(key: key);

  final Widget title;
  final List<SentenceSerializer> sentences;

  @override
  _PracticeSentenceState createState() => _PracticeSentenceState();
}

class _PracticeSentenceState extends State<PracticeSentence> {
  num index = 0;
  bool auto = false;
  bool cycle = true;
  bool order = false;
  bool _hide = true;
  //WrappedPlayer _audioPlayer = WrappedPlayer();
  final _style = TextStyle(fontSize: 14, color: Colors.black45);
  final _style2 = TextStyle(color: Colors.black54, fontWeight: FontWeight.normal, fontSize: 17);
  //Timer timer;

  void _timerCallback(Timer t) {
    _next();

    //if(_curWord.audioUsMan == null) return; _audioPlayer.setUrl(_curWord.audioUsMan); _audioPlayer.start(0);
    //if(cycle == false && (index == widget.words.length - 1)) {timer.cancel(); auto = false;}
    setState((){});
  }

  @override
  void dispose() {
    //if(timer != null && timer.isActive) timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        titleSpacing: 3,
        title: Text(
          '${index+1}/${widget.sentences.length}',
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
              Text('英汉', style: _style,),
              SizedBox(width: 3,),
              Switch(
                value: order,
                onChanged: (v) => setState(() => order = v),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('循环', style: _style,),
              SizedBox(width: 3,),
              Switch(
                value: cycle,
                onChanged: (v) => setState(() => cycle = v),
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
      body: Center(
        child: Container(
          margin: EdgeInsets.fromLTRB(10, 100, 10, 30),
          decoration: BoxDecoration(
            //border: BoxBorde()
          ),
          child: ColumnSpace(
            divider: SizedBox(height: 20,),
            children: [
              Container(
                height: 200,
                child: _sentence,
              ),
              //_detail(context),
              auto ? null : _goto,
            ],
          ),
        )
      ),
    );

  Widget get _sentence =>
    ColumnSpace(
      divider: SizedBox(height: 10,),
      children: [
        Text(
          order ? _curSentence.en : _curSentence.cn,
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w700,
            fontSize: 17,
          ),
        ),
        Offstage(
          offstage: !_hide,
          child: IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () => setState(() => _hide = false),
          )
        ),
        _detail(),
      ],
    );

  void _next() {
    if(cycle && (index == widget.sentences.length - 1)) index = 0;
    else if(index < (widget.sentences.length - 1)) index += 1;
  }
  void _previous() {
    if(cycle && index == 0) index = widget.sentences.length - 1;
    else if(index > 0) index -= 1;
  }
  SentenceSerializer get _curSentence => widget.sentences[index];

  Widget _detail() =>
    Offstage(
      offstage: _hide,
      child: InkWell(
        child: Column(
          children: [
            Text(
              order ? _curSentence.cn : _curSentence.en,
              style: _style2,
            ),
          ],
        ),
        onTap: () => setState(() => _hide = true),
      )
    );

  Widget get _goto =>
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 30, color: Colors.blueAccent,),
          splashRadius: 17,
          onPressed: () => setState(() {_hide = true; _previous();}),
        ),
        IconButton(
          icon: Icon(Icons.arrow_forward_ios, size: 30, color: Colors.blueAccent),
          splashRadius: 17,
          onPressed: () => setState(() {_hide = true; _next();}),
        ),
      ],
    );
}
