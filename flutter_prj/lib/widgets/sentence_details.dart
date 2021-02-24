import 'package:flutter/material.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/Tag.dart';


class SentenceDetails extends StatefulWidget {
  final SentenceSerializer _sentence;
  SentenceDetails({Key key, SentenceSerializer sentence})
    : _sentence = sentence,
      super(key:key);

  @override
  _SentenceDetailsState createState() => _SentenceDetailsState();
}

class _SentenceDetailsState extends State<SentenceDetails> {
  final List<String> _types = ["句子", "短语"];

  Widget _buildType(BuildContext context) {
    final TextStyle style = TextStyle(fontSize: 12.0, color: Colors.green);
    return Text(_types[widget._sentence.s_type], style: style);
  }

  List<Widget> _buildTags(BuildContext context) {
    final TextStyle style = TextStyle(fontSize: 12.0, color: Theme.of(context).primaryColor);
    List<Widget> tags = [];
    if(widget._sentence.s_tags == null || widget._sentence.s_tags.length == 0) return tags;
    tags.add(Text("Tags:", style: style));
    tags.addAll(
      widget._sentence.s_tags.map((e) => 
        Tag(
          label: Text(e, style: style,),
          onDeleted: () => setState(() => widget._sentence.s_tags.remove(e)),
        )
      ).toList()
    );
    return tags;
  }

  List<Widget> _buildTense(BuildContext context) {
    final TextStyle style = TextStyle(fontSize: 12.0, color: Colors.pinkAccent);
    List<Widget> tense = [];
    if(widget._sentence.s_tense == null || widget._sentence.s_tense.length == 0) return tense;
    tense.add(Text("时态:", style: style));
    tense.addAll(
      widget._sentence.s_tense.map((e) => 
        Tag(
          label: Text(e, style: style,),
          onDeleted: () => setState(() => widget._sentence.s_tense.remove(e)),
        )
      ).toList()
    );
    return tense;
  }

  List<Widget> _buildForm(BuildContext context) {
    final TextStyle style = TextStyle(fontSize: 12.0, color: Colors.orange);
    List<Widget> form = [];
    if(widget._sentence.s_form == null || widget._sentence.s_form.length == 0) return form;
    form.add(Text("句型:", style: style));
    form.addAll(
      widget._sentence.s_form.map((e) => 
        Tag(
          label: Text(e, style: style,),
          onDeleted: () => setState(() => widget._sentence.s_form.remove(e)),
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
    children.addAll(_buildTense(context));
    children.addAll(_buildForm(context));
    return Wrap(
            spacing: 8.0,
            runSpacing: 8.0, 
            children: children,
          );
  }
}
