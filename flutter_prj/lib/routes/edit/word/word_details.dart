import 'package:flutter/material.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/Tag.dart';


class WordDetails extends StatefulWidget {
  final WordSerializer _word;
  final bool _editable;

  WordDetails({Key key, WordSerializer word, bool editable=false})
    : _word = word,
      _editable = editable,
      super(key:key);

  @override
  _WordDetailsState createState() => _WordDetailsState();
}

class _WordDetailsState extends State<WordDetails> {

  List<Widget> _buildTags(BuildContext context) {
    final TextStyle style = TextStyle(fontSize: 12.0, color: Theme.of(context).primaryColor);
    List<Widget> tags = [];
    if(widget._word.tag == null || widget._word.tag.length == 0) return tags;
    tags.add(Text('Tags:', style: style));
    tags.addAll(
      widget._word.tag.map((e) => 
        Tag(
          label: Text(e, style: style,),
          onDeleted: widget._editable ? () => setState(() => widget._word.tag.remove(e)) : null,
        )
      ).toList()
    );
    return tags;
  }

  List<Widget> _buildEtyma(BuildContext context) {
    final TextStyle style = TextStyle(fontSize: 12.0, color: Colors.pinkAccent);
    List<Widget> etyma = [];
    if(widget._word.etyma == null || widget._word.etyma.length == 0) return etyma;
    etyma.add(Text('词根:', style: style));
    etyma.addAll(
      widget._word.etyma.map((e) => 
        Tag(
          label: Text(e, style: style,),
          onDeleted: widget._editable ? () => setState(() => widget._word.etyma.remove(e)) : null,
        )
      ).toList()
    );
    return etyma;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    children.addAll(_buildTags(context));
    children.addAll(_buildEtyma(context));
    return Wrap(
            spacing: 8.0,
            runSpacing: 8.0, 
            children: children,
          );
  }
}
