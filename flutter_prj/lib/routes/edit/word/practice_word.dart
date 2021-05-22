import 'dart:async';

import 'package:audioplayers/audioplayers_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/column_space.dart';


class PracticeWord extends StatefulWidget {
  PracticeWord({Key key, this.title, this.words}) : super(key: key);

  final Widget title;
  final List<WordSerializer> words;

  @override
  _PracticeWordState createState() => _PracticeWordState();
}

class _PracticeWordState extends State<PracticeWord> {
  num index = 0;
  bool auto = false;
  bool cycle = true;
  WrappedPlayer _audioPlayer = WrappedPlayer();
  final _style = TextStyle(fontSize: 14, color: Colors.black45);
  Timer timer;

  void _timerCallback(Timer t) {
    _next();

    if(_curWord.audioUsMan == null) return; _audioPlayer.setUrl(_curWord.audioUsMan); _audioPlayer.start(0);
    if(cycle == false && (index == widget.words.length - 1)) {timer.cancel(); auto = false;}
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
          '${index+1}/${widget.words.length}  |  ${_preWord.name}',
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
                    timer = Timer.periodic(Duration(seconds: 3), _timerCallback);
                    _audioPlayer.setVolume(0);
                    widget.words.forEach((e) {
                      if(e.audioUsMan != null && e.audioUsMan.isNotEmpty) {
                        _audioPlayer.setUrl(e.audioUsMan);
                        _audioPlayer.start(0);
                      }
                    });
                    _audioPlayer.setVolume(0.8);
                    if(_curWord.audioUsMan == null || _curWord.audioUsMan.isEmpty) return;
                    _audioPlayer.setUrl(_curWord.audioUsMan);
                    _audioPlayer.start(0);
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
      body: Center(
        child: Container(
          margin: EdgeInsets.fromLTRB(10, 100, 10, 30),
          decoration: BoxDecoration(
            //border: BoxBorde()
          ),
          child: ColumnSpace(
            divider: SizedBox(height: 20,),
            children: [
              _word,
              _detail(context),
              auto ? null : _goto,
            ],
          ),
        )
      ),
    );

  Widget get _word =>
    ColumnSpace(
      divider: SizedBox(height: 10,),
      children: [
        InkWell(
          child: Text(
            _curWord.name,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w700,
              fontSize: 28,
            ),
          ),
          onTap: () async {if(_curWord.audioUsMan == null) return; _audioPlayer.setUrl(_curWord.audioUsMan); _audioPlayer.start(0);},
        ),
        _curWord.voiceUs != null && _curWord.voiceUs.isNotEmpty ?
        Text(
          _curWord.voiceUs,
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.normal,
            fontSize: 20,
          ),
        ) : null,
      ],
    );

  void _next() {
    if(cycle && (index == widget.words.length - 1)) index = 0;
    else if(index < (widget.words.length - 1)) index += 1;
  }
  void _previous() {
    if(cycle && index == 0) index = widget.words.length - 1;
    else if(index > 0) index -= 1;
  }
  WordSerializer get _curWord => widget.words[index];
  WordSerializer get _preWord {
    num preIndex = index;
    if(cycle && index == 0) preIndex = widget.words.length - 1;
    else if(index > 0) preIndex = index - 1;
    else preIndex = 0;
    return  widget.words[preIndex];
  }

  Widget _detail(BuildContext context) =>
    IconButton(
      icon: Icon(Icons.more_horiz),
      onPressed: () async {
        if(timer != null && timer.isActive) timer.cancel();
        await Navigator.pushNamed(context, '/show_word', arguments: {'title': '', 'word': _curWord});
        if(auto) timer = Timer.periodic(Duration(seconds: 3), _timerCallback);
      },
    );

  Widget get _goto =>
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 30, color: Colors.blueAccent,),
          splashRadius: 17,
          onPressed: () => setState(() => _previous()),
        ),
        IconButton(
          icon: Icon(Icons.arrow_forward_ios, size: 30, color: Colors.blueAccent),
          splashRadius: 17,
          onPressed: () => setState(() => _next()),
        ),
      ],
    );
}
