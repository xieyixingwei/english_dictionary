import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/SelectDialog.dart';
import 'package:flutter_prj/widgets/Tag.dart';
import 'package:flutter_prj/widgets/popup_memu_button.dart';


class EditGrammers extends StatefulWidget {

  @override
  _EditGrammersState createState() => _EditGrammersState();
}

class _EditGrammersState extends State<EditGrammers> {
  GrammarsPaginationSerializer grammars = GrammarsPaginationSerializer();
  static final List<String> typeOptions = ["请选择类型"] + Global.grammarTypeOptions;
  static final List<String> tagOptions = ["请选择Tags"] + Global.grammarTagOptions;
  List<String> ddBtnValues = [typeOptions.first, tagOptions.first];

  @override
  void initState() { 
    super.initState();
    _init();
  }

  _init() async {
    var tmp = await grammars.retrieve();
    setState(() => grammars = tmp);
  }

Widget _buildFilter(BuildContext context) =>
  Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
        flex: 1,
        child: TextField(
          onChanged: (val) => grammars.filter.g_content__icontains = val.trim().length == 0 ? null : val.trim(),
          decoration: InputDecoration(
            labelText: '语法关键字',
          ),
        ),
      ),
      SizedBox(width: 10,),
      DropdownButton(
        value: ddBtnValues[0],
        items: typeOptions.map((e)=>DropdownMenuItem(child: Text(e), value: e,)).toList(),
        onChanged: (v) {
          setState(() => ddBtnValues[0] = v);
          grammars.filter.g_type__icontains = v != typeOptions.first ? v : null;
          
        },
      ),
      SizedBox(width: 10,),
      DropdownButton(
        value: ddBtnValues[1],
        items: tagOptions.map((e)=>DropdownMenuItem(child: Text(e), value: e,)).toList(),
        onChanged: (v) {setState(() => ddBtnValues[1] = v); grammars.filter.g_tags__icontains = v != tagOptions.first ? v : null;},
      ),
      SizedBox(width: 10,),
      IconButton(
        splashRadius: 1.0,
        icon: Icon(Icons.search),
        onPressed: () async {
          var tmp = await grammars.retrieve(queryParameters:{"page_size": 10, "page_index":1}, update: true);
          setState(() => grammars = tmp);
        },
      ),
      SizedBox(width: 10,),
      InkWell(
        child: Text("添加语法", style: TextStyle(color: Theme.of(context).primaryColor,),),
        onTap: () async {
          var grammar = await Navigator.pushNamed(context, '/edit_grammar', arguments:GrammarSerializer());
          setState(() => grammars.results.add(grammar));
        },
      ),
    ],
  );


  Widget _buildListGrammars(BuildContext context) {
    List<Widget> children = grammars.results.map<ListTile>((e) => 
      ListTile(
        title: Text(e.g_content),
        subtitle: GrammarDetails(e, false),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              child: Text('编辑', style: TextStyle(color: Theme.of(context).primaryColor),),
              onTap: () async {
                var grammar = await Navigator.pushNamed(context, '/edit_grammar', arguments:e);
                if(grammar != null)
                  setState(() => e = grammar);
              },
            ),
            SizedBox(width: 10,),
            InkWell(
              child: Text('删除', style: TextStyle(color: Colors.pink,)),
              onTap: () {e.delete(); setState(() => grammars.results.remove(e));},
            ),
          ],
        )
      ),
    ).toList();

    return Expanded(
      child: ListView(
        children: children,
      )
    );
  }

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
                        _buildFilter(context),
                        SizedBox(height: 20,),
                        _buildListGrammars(context),
                      ],
                    ),
                  ),
                );
  }
}


class EditGrammar extends StatefulWidget {
  final GrammarSerializer grammar;

  EditGrammar({Key key, GrammarSerializer grammar})
    : grammar = grammar,
      super(key:key);

  @override
  _EditGrammarState createState() => _EditGrammarState();
}

class _EditGrammarState extends State<EditGrammar> {
  static const List<String> _options = ["设置类型", "添加Tag", "编辑类型", "编辑Tags"];

  _onSelected(String value) {
    if(value == "设置类型") {
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
            suffix: InkWell(
              child: Text('保存', style: TextStyle(color: Theme.of(context).primaryColor)),
              onTap: () => widget.grammar.save(update: true),
            ),
          ),
          onChanged: (String value) => widget.grammar.g_content = value,
        )
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              title: Text('编辑语法'),
              automaticallyImplyLeading: false, // 取消返回按钮
            ),
            body: Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField(context),
                  GrammarDetails(widget.grammar, true),
                  SizedBox(height: 30,),
                  Row(
                    children: [
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          child: Text('确定'),
                          onPressed: () => Navigator.pop(context, widget.grammar),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          child: Text('取消'),
                          onPressed: () => Navigator.pop(context),
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
