import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/custom_table.dart';
import 'package:flutter_prj/widgets/edit_delete.dart';


class ListSentences extends StatefulWidget {
  @override
  _ListSentencesState createState() => _ListSentencesState();
}

class _ListSentencesState extends State<ListSentences> {
  SentencePaginationSerializer _sentences = SentencePaginationSerializer();
  static final List<String> _typeOptions = ['类型', '句子', '短语'];
  static final List<String> _tagOptions = ['Tag'] + Global.sentenceTagOptions;
  static final List<String> _tenseOptions = ['时态'] + Global.tenseOptions;
  static final List<String> _formOptions = ['句型'] + Global.sentenceFormOptions;
  List<String> ddBtnValues = [_typeOptions.first, _tagOptions.first, _tenseOptions.first, _formOptions.first];
  num _perPage = 2;
  num _pageIndex = 1;
  final textStyle = const TextStyle(fontSize: 12,);

  @override
  void initState() {
    super.initState();

    retrieve();
  }

  void retrieve() async {
    await _sentences.retrieve(queries:{'page_size':_perPage, 'page_index':_pageIndex});
    setState((){});
  }

  Widget _buildListSentences(BuildContext context) =>
  SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(6, 0, 6, 10),
      child: CustomTable(
        count: (_sentences.count + _perPage/2) ~/ _perPage,
        index: _pageIndex,
        goto: (num index) async {
          _pageIndex = index;
          bool ret = await _sentences.retrieve(queries:{'page_size':_perPage, 'page_index':_pageIndex});
          if(ret) setState((){});
        },
        perPage: _perPage,
        perPages: [2, 5, 10, 20, 30, 50],
        perPageChange: (v) async {
          _pageIndex = 1;
          _perPage = v;
          bool ret = await _sentences.retrieve(queries:{'page_size':_perPage, 'page_index':_pageIndex});
          if(ret) setState((){});
        },
        rows: _sentences.results.map<Widget>((e) => 
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.only(left: 30, right: 30, top: 0, bottom: 0),
            minLeadingWidth: 20,
            leading: Text('${e.id}'),
            title: Text(e.en),
            subtitle: Text(e.cn),
            trailing: EditDelete(
              edit: () async {
                var sentence = (await Navigator.pushNamed(
                  context, '/edit_sentence',
                  arguments: {'title':'编辑句子','sentence':SentenceSerializer().from(e)})
                ) as SentenceSerializer;
                if(sentence != null) await e.from(sentence).save();
                setState(() {});
              },
              delete: () {e.delete(); setState(() => _sentences.results.remove(e));},
            ),
          )
        ).toList(),
      ),
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              title: Text('编辑例句'),
            ),
            body: Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFilter(context),
                    _buildListSentences(context),
                  ],
                ),
              ),
            );
  }

  Widget _buildFilterOptions(BuildContext context) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 10,),
        Text('过滤:', style: TextStyle(fontSize: 12, color: Color.fromRGBO(132,132,132,1.0), fontWeight: FontWeight.bold)),
        SizedBox(width: 10,),
        DropdownButton(
          value: ddBtnValues.first,
          items: _typeOptions.map((e)=>DropdownMenuItem(child: Text(e, style: textStyle,), value: e,)).toList(),
          onChanged: (v) {
            num index = _typeOptions.indexOf(v);
            _sentences.filter.type = index == 0 ? null : index - 1;
            setState(() => ddBtnValues.first = v);
          },
          underline: Divider(height:1, thickness: 1),
        ),
        SizedBox(width: 10,),
        DropdownButton(
          value: ddBtnValues[1],
          items: _tagOptions.map((e)=>DropdownMenuItem(child: Text(e, style: textStyle,), value: e,)).toList(),
          onChanged: (v) {
            _sentences.filter.tag__icontains = v != _tagOptions.first ? v : null;
            setState(() => ddBtnValues[1] = v);
          },
          underline: Divider(height:1, thickness: 1),
        ),
        SizedBox(width: 10,),
        DropdownButton(
          elevation: 0,
          value: ddBtnValues[2],
          items: _tenseOptions.map((e)=>DropdownMenuItem(child: Text(e, style: textStyle,), value: e,)).toList(),
          onChanged: (v) {
            _sentences.filter.tense = v != _tenseOptions.first ? v : null;
            setState(() => ddBtnValues[2] = v);
          },
          underline: Divider(height:1, thickness: 1),
        ),
        SizedBox(width: 10,),
        DropdownButton(
          elevation: 0,
          value: ddBtnValues[3],
          items: _formOptions.map((e)=>DropdownMenuItem(child: Text(e, style: textStyle,), value: e,)).toList(),
          onChanged: (v) {
            _sentences.filter.pattern__icontains = v != _formOptions.first ? v : null;
            setState(() => ddBtnValues[3] = v);
          },
          underline: Divider(height:1, thickness: 1),
        ),
        SizedBox(width: 10,),
        TextButton(
          child: Text('添加例句'),
          onPressed: () async {
            var s = (await Navigator.pushNamed(context, '/edit_sentence', arguments: {'title':'添加句子'})) as SentenceSerializer;
            if(s != null) {
              var find = _sentences.results.where((e) => e.id == s.id);
              if(find.isEmpty) _sentences.results.add(s);
              else find.first.from(s);
              await s.save();
            }
            setState((){});
          },
        ),
      ],
    );

  Widget _buildFilter(BuildContext context) {
    return Container(
        child: Row(
          children: [
            Expanded(flex: 1, child: Container(),),
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  TextField(
                    style: textStyle,
                    maxLines: null,
                    onChanged: (v) {
                      _sentences.filter.en__icontains = v.trim().isNotEmpty ? v.trim() : null;
                    },
                    decoration: InputDecoration(
                      hintText: '关键字',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        splashRadius: 1.0,
                        tooltip: '搜索',
                        icon: Icon(Icons.search),
                        onPressed: () async {
                          bool ret = await _sentences.retrieve(queries:{'page_size': 10, 'page_index':1});
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
}
