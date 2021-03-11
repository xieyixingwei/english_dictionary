import 'package:flutter/material.dart';
import 'package:flutter_prj/serializers/grammar.dart';
import 'package:flutter_prj/widgets/Tag.dart';


class GrammarDetails extends StatefulWidget {
  final GrammarSerializer _grammar;
  final bool _editable;

  GrammarDetails(this._grammar, this._editable, {Key key}): super(key:key);

  @override
  _GrammarDetailsState createState() => _GrammarDetailsState();
}

class _GrammarDetailsState extends State<GrammarDetails> {

  List<Widget> _buildType(BuildContext context) {
    final TextStyle style = TextStyle(fontSize: 12.0, color: Colors.green);
    List<Widget> types = [];
    if(widget._grammar.type == null || widget._grammar.type.length == 0) return types;
    types.add(Text('Type:', style: style));
    types.addAll(
      widget._grammar.type.map<Widget>((e) => 
        Tag(
          label: Text(e, style: style,),
          onDeleted: widget._editable ? () => setState(() => widget._grammar.type.remove(e)) : null,
        )
      ).toList()
    );
    return types;
  }

  List<Widget> _buildTags(BuildContext context) {
    final TextStyle style = TextStyle(fontSize: 12.0, color: Theme.of(context).primaryColor);
    List<Widget> tags = [];
    if(widget._grammar.tag == null || widget._grammar.tag.length == 0) return tags;
    tags.add(Text('Tags:', style: style));
    tags.addAll(
      widget._grammar.tag.map((e) => 
        Tag(
          label: Text(e, style: style,),
          onDeleted: widget._editable ? () => setState(() => widget._grammar.tag.remove(e)) : null,
        )
      ).toList()
    );
    return tags;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    children.addAll(_buildType(context));
    children.addAll(_buildTags(context));
    return Wrap(
            spacing: 8.0,
            runSpacing: 8.0, 
            children: children,
          );
  }
}
