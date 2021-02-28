import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/SelectDialog.dart';
import 'package:flutter_prj/widgets/Tag.dart';
import 'package:flutter_prj/widgets/popup_memu_button.dart';


class EditGrammar extends StatefulWidget {
  final GrammarSerializer grammar;

  EditGrammar({Key key, GrammarSerializer grammar})
    : grammar = grammar,
      super(key:key);

  @override
  _EditGrammarState createState() => _EditGrammarState();
}

class _EditGrammarState extends State<EditGrammar> {
  static const List<String> _options = ["删除", "设置类型", "添加Tag", "编辑类型", "编辑Tags"];

  _onSelected(String value) {
    if(value == "删除") {
      widget.grammar.delete();
    } else if(value == "设置类型") {
      popSelectDialog(
        context: context,
        title: value,
        options: Global.grammarTypeOptions,
        close: (String val) => setState(() => widget.grammar.g_type.add(val)),
      );
    } else if(value == "添加Tag") {
      popSelectDialog(
        context: context,
        title: value,
        options: Global.grammarTagOptions,
        close: (String val) => setState(() => widget.grammar.g_tags.add(val)),
      );
    } else if(value == "编辑类型") {
      Navigator.pushNamed(context, "/edit_grammar_type");
    }
     else if(value == "编辑Tags") {
      Navigator.pushNamed(context, "/edit_grammar_tags");
    }
  }

  _buildTextField(BuildContext context) =>
    Padding(
        padding: EdgeInsets.only(top:20),
        child: TextField(
          maxLines: null,
          controller: TextEditingController(text: widget.grammar.g_content),
          decoration: InputDecoration(
            labelText: '语法',
            border: OutlineInputBorder(),
            suffixIcon: popupMenuButton(context:context, options:_options, onSelected:_onSelected),
          ),
          onChanged: (String value) => widget.grammar.g_content = value,
        )
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              title: Text('编辑语法'),
            ),
            body: Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField(context),
                  GrammarDetails(widget.grammar, true),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          child: Text('保存'),
                          onPressed: () => widget.grammar.save(update:true),
                        ),
                      ),
                    ]
                  ),
                ],
              ),
            ),
          );
  }
}


class GrammarDetails extends StatefulWidget {
  final GrammarSerializer grammar;
  final bool editable;

  GrammarDetails(this.grammar, this.editable, {Key key}): super(key:key);

  @override
  _GrammarDetailsState createState() => _GrammarDetailsState();
}

class _GrammarDetailsState extends State<GrammarDetails> {

  List<Widget> _buildType(BuildContext context) {
    final TextStyle style = TextStyle(fontSize: 12.0, color: Colors.green);
    List<Widget> types = [];
    if(widget.grammar.g_type == null || widget.grammar.g_type.length == 0) return types;
    types.add(Text('Type:', style: style));
    types.addAll(
      widget.grammar.g_type.map<Widget>((e) => 
        Tag(
          label: Text(e, style: style,),
          onDeleted: widget.editable ? () => setState(() => widget.grammar.g_type.remove(e)) : null,
        )
      ).toList()
    );
    return types;
  }

  List<Widget> _buildTags(BuildContext context) {
    final TextStyle style = TextStyle(fontSize: 12.0, color: Theme.of(context).primaryColor);
    List<Widget> tags = [];
    if(widget.grammar.g_tags == null || widget.grammar.g_tags.length == 0) return tags;
    tags.add(Text('Tags:', style: style));
    tags.addAll(
      widget.grammar.g_tags.map((e) => 
        Tag(
          label: Text(e, style: style,),
          onDeleted: widget.editable ? () => setState(() => widget.grammar.g_tags.remove(e)) : null,
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
