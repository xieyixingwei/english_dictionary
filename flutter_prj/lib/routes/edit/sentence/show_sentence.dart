import 'package:flutter/material.dart';
import 'package:flutter_prj/routes/edit/sentence/sentence_details.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/edit_delete.dart';


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
    leading: Text('id[${widget._sentence.id}]', style: TextStyle(fontSize: 12, color: Colors.deepOrange),),
    title: Wrap(
      spacing: 10.0,
      children:[
        Text(widget._sentence.en),
        SentenceDetails(sentence: widget._sentence),
      ],
    ),
    trailing: EditDelete(
      edit: () async {
        var sentence = (await Navigator.pushNamed(context, '/edit_sentence', arguments: {'title':'编辑句子','sentence':SentenceSerializer().from(widget._sentence)})) as SentenceSerializer;
        if(sentence != null) await widget._sentence.from(sentence).save();
        setState(() {});
      },
      delete: widget._delete,
    ),
  );
}

