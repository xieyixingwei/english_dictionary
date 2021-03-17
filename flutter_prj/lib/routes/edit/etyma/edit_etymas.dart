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

  Widget _buildFilter(BuildContext context) {
    final textStyle = const TextStyle(fontSize: 12,);
    return Column(
      children: [
        Row(
          children: [
            Expanded(flex: 1, child: Container(),),
            Expanded(
              flex: 5,
              child: TextField(
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
            ),
            SizedBox(width: 10,),
            TextButton(
              child: Text('添加词根词缀'),
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
            Expanded(flex: 1, child: Container(),),
          ],
        ),
        Wrap(
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            Text('类型: ', style: TextStyle(fontSize: 12, color: Color.fromRGBO(132,132,132,1.0))),
            DropdownButton(
              elevation: 0,
              value: _selected[0],
              items: _typeOptions.map((e)=>DropdownMenuItem(child: Text(e, style: textStyle,), value: e,)).toList(),
              onChanged: (v) {
                setState(() => _selected[0] = v);
                _etymas.filter.type = v != _typeOptions.first ? Global.etymaTypeOptions.indexOf(v) : null;
              },
              underline: Container(width: 0, height:0,),
            ),
          ],
        )
      ],
    );
  }

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




