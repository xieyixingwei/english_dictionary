import 'package:flutter/material.dart';
import 'package:flutter_prj/routes/edit/sentence/sentence_details.dart';
import 'package:flutter_prj/routes/edit/grammar/show_grammar.dart';
import 'package:flutter_prj/serializers/index.dart';


class ShowSentence extends StatefulWidget {
  final SentenceSerializer _sentence;
  final Function _delete;

  ShowSentence({Key key, SentenceSerializer sentence, Function delete})
    : _sentence = sentence,
      _delete = delete,
      super(key:key);

  @override
  _ShowSentenceState createState() => _ShowSentenceState();
}

class _ShowSentenceState extends State<ShowSentence> {
  final TextStyle _style = TextStyle(fontSize: 12.0, color: Colors.greenAccent);
  List<bool> _onoff = [true, true, true];
  List<SentenceSerializer> _synonymSentences = [];
  List<SentenceSerializer> _antonymSentences = [];

  _buildOthers() =>
    Wrap(
      spacing: 10.0,
      children: [
        widget._sentence.sentence_grammar.length > 0 ?
        InkWell(
          child:Text('语法>>', style: _style,),
          onTap: () => setState(() => _onoff[0] = !_onoff[0]),
        ) : SizedBox(height: 0, width: 0,),
        widget._sentence.s_synonym.length > 0 ?
        InkWell(
          child: Text('同义句>>', style: _style,),
          onTap: () async {
            _onoff[1] = !_onoff[1];
            if(_onoff[1] == false) {
              _synonymSentences.clear();
              await Future.forEach(widget._sentence.s_synonym,
                (e) async {
                  var s = SentenceSerializer()..s_id = e;
                  await s.retrieve(update:true);
                  _synonymSentences.add(s);
                }
              );
              
            }
            setState(() {});
          },
        ) : SizedBox(height: 0, width: 0,),
        widget._sentence.s_antonym.length > 0 ?
        InkWell(
          child: Text('反义句>>', style: _style,),
          onTap: () async {
            _onoff[2] = !_onoff[2];
            if(_onoff[2] == false) {
              _antonymSentences.clear();
              await Future.forEach(widget._sentence.s_antonym,
                (e) async {
                  var s = SentenceSerializer()..s_id = e;
                  await s.retrieve(update:true);
                  _antonymSentences.add(s);
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
        Text(widget._sentence.s_en),
        SentenceDetails(sentence: widget._sentence),
        _buildOthers(),
      ],
    ),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget._sentence.s_ch),
        Offstage(
          offstage: _onoff[0],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget._sentence.sentence_grammar.map<Widget>(
              (e) => ShowGrammar(
                grammar: e,
                delete: () {
                  e.delete();
                  setState(() => widget._sentence.sentence_grammar.remove(e));
                },
                )
            ).toList(),
          ),
        ),
        Offstage(
          offstage: _onoff[1],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _synonymSentences.map<Widget>(
              (e) => ShowSentence(
                sentence: e,
                delete: () {
                  e.delete();
                  widget._sentence.s_synonym.remove(e.s_id);
                  setState(() => _synonymSentences.remove(e));
                },
                )
            ).toList(),
          ),
        ),
        Offstage(
          offstage: _onoff[2],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _antonymSentences.map<Widget>(
              (e) => ShowSentence(
                sentence: e,
                delete: () {
                  e.delete();
                  widget._sentence.s_antonym.remove(e.s_id);
                  setState(() => _antonymSentences.remove(e));
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
            SentenceSerializer sentence = SentenceSerializer().fromJson(widget._sentence.toJson());
            var s = (await Navigator.pushNamed(context, '/edit_sentence', arguments: {'title':'编辑句子','sentence':sentence})) as SentenceSerializer;
            if(s != null) {
              widget._sentence.fromJson(s.toJson());
              widget._sentence.save();
            }
            setState(() {});
          }
        ),
        SizedBox(width: 10,),
        widget._delete != null ?
        InkWell(
          child: Text('删除', style: TextStyle(color: Colors.pink,)),
          onTap: () {widget._sentence.delete(); widget._delete();},
        ) : SizedBox(width: 0,),
      ],
    )
  );
}
