import 'package:flutter/material.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/edit_delete.dart';


class ShowSentencePattern extends StatefulWidget {
  final SentencePatternSerializer _sentencePattern;
  final Function _delete;

  ShowSentencePattern({Key key, SentencePatternSerializer sentencePattern, Function delete})
    : _sentencePattern = sentencePattern,
      _delete = delete,
      super(key:key);

  @override
  _ShowSentencePatternState createState() => _ShowSentencePatternState();
}

class _ShowSentencePatternState extends State<ShowSentencePattern> {

  @override
  Widget build(BuildContext context) {
    String paraphrase = widget._sentencePattern.paraphraseSet.map((e) => e.interpret).toList().join('、');
    return ListTile(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('id[${widget._sentencePattern.id}] ', style: TextStyle(fontSize: 14, color: Colors.deepOrange),),
          Text('[${widget._sentencePattern.content}] ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
          Text('释义: $paraphrase', style: TextStyle(fontSize: 14),),
        ]
      ),
      trailing: EditDelete(
        edit: () async {
          var sentencePattern = (await Navigator.pushNamed(context, '/edit_sentence_pattern', arguments:{'title':'编辑常用句型','sentence_pattern': SentencePatternSerializer().from(widget._sentencePattern)})) as SentencePatternSerializer;
            if(sentencePattern != null) widget._sentencePattern.from(sentencePattern).save();
            setState(() {});
        },
        delete: widget._delete,
      ),
    );
  }
}
