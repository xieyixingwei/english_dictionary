import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/routes/etyma/show_etyma.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/pagination.dart';
import 'package:flutter_prj/widgets/edit_delete.dart';


class ListEtymas extends StatefulWidget {

  @override
  _ListEtymasState createState() => _ListEtymasState();
}

class _ListEtymasState extends State<ListEtymas> {
  EtymaPaginationSerializer _etymaPagen = EtymaPaginationSerializer();
  static final List<String> _typeOptions = ['类型'] + Global.etymaTypeOptions;
  List<String> _selected = [_typeOptions.first];
  final textStyle = const TextStyle(fontSize: 12,);

  @override
  void initState() { 
    super.initState();
    _init();
  }

  _init() async {
    await _etymaPagen.retrieve();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        title: Text('编辑词根词缀'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(6, 20, 6, 20),
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
            _etymaPagen.filter.type = v != _typeOptions.first ? Global.etymaTypeOptions.indexOf(v) : null;
          },
          underline: Container(width: 0, height:0,),
        ),
        TextButton(
          child: Text('添加词根词缀', style: TextStyle(fontSize: 12)),
          onPressed: () async {
            var g = (await Navigator.pushNamed(context, '/edit_etyma', arguments:{'title':'添加词根词缀'})) as EtymaSerializer;
            if(g != null) {
              _etymaPagen.results.add(g);
              Global.etymaOptions.add(g.name);
              await g.save();
            }
            setState((){});
          },
        )
      ],
    );


  Widget _buildFilter(BuildContext context) =>
    Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            maxLines: 1,
            style: TextStyle(fontSize: 14,),
            onChanged: (v) => _etymaPagen.filter.name__icontains = v.trim().isNotEmpty ? v.trim() : null,
            decoration: InputDecoration(
              hintText: '词根词缀',
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                splashRadius: 1.0,
                tooltip: '搜索',
                icon: Icon(Icons.search),
                onPressed: () async {
                  await _etymaPagen.retrieve();
                  setState((){});
                },
              ),
            ),
          ),
          _buildFilterOptions(context),
        ],
      ),
    );

  Widget _buildListEtyma(BuildContext context) =>
    Container(
      padding: EdgeInsets.only(top: 10),
      child: Pagination(
        pages: (_etymaPagen.count / _etymaPagen.queryset.page_size).ceil(),
        curPage: _etymaPagen.queryset.page_index,
        goto: (num index) async {
          _etymaPagen.queryset.page_index = index;
          bool ret = await _etymaPagen.retrieve();
          if(ret) setState((){});
        },
        perPage: _etymaPagen.queryset.page_size,
        perPageSet: [10, 20, 30, 50],
        perPageChange: (v) async {
          _etymaPagen.queryset.page_index = 1;
          _etymaPagen.queryset.page_size = v;
          bool ret = await _etymaPagen.retrieve();
          if(ret) setState((){});
        },
        rows: _etymaPagen.results.map<Widget>((e) => 
          etymaItem(
            context: context,
            etyma: e,
            trailing: EditDelete(
              edit: () async {
                var etyma = (await Navigator.pushNamed(
                  context, '/edit_etyma',
                  arguments:{'title':'编辑词根词缀','etyma': EtymaSerializer().from(e)})
                  ) as EtymaSerializer;
                if(etyma != null) await e.from(etyma).save();
                setState(() {});
              },
              delete: () {
                e.delete();
                _etymaPagen.results.remove(e);
                setState(() {});
              },
            ),
          )
        ).toList(),
      ),
    );
}




