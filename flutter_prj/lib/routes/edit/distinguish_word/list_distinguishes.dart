import 'package:flutter/material.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/custom_table.dart';
import 'package:flutter_prj/widgets/edit_delete.dart';


class ListDistinguishes extends StatefulWidget {

  @override
  _ListDistinguishesState createState() => _ListDistinguishesState();
}

class _ListDistinguishesState extends State<ListDistinguishes> {
  DistinguishPaginationSerializer _distinguishes = DistinguishPaginationSerializer();
  num _perPage = 10;
  num _pageIndex = 1;

  @override
  void initState() { 
    _init();
    super.initState();
  }

  _init() async {
    await _distinguishes.retrieve(queries:{'page_size':_perPage, 'page_index':_pageIndex});
    setState((){});
  }

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        title: Text('编辑单词辨析'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilter(context),
            _buildListDistinguishs(context),
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
        TextButton(
          child: Text('添加词义辨析'),
          onPressed: () async {
            var g = (await Navigator.pushNamed(context, '/edit_distinguish', arguments:{'title':'添加词义辨析'})) as DistinguishSerializer;
            if(g != null) {
              var find = _distinguishes.results.where((e) => e.id == g.id);
              if(find.isEmpty) _distinguishes.results.add(g);
              else find.first.from(g);
              await g.save();
            }
            setState((){});
          }
        ),
      ],
    );

  Widget _buildFilter(BuildContext context) =>
    Container(
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
                  onChanged: (val) => _distinguishes.filter.content__icontains = val.trim().isEmpty ? null : val.trim(),
                  decoration: InputDecoration(
                    labelText: '词义关键字',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      splashRadius: 1.0,
                      tooltip: '搜索',
                      icon: Icon(Icons.search),
                      onPressed: () async {
                        bool ret = await _distinguishes.retrieve(queries:{'page_size': 10, 'page_index':1});
                        if(ret) setState((){});
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

  Widget _buildListDistinguishs(BuildContext context) =>
    SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(6, 0, 6, 10),
      child: CustomTable(
        count: (_distinguishes.count + _perPage/2) ~/ _perPage,
        index: _pageIndex,
        goto: (num index) async {
          _pageIndex = index;
          bool ret = await _distinguishes.retrieve(queries:{'page_size':_perPage, 'page_index':_pageIndex});
          if(ret) setState((){});
        },
        perPage: _perPage,
        perPages: [10, 20, 30, 50],
        perPageChange: (v) async {
          _pageIndex = 1;
          _perPage = v;
          bool ret = await _distinguishes.retrieve(queries:{'page_size':_perPage, 'page_index':_pageIndex});
          if(ret) setState((){});
        },
        rows: _distinguishes.results.map<Widget>((e) => 
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.only(left: 30, right: 30, top: 0, bottom: 0),
            title: Text('${e.id}'),
            trailing: EditDelete(
              edit: () async {
                var distinguish = (await Navigator.pushNamed(
                  context, '/edit_distinguish',
                  arguments:{'title':'编辑词义辨析','distinguish': DistinguishSerializer().from(e)})
                ) as DistinguishSerializer;
                if(distinguish != null) await e.from(distinguish).save();
                setState(() {});
              },
              delete: () {e.delete(); setState(() => _distinguishes.results.remove(e));},
            ),
          )
        ).toList(),
      ),
    );
}




