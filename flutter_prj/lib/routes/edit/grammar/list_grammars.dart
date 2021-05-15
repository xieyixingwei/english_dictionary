import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/routes/edit/grammar/show_grammar.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/edit_delete.dart';
import 'package:flutter_prj/widgets/pagination.dart';


class ListGrammers extends StatefulWidget {

  @override
  _ListGrammersState createState() => _ListGrammersState();
}

class _ListGrammersState extends State<ListGrammers> {
  GrammarPaginationSerializer _grammars = GrammarPaginationSerializer();
  static final List<String> typeOptions = ["类型"] + Global.grammarTypeOptions;
  static final List<String> tagOptions = ["Tag"] + Global.grammarTagOptions;
  List<String> ddBtnValues = [typeOptions.first, tagOptions.first];
  final textStyle = const TextStyle(fontSize: 12, color: Colors.black45);
  num _perPage = 10;
  num _pageIndex = 1;

  @override
  void initState() { 
    super.initState();
    _init();
  }

  _init() async {
    await _grammars.retrieve(queries:{'page_size':_perPage, 'page_index':_pageIndex});
    setState((){});
  }

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        title: Text('编辑语法'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(6, 20, 6, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilter(context),
            _buildListGrammars(context),
          ],
        ),
      ),
    );

  Widget _buildFilterOptions(BuildContext context) =>
    Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 10,
      children: [
        SizedBox(width: 2,),
        Text('过滤:', style: TextStyle(fontSize: 12, color: Colors.black38, fontWeight: FontWeight.bold)),
        DropdownButton(
          isDense: true,
          value: ddBtnValues[0],
          items: typeOptions.map((e)=>DropdownMenuItem(child: Text(e, style: textStyle), value: e,)).toList(),
          onChanged: (v) {
            setState(() => ddBtnValues[0] = v);
            _grammars.filter.type__icontains = v != typeOptions.first ? v : null;
          },
          underline: Divider(height:1, thickness: 1),
        ),
        DropdownButton(
          isDense: true,
          value: ddBtnValues[1],
          items: tagOptions.map((e)=>DropdownMenuItem(child: Text(e, style: textStyle), value: e,)).toList(),
          onChanged: (v) {
            setState(() => ddBtnValues[1] = v);
            _grammars.filter.tag__icontains = v != tagOptions.first ? v : null;
          },
          underline: Divider(height:1, thickness: 1),
        ),
        TextButton(
          child: Text('添加语法', style: TextStyle(fontSize: 12)),
          onPressed: () async {
            var g = (await Navigator.pushNamed(context, '/edit_grammar', arguments:{'title':'添加语法'})) as GrammarSerializer;
            if(g != null) {
              var find = _grammars.results.where((e) => e.id == g.id);
              if(find.isEmpty) _grammars.results.add(g);
              else find.first.from(g);
              await g.save();
            }
            setState((){});
          }
        ),
      ],
    );

  Widget _buildFilter(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            onChanged: (val) => _grammars.filter.content__icontains = val.trim().length == 0 ? null : val.trim(),
            decoration: InputDecoration(
              labelText: '关键字',
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                splashRadius: 1.0,
                tooltip: '搜索',
                icon: Icon(Icons.search),
                onPressed: () async {
                  bool ret = await _grammars.retrieve(queries:{'page_size': _perPage, 'page_index':_pageIndex});
                  if(ret) setState((){});
                },
              ),
            ),
          ),
          _buildFilterOptions(context),
        ]
      ),
    );
  }

  Widget _buildListGrammars(BuildContext context) =>
    SingleChildScrollView(
      padding: EdgeInsets.only(top: 20),
      child: Pagination(
        pages: (_grammars.count / _perPage).ceil(),
        curPage: _pageIndex,
        goto: (num index) async {
          _pageIndex = index;
          bool ret = await _grammars.retrieve(queries:{'page_size':_perPage, 'page_index':_pageIndex});
          if(ret) setState((){});
        },
        perPage: _perPage,
        perPageSet: [10, 20, 30, 50],
        perPageChange: (v) async {
          _pageIndex = 1;
          _perPage = v;
          bool ret = await _grammars.retrieve(queries:{'page_size':_perPage, 'page_index':_pageIndex});
          if(ret) setState((){});
        },
        rows: _grammars.results.map<Widget>((e) => 
          grammarItem(
            context: context,
            grammar: e,
            trailing: EditDelete(
              edit: () async {
                var grammar = (await Navigator.pushNamed(
                  context, '/edit_grammar',
                  arguments:{'title':'编辑语法','grammar': GrammarSerializer().from(e)})
                ) as GrammarSerializer;
                if(grammar != null) await e.from(grammar).save();
                setState(() {});
              },
              delete: () {
                e.delete();
                _grammars.results.remove(e);
                setState(() {});
              },
            ),
          )
        ).toList(),
      ),
    );
}




