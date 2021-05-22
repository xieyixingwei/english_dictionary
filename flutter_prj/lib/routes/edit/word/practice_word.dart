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
  WrappedPlayer _audioPlayer = WrappedPlayer();

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        title: Text(
          '需学习 ${index+1}/${widget.words.length}  |  ${_preWord.name}',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black45
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black54),
          onPressed: ()=> Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(30),
          decoration: BoxDecoration(
            //border: BoxBorde()
          ),
          child: ColumnSpace(
            divider: SizedBox(height: 20,),
            children: [
              _word,
              _detail(context),
              _goto,
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
        widget.words[index].voiceUs != null && widget.words[index].voiceUs.isNotEmpty ?
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
  
  WordSerializer get _curWord => widget.words[index];
  WordSerializer get _preWord {
    num preIndex = index;
    if(index == 0) preIndex = widget.words.length - 1;
    else preIndex = index - 1;
    return  widget.words[preIndex];
  }

  Widget _detail(BuildContext context) =>
    TextButton(
      child: Text('detail', style: TextStyle(fontSize: 17),),
      onPressed: () => Navigator.pushNamed(context, '/show_word', arguments: {'title': '', 'word': _curWord}),
    );

  Widget get _goto =>
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 30, color: Colors.blueAccent,),
          splashRadius: 17,
          onPressed: () {
            if(index == 0) index = widget.words.length - 1;
            else index -= 1;
            setState(() {});
          },
        ),
        IconButton(
          icon: Icon(Icons.arrow_forward_ios, size: 30, color: Colors.blueAccent),
          splashRadius: 17,
          onPressed: () {
            if(index == widget.words.length - 1) index = 0;
            else index += 1;
            setState(() {});
          },
        ),
      ],
    );
}
