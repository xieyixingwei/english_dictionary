import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/routes/edit/grammar/grammar_details.dart';
import 'package:flutter_prj/serializers/grammar.dart';
import 'package:flutter_prj/widgets/SelectDialog.dart';
import 'package:flutter_prj/widgets/popup_memu_button.dart';


class EditGrammar extends StatefulWidget {
  final String _title;
  final GrammarSerializer _grammar;

  EditGrammar({Key key, String title, GrammarSerializer grammar})
    : _title = title,
      _grammar = grammar != null ? grammar : GrammarSerializer(),
      super(key:key);

  @override
  _EditGrammarState createState() => _EditGrammarState();
}

class _EditGrammarState extends State<EditGrammar> {
  static const List<String> _options = ['设置类型', '添加Tag', '编辑类型', '编辑Tags'];

  _onSelected(String value) {
    if(value == '设置类型') {
      popSelectDialog(
        context: context,
        title: value,
        options: Global.grammarTypeOptions,
        close: (String val) => setState(() => widget._grammar.g_type.add(val)),
      );
    } else if(value == '添加Tag') {
      popSelectDialog(
        context: context,
        title: value,
        options: Global.grammarTagOptions,
        close: (String val) => setState(() => widget._grammar.g_tags.add(val)),
      );
    } else if(value == '编辑类型') {
      Navigator.pushNamed(context, '/edit_grammar_type');
    }
     else if(value == '编辑Tags') {
      Navigator.pushNamed(context, '/edit_grammar_tags');
    }
  }

  _buildTextField(BuildContext context) =>
    TextField(
      maxLines: null,
      controller: TextEditingController(text: widget._grammar.g_content),
      decoration: InputDecoration(
        labelText: '语法',
        border: OutlineInputBorder(),
        suffixIcon: popupMenuButton(context:context, options:_options, onSelected:_onSelected),
      ),
      onChanged: (String value) => widget._grammar.g_content = value,
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              title: Text(widget._title),
              automaticallyImplyLeading: false, // 取消返回按钮
            ),
            body: Container(
              padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField(context),
                  SizedBox(height: 10,),
                  GrammarDetails(widget._grammar, true),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        splashRadius: 1.0,
                        icon: Icon(Icons.done, color: Colors.green,),
                        tooltip: '确定',
                        onPressed: () => Navigator.pop(context, widget._grammar),
                      ),
                      SizedBox(width: 10,),
                      IconButton(
                        splashRadius: 1.0,
                        icon: Icon(Icons.clear, color: Colors.grey,),
                        tooltip: '取消',
                        onPressed: () => Navigator.pop(context),
                      ),
                    ]
                  ),
                ],
              ),
            ),
          );
  }
}
