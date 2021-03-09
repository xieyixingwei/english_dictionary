import 'package:flutter/material.dart';
import 'package:flutter_prj/routes/edit/edit_sentence/sentence_details.dart';
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

  @override
  Widget build(BuildContext context) =>
  ListTile(
    title: Wrap(
      spacing: 10.0,
      children:[
        Text(widget._sentence.s_en),
        SentenceDetails(sentence: widget._sentence),
      ],
    ),
    subtitle: Text(widget._sentence.s_ch),
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
