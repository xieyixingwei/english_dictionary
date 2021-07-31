import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/routes/dialog/show_dialog.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/edit_delete.dart';
import 'package:flutter_prj/widgets/pagination.dart';


class ListDialog extends StatefulWidget {

  @override
  _ListDialogState createState() => _ListDialogState();
}

class _ListDialogState extends State<ListDialog> {
  static final List<String> _tagOptions = ['Tag'] + Global.dialogTagOptions;
  DialogPaginationSerializer _dialogPagen = DialogPaginationSerializer();
  String _tagSelect = 'Tag';


  @override
  void initState() { 
    _init();
    super.initState();
  }

  _init() async {
    await _dialogPagen.retrieve();
    setState((){});
  }

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        title: Text('编辑对话'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
        Text('过滤:', style: TextStyle(fontSize: 12, color: Color.fromRGBO(132,132,132,1.0), fontWeight: FontWeight.bold)),
        DropdownButton(
          isDense: true,
          value: _tagSelect,
          items: _tagOptions.map((e)=>DropdownMenuItem(child: Text(e, style: TextStyle(fontSize: 12,),), value: e,)).toList(),
          onChanged: (v) {
            _dialogPagen.filter.tag__icontains = v != _tagOptions.first ? v : null;
            setState(() => _tagSelect = v);
          },
          underline: Divider(height:1, thickness: 1),
        ),
        TextButton(
          child: Text('添加对话'),
          onPressed: () async {
            var d = (await Navigator.pushNamed(context, '/edit_dialog',
                                               arguments:{
                                                  'title': '添加对话',
                                                  'dialog': DialogSerializer()})
                    ) as DialogSerializer;
            if(d != null) {
              var ret = await d.save();
              if(ret) _dialogPagen.results.add(d);
              setState(() {});
            }
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
            onChanged: (val) => _dialogPagen.filter.title__icontains = val.trim().isEmpty ? null : val.trim(),
            decoration: InputDecoration(
              labelText: 'title关键字',
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                splashRadius: 1.0,
                tooltip: '搜索',
                icon: Icon(Icons.search),
                onPressed: () async {
                  bool ret = await _dialogPagen.retrieve();
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
        pages: (_dialogPagen.count / _dialogPagen.queryset.page_size).ceil(),
        curPage: _dialogPagen.queryset.page_index,
        goto: (num index) async {
          _dialogPagen.queryset.page_index = index;
          bool ret = await _dialogPagen.retrieve();
          if(ret) setState((){});
        },
        perPage: _dialogPagen.queryset.page_size,
        perPageSet: [10, 20, 30, 50],
        perPageChange: (v) async {
          _dialogPagen.queryset.page_index = 1;
          _dialogPagen.queryset.page_size = v;
          bool ret = await _dialogPagen.retrieve();
          if(ret) setState((){});
        },
        rows: _dialogPagen.results.map<Widget>((e) => 
          dialogItem(
            context: context,
            dialog: e,
            trailing: EditDelete(
              edit: () async {
                var dialog = (await Navigator.pushNamed(context, '/edit_dialog',
                                                              arguments:{
                                                                'title': '编辑对话',
                                                                'dialog': DialogSerializer().from(e)})
                                    ) as DialogSerializer;
                if(dialog != null) await e.from(dialog).save();
                setState(() {});
              },
              delete: () {
                e.delete();
                _dialogPagen.results.remove(e);
                setState(() {});
              },
            ),
          )
        ).toList(),
      ),
    );
}




