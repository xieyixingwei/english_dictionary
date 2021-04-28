import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/custom_table.dart';
import 'package:flutter_prj/widgets/edit_delete.dart';


class ListWords extends StatefulWidget {
  @override
  _ListWordsState createState() => _ListWordsState();
}

class _ListWordsState extends State<ListWords> {
  WordPaginationSerializer _words = WordPaginationSerializer();
  static final List<String> _tagOptions = ['Tag'] + Global.wordTagOptions;
  static final List<String> _etymaOptions = ['词根'] + Global.etymaOptions;
  List<String> _ddBtnValues = [_tagOptions.first, _etymaOptions.first];
  num _perPage = 10;
  num _pageIndex = 1;
  static const _textStyle = const TextStyle(fontSize: 12,);

  @override
  void initState() {
    super.initState();
    retrieve();
  }

  void retrieve() async {
    await _words.retrieve(queries:{'page_size':_perPage, 'page_index':_pageIndex});
    setState((){});
  }

    @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        title: Text('编辑单词'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilter(context),
            _buildListWords(context),
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
          hint: Text('Tag', style: TextStyle(fontSize: 12, color: Color.fromRGBO(132,132,132,1.0))),
          value: _ddBtnValues[0],
          items: _tagOptions.map((e)=>DropdownMenuItem(child: Text(e, style: _textStyle,), value: e,)).toList(),
          onChanged: (v) {setState(() => _ddBtnValues[0] = v); _words.filter.tag__icontains = v != _tagOptions.first ? v : null;},
          underline: Divider(height:1, thickness: 1),
        ),
        DropdownButton(
          isDense: true,
          hint: Text('词根', style: TextStyle(fontSize: 12, color: Color.fromRGBO(132,132,132,1.0))),
          value: _ddBtnValues[1],
          items: _etymaOptions.map((e)=>DropdownMenuItem(child: Text(e, style: _textStyle,), value: e,)).toList(),
          onChanged: (v) {setState(() => _ddBtnValues[1] = v); _words.filter.etyma__icontains = v != _etymaOptions.first ? v : null;},
          underline: Divider(height:1, thickness: 1),
        ),
        TextButton(
          child: Text('添加单词', style: TextStyle(fontSize: 12)),
          onPressed: () async {
            var word = (await Navigator.pushNamed(context, '/edit_word', arguments: {'title':'添加单词'})) as WordSerializer;
            if(word != null && word.name.isNotEmpty) {
              var ret = await word.save();
              if(ret)
                _words.results.add(word);
            }
            setState((){});
          },
        ),
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
                  style: TextStyle(fontSize: 14,),
                  onChanged: (v) => _words.filter.name = v.trim().isEmpty ? null : v.trim(),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.only(left: 6, right: 6),
                    hintText: '单词',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      splashRadius: 1.0,
                      tooltip: '搜索',
                      icon: Icon(Icons.search),
                      onPressed: () async {
                        bool ret = await _words.retrieve(queries:{'page_size':_perPage, 'page_index':_pageIndex});
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
  }

  Widget _buildListWords(BuildContext context) =>
    Container(
      padding: EdgeInsets.fromLTRB(6, 0, 6, 10),
      child: CustomTable(
        count: (_words.count + _perPage/2) ~/ _perPage,
        index: _pageIndex,
        goto: (num index) async {
          _pageIndex = index;
          bool ret = await _words.retrieve(queries:{'page_size':_perPage, 'page_index':_pageIndex});
          if(ret) setState((){});
        },
        perPage: _perPage,
        perPages: [2, 5, 10, 20, 30, 50],
        perPageChange: (v) async {
          _pageIndex = 1;
          _perPage = v;
          bool ret = await _words.retrieve(queries:{'page_size':_perPage, 'page_index':_pageIndex});
          if(ret) setState((){});
        },
        rows: _words.results.map<Widget>((e) => 
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.only(left: 30, right: 30, top: 0, bottom: 0),
            title: Text(e.name),
            trailing: EditDelete(
              edit: () async {
                var word = (await Navigator.pushNamed(
                  context, '/edit_word',
                  arguments: {'title':'编辑单词','word':WordSerializer().from(e)})
                ) as WordSerializer;
                if(word != null) await e.from(word).save();
                setState(() {});
              },
              delete: () {e.delete(); setState(() => _words.results.remove(e));},
            ),
            onTap: () => Navigator.pushNamed(context, '/show_word', arguments: {'title': '${e.name}的$e', 'word': e}),
          )
        ).toList(),
      ),
    );
}
