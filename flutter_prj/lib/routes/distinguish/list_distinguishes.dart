import 'package:flutter/material.dart';
import 'package:flutter_prj/routes/distinguish/show_distinguish.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/edit_delete.dart';
import 'package:flutter_prj/widgets/pagination.dart';


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
    await Future.forEach<DistinguishSerializer>(_distinguishes.results, (e) async {
      await Future.forEach<num>(e.sentencePatternForeign, (sid) async {
        var sp = SentencePatternSerializer()..id = sid;
        var ret = await sp.retrieve();
        if(ret) e.sentencePatternForeignSet.add(sp);
      });
    });
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
        padding: EdgeInsets.fromLTRB(6, 20, 6, 20),
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
                  bool ret = await _distinguishes.retrieve(queries:{'page_size':_perPage, 'page_index':_pageIndex});
                  if(ret) setState((){});
                },
              ),
            ),
          ),
          _buildFilterOptions(context),
        ],
      ),
    );

  Widget _buildListDistinguishs(BuildContext context) =>
    SingleChildScrollView(
      padding: EdgeInsets.only(top: 20),
      child: Pagination(
        pages: (_distinguishes.count / _perPage).ceil(),
        curPage: _pageIndex,
        goto: (num index) async {
          _pageIndex = index;
          bool ret = await _distinguishes.retrieve(queries:{'page_size':_perPage, 'page_index':_pageIndex});
          if(ret) setState((){});
        },
        perPage: _perPage,
        perPageSet: [10, 20, 30, 50],
        perPageChange: (v) async {
          _pageIndex = 1;
          _perPage = v;
          bool ret = await _distinguishes.retrieve(queries:{'page_size':_perPage, 'page_index':_pageIndex});
          if(ret) setState((){});
        },
        rows: _distinguishes.results.map<Widget>((e) => 
          distinguishItem(
            context: context,
            distinguish: e,
            trailing: EditDelete(
              edit: () async {
                var distinguish = (await Navigator.pushNamed(
                  context, '/edit_distinguish',
                  arguments:{'title':'编辑词义辨析','distinguish': DistinguishSerializer().from(e)})
                ) as DistinguishSerializer;
                if(distinguish != null) await e.from(distinguish).save();
                setState(() {});
              },
              delete: () {
                e.delete();
                _distinguishes.results.remove(e);
                setState(() {});
              },
            ),
          )
        ).toList(),
      ),
    );
}




