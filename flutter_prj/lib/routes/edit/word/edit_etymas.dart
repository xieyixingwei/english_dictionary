import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/routes/edit/grammar/show_grammar.dart';
import 'package:flutter_prj/serializers/index.dart';


class EditEtymas extends StatefulWidget {

  @override
  _EditEtymasState createState() => _EditEtymasState();
}

class _EditEtymasState extends State<EditEtymas> {
  GrammarsPaginationSerializer _grammars = GrammarsPaginationSerializer();
  static final List<String> typeOptions = ["请选择类型"] + Global.grammarTypeOptions;
  static final List<String> tagOptions = ["请选择Tags"] + Global.grammarTagOptions;
  List<String> ddBtnValues = [typeOptions.first, tagOptions.first];

  @override
  void initState() { 
    super.initState();
    _init();
  }

  _init() async {
    var tmp = await _grammars.retrieve();
    setState(() => _grammars = tmp);
  }

Widget _buildFilter(BuildContext context) =>
  Wrap(
    spacing: 10.0,
    children: [
      Container(
        width: 100,
        child: TextField(
          onChanged: (val) => _grammars.filter.g_content__icontains = val.trim().length == 0 ? null : val.trim(),
          decoration: InputDecoration(
            labelText: '语法关键字',
          ),
        ),
      ),
      DropdownButton(
        value: ddBtnValues[0],
        items: typeOptions.map((e)=>DropdownMenuItem(child: Text(e), value: e,)).toList(),
        onChanged: (v) {
          setState(() => ddBtnValues[0] = v);
          _grammars.filter.g_type__icontains = v != typeOptions.first ? v : null;
        },
      ),
      DropdownButton(
        value: ddBtnValues[1],
        items: tagOptions.map((e)=>DropdownMenuItem(child: Text(e), value: e,)).toList(),
        onChanged: (v) {setState(() => ddBtnValues[1] = v); _grammars.filter.g_tags__icontains = v != tagOptions.first ? v : null;},
      ),
      IconButton(
        splashRadius: 1.0,
        tooltip: '搜索',
        icon: Icon(Icons.search),
        onPressed: () async {
          await _grammars.retrieve(queryParameters:{"page_size": 10, "page_index":1}, update: true);
          setState((){});
        },
      ),
      IconButton(
        splashRadius: 1.0,
        icon: Icon(Icons.add),
        tooltip: '添加语法',
        onPressed: () async {
          var g = (await Navigator.pushNamed(context, '/edit_grammar', arguments:{'title':'添加语法'})) as GrammarSerializer;
          if(g != null) {
            _grammars.results.add(g);
            g.save();
          }
          setState((){});
        },
      ),
    ],
  );


  Widget _buildListGrammars(BuildContext context) =>
    Expanded(
      child: ListView(
        children: _grammars.results.map<Widget>(
          (e) => ShowGrammar(
            grammar: e,
            delete: () {e.delete(); setState(()=>_grammars.results.remove(e));},
          )
        ).toList(),
      )
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
                appBar: AppBar(
                  title: Text('编辑词根词缀'),
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




