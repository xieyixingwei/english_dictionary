import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/routes/edit/etyma/show_etyma.dart';
import 'package:flutter_prj/serializers/index.dart';


class EditEtymas extends StatefulWidget {

  @override
  _EditEtymasState createState() => _EditEtymasState();
}

class _EditEtymasState extends State<EditEtymas> {
  EtymaPaginationSerializer _etymas = EtymaPaginationSerializer();
  static final List<String> _typeOptions = ['All'] + Global.etymaTypeOptions;
  List<String> _selected = [_typeOptions.first];

  @override
  void initState() { 
    super.initState();
    _init();
  }

  _init() async {
    await _etymas.retrieve();
    setState((){});
  }

Widget _buildFilter(BuildContext context) =>
  Wrap(
    crossAxisAlignment: WrapCrossAlignment.end,
    spacing: 10.0,
    children: [
      Container(
        width: 100,
        child: TextField(
          onChanged: (v) => _etymas.filter.name__icontains = v.trim().isNotEmpty ? v.trim() : null,
          decoration: InputDecoration(
            labelText: '词根词缀',
            border: OutlineInputBorder(),
          ),
        ),
      ),
      Container(
        width: 100,
        child: DropdownButtonFormField(
          isExpanded: true,
          value: _selected[0],
          items: _typeOptions.map((e)=>DropdownMenuItem(child: Text(e), value: e,)).toList(),
          decoration: InputDecoration(
            labelText: "类型",
            border: OutlineInputBorder(),
          ),
          onChanged: (v) {
            setState(() => _selected[0] = v);
            _etymas.filter.type = v != _typeOptions.first ? Global.etymaTypeOptions.indexOf(v) : null;
          },
        ),
      ),
      IconButton(
        splashRadius: 1.0,
        tooltip: '搜索',
        icon: Icon(Icons.search),
        onPressed: () async {
          await _etymas.retrieve(queries:{"page_size": 10, "page_index":1});
          setState((){});
        },
      ),
      IconButton(
        splashRadius: 1.0,
        icon: Icon(Icons.add),
        tooltip: '添加词根词缀',
        onPressed: () async {
          var g = (await Navigator.pushNamed(context, '/edit_etyma', arguments:{'title':'添加词根词缀'})) as EtymaSerializer;
          if(g != null) {
            _etymas.results.add(g);
            Global.etymaOptions.add(g.name);
            await g.save();
          }
          setState((){});
        },
      ),
    ],
  );


  Widget _buildListEtyma(BuildContext context) =>
    Expanded(
      child: ListView(
        children: _etymas.results.map<Widget>(
          (e) => ShowEtyma(
            etyma: e,
            delete: () {e.delete(); setState(()=>_etymas.results.remove(e));},
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
                        _buildListEtyma(context),
                      ],
                    ),
                  ),
                );
  }
}



