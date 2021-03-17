import 'package:flutter/material.dart';
import 'package:flutter_prj/routes/edit/distinguish_word/show_distinguish.dart';
import 'package:flutter_prj/serializers/index.dart';


class EditDistinguishes extends StatefulWidget {

  @override
  _EditDistinguishesState createState() => _EditDistinguishesState();
}

class _EditDistinguishesState extends State<EditDistinguishes> {
  DistinguishPaginationSerializer _distinguishes = DistinguishPaginationSerializer();

  @override
  void initState() { 
    super.initState();
    _init();
  }

  _init() async {
    await _distinguishes.retrieve();
    setState((){});
  }

  Widget _buildFilter(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(flex: 1, child: Container(),),
            Expanded(
              flex: 5,
              child: TextField(
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
            ),
            SizedBox(width: 10,),
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
            Expanded(flex: 1, child: Container(),),
          ],
        ),
      ],
    );
}


  Widget _buildListDistinguishs(BuildContext context) =>
    Expanded(
      child: ListView(
        children: _distinguishes.results.map<Widget>(
          (e) => ShowDistinguish(
            distinguish: e,
            delete: () {e.delete(); setState(()=>_distinguishes.results.remove(e));},
          )
        ).toList(),
      )
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
                appBar: AppBar(
                  title: Text('编辑单词辨析'),
                ),
                body: Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFilter(context),
                        SizedBox(height: 20,),
                        _buildListDistinguishs(context),
                      ],
                    ),
                  ),
                );
  }
}




