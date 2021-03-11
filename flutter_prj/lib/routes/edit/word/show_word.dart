import 'package:flutter/material.dart';
import 'package:flutter_prj/routes/edit/grammar/show_grammar.dart';
import 'package:flutter_prj/routes/edit/word/word_details.dart';
import 'package:flutter_prj/serializers/index.dart';


class ShowWord extends StatefulWidget {
  final WordSerializer _word;
  final Function _delete;

  ShowWord({Key key, WordSerializer word, Function delete})
    : _word = word,
      _delete = delete,
      super(key:key);

  @override
  _ShowWordState createState() => _ShowWordState();
}

class _ShowWordState extends State<ShowWord> {
  final TextStyle _style = TextStyle(fontSize: 12.0, color: Colors.greenAccent);
  List<bool> _onoff = [true, true, true];
  List<WordSerializer> _synonymWords = [];
  List<WordSerializer> _antonymWords = [];

  _buildOthers() =>
    Wrap(
      spacing: 10.0,
      children: [
        widget._word.grammarSet.length > 0 ?
        InkWell(
          child:Text('语法>>', style: _style,),
          onTap: () => setState(() => _onoff[0] = !_onoff[0]),
        ) : SizedBox(height: 0, width: 0,),
        widget._word.synonym.length > 0 ?
        InkWell(
          child: Text('同义词>>', style: _style,),
          onTap: () async {
            _onoff[1] = !_onoff[1];
            if(_onoff[1] == false) {
              _synonymWords.clear();
              await Future.forEach(widget._word.synonym,
                (e) async {
                  var s = WordSerializer()..name = e;
                  await s.retrieve(update:true);
                  _synonymWords.add(s);
                }
              );
              
            }
            setState(() {});
          },
        ) : SizedBox(height: 0, width: 0,),
        widget._word.antonym.length > 0 ?
        InkWell(
          child: Text('反义词>>', style: _style,),
          onTap: () async {
            _onoff[2] = !_onoff[2];
            if(_onoff[2] == false) {
              _antonymWords.clear();
              await Future.forEach(widget._word.antonym,
                (e) async {
                  var s = WordSerializer()..name = e;
                  await s.retrieve(update:true);
                  _antonymWords.add(s);
                }
              );
            }
            setState(() {});
          },
        ) : SizedBox(height: 0, width: 0,),
      ],
    );

  @override
  Widget build(BuildContext context) =>
  ListTile(
    title: Wrap(
      spacing: 10.0,
      children:[
        Text(widget._word.name),
        WordDetails(word: widget._word),
        _buildOthers(),
      ],
    ),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Offstage(
          offstage: _onoff[0],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget._word.grammarSet.map<Widget>(
              (e) => ShowGrammar(
                grammar: e,
                delete: () {
                  e.delete();
                  setState(() => widget._word.grammarSet.remove(e));
                },
                )
            ).toList(),
          ),
        ),
        Offstage(
          offstage: _onoff[1],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _synonymWords.map<Widget>(
              (e) => ShowWord(
                word: e,
                delete: () {
                  e.delete();
                  widget._word.synonym.remove(e.name);
                  setState(() => _synonymWords.remove(e));
                },
                )
            ).toList(),
          ),
        ),
        Offstage(
          offstage: _onoff[2],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _antonymWords.map<Widget>(
              (e) => ShowWord(
                word: e,
                delete: () {
                  e.delete();
                  widget._word.antonym.remove(e.name);
                  setState(() => _antonymWords.remove(e));
                },
                )
            ).toList(),
          ),
        )
      ],
    ),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          child: Text('编辑', style: TextStyle(color: Theme.of(context).primaryColor),),
          onTap: () async {
            WordSerializer word = WordSerializer().fromJson(widget._word.toJson());
            var s = (await Navigator.pushNamed(context, '/edit_word', arguments: {'title':'编辑单词','word':word})) as WordSerializer;
            if(s != null) {
              widget._word.fromJson(s.toJson());
              widget._word.update(update: true);
            }
            setState(() {});
          }
        ),
        SizedBox(width: 10,),
        widget._delete != null ?
        InkWell(
          child: Text('删除', style: TextStyle(color: Colors.pink,)),
          onTap: () => widget._delete(),
        ) : SizedBox(width: 0,),
      ],
    )
  );
}
