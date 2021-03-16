import 'package:flutter/material.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/Tag.dart';


class SentenceDetails extends StatefulWidget {
  final SentenceSerializer _sentence;
  final bool _editable;
  SentenceDetails({Key key, SentenceSerializer sentence, bool editable=false})
    : _sentence = sentence,
      _editable = editable,
      super(key:key);

  @override
  _SentenceDetailsState createState() => _SentenceDetailsState();
}

class _SentenceDetailsState extends State<SentenceDetails> {
  static const List<String> _types = ['句子', '短语'];

  Widget _buildType(BuildContext context) {
    final TextStyle style = TextStyle(fontSize: 12.0, color: Colors.green);
    return Text(_types[widget._sentence.type], style: style);
  }

  List<Widget> _buildTags(BuildContext context) {
    final TextStyle style = TextStyle(fontSize: 12.0, color: Theme.of(context).primaryColor);
    List<Widget> tags = [];
    if(widget._sentence.tag == null || widget._sentence.tag.length == 0) return tags;
    tags.add(Text('Tags:', style: style));
    tags.addAll(
      widget._sentence.tag.map((e) => 
        Tag(
          label: Text(e, style: style,),
          onDeleted: widget._editable ? () => setState(() => widget._sentence.tag.remove(e)) : null,
        )
      ).toList()
    );
    return tags;
  }
/*
  List<Widget> _buildTense(BuildContext context) {
    final TextStyle style = TextStyle(fontSize: 12.0, color: Colors.pinkAccent);
    List<Widget> tense = [];
    if(widget._sentence.tense == null || widget._sentence.tense.length == 0) return tense;
    tense.add(Text('时态:', style: style));
    tense.add(
        Tag(
          label: Text(widget._sentence.tense, style: style,),
          onDeleted: widget._editable ? () => setState(() => widget._sentence.tense.remove(e)) : null,
        )
    );
    return tense;
  }*/

  List<Widget> _buildForm(BuildContext context) {
    final TextStyle style = TextStyle(fontSize: 12.0, color: Colors.orange);
    List<Widget> form = [];
    if(widget._sentence.pattern == null || widget._sentence.pattern.length == 0) return form;
    form.add(Text('句型:', style: style));
    form.addAll(
      widget._sentence.pattern.map((e) => 
        Tag(
          label: Text(e, style: style,),
          onDeleted: widget._editable ? () => setState(() => widget._sentence.pattern.remove(e)) : null,
        )
      ).toList()
    );
    return form;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    children.add(_buildType(context));
    children.addAll(_buildTags(context));
    children.addAll(_buildForm(context));
    return Wrap(
            spacing: 8.0,
            runSpacing: 8.0, 
            children: children,
          );
  }
}
