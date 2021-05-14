import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/pagination.dart';
import 'package:flutter_prj/widgets/edit_delete.dart';


class ListEtymas extends StatefulWidget {

  @override
  _ListEtymasState createState() => _ListEtymasState();
}

class _ListEtymasState extends State<ListEtymas> {
  EtymaPaginationSerializer _etymas = EtymaPaginationSerializer();
  static final List<String> _typeOptions = ['类型'] + Global.etymaTypeOptions;
  List<String> _selected = [_typeOptions.first];
  num _perPage = 10;
  num _pageIndex = 1;
  final textStyle = const TextStyle(fontSize: 12,);

  @override
  void initState() { 
    super.initState();
    _init();
  }

  _init() async {
    await _etymas.retrieve(queries:{'page_size':_perPage, 'page_index':_pageIndex});
    setState((){});
  }

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        title: Text('编辑词根词缀'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilter(context),
            _buildListEtyma(context),
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
        Text('过滤:', style: TextStyle(fontSize: 12, color: Color.fromRGBO(132,132,132,1.0), fontWeight: FontWeight.bold)),
        DropdownButton(
          isDense: true,
          value: _selected[0],
          items: _typeOptions.map((e)=>DropdownMenuItem(child: Text(e, style: textStyle,), value: e,)).toList(),
          onChanged: (v) {
            setState(() => _selected[0] = v);
            _etymas.filter.type = v != _typeOptions.first ? Global.etymaTypeOptions.indexOf(v) : null;
          },
          underline: Container(width: 0, height:0,),
        ),
        TextButton(
          child: Text('添加词根词缀', style: TextStyle(fontSize: 12)),
          onPressed: () async {
            var g = (await Navigator.pushNamed(context, '/edit_etyma', arguments:{'title':'添加词根词缀'})) as EtymaSerializer;
            if(g != null) {
              _etymas.results.add(g);
              Global.etymaOptions.add(g.name);
              await g.save();
            }
            setState((){});
          },
        )
      ],
    );


  Widget _buildFilter(BuildContext context) {
    return Container(
      //color: Colors.white,
      padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
      child: Row(
        children: [
          Expanded(flex: 1, child: Container(),),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  maxLines: 1,
                  style: TextStyle(fontSize: 14,),
                  onChanged: (val) => (v) => _etymas.filter.name__icontains = v.trim().isNotEmpty ? v.trim() : null,
                  decoration: InputDecoration(
                    hintText: '词根词缀',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      splashRadius: 1.0,
                      tooltip: '搜索',
                      icon: Icon(Icons.search),
                      onPressed: () async {
                        await _etymas.retrieve(queries:{"page_size": 10, "page_index":1});
                        setState((){});
                      },
                    ),
                  ),
                ),
                _buildFilterOptions(context),
              ],
            ),
          ),
          Expanded(flex: 1, child: Container(),),
        ],
      ),
    );
  }

  Widget _buildListEtyma(BuildContext context) =>
    SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(6, 0, 6, 10),
      child: Pagination(
        pages: (_etymas.count / _perPage).ceil(),
        curPage: _pageIndex,
        goto: (num index) async {
          _pageIndex = index;
          bool ret = await _etymas.retrieve(queries:{'page_size':_perPage, 'page_index':_pageIndex});
          if(ret) setState((){});
        },
        perPage: _perPage,
        perPageSet: [10, 20, 30, 50],
        perPageChange: (v) async {
          _pageIndex = 1;
          _perPage = v;
          bool ret = await _etymas.retrieve(queries:{'page_size':_perPage, 'page_index':_pageIndex});
          if(ret) setState((){});
        },
        rows: _etymas.results.map<Widget>((e) => 
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.only(left: 30, right: 30, top: 0, bottom: 0),
            title: Text(e.name),
            trailing: EditDelete(
              edit: () async {
                var etyma = (await Navigator.pushNamed(
                  context, '/edit_etyma',
                  arguments:{'title':'编辑词根词缀','etyma': EtymaSerializer().from(e)})
                  ) as EtymaSerializer;
                if(etyma != null) await e.from(etyma).save();
                setState(() {});
              },
              delete: () {e.delete(); setState(() => _etymas.results.remove(e));},
            ),
          )
        ).toList(),
      ),
    );
}




