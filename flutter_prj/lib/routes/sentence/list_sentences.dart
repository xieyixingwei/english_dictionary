import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/routes/common/common.dart';
import 'package:flutter_prj/routes/sentence/show_sentences.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/edit_delete.dart';
import 'package:flutter_prj/widgets/pagination.dart';


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
  num _perPage = 10;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              title: Text('编辑例句'),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(6, 20, 6, 20),
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
    Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 10,
      children: [
        SizedBox(width: 2,),
        Text('过滤:', style: TextStyle(fontSize: 12, color: Color.fromRGBO(132,132,132,1.0), fontWeight: FontWeight.bold)),
        DropdownButton(
          isDense: true,
          value: ddBtnValues.first,
          items: _typeOptions.map((e)=>DropdownMenuItem(child: Text(e, style: textStyle,), value: e,)).toList(),
          onChanged: (v) {
            num index = _typeOptions.indexOf(v);
            _sentences.filter.type = index == 0 ? null : index - 1;
            setState(() => ddBtnValues.first = v);
          },
          underline: Divider(height:1, thickness: 1),
        ),
        DropdownButton(
          isDense: true,
          value: ddBtnValues[1],
          items: _tagOptions.map((e)=>DropdownMenuItem(child: Text(e, style: textStyle,), value: e,)).toList(),
          onChanged: (v) {
            _sentences.filter.tag__icontains = v != _tagOptions.first ? v : null;
            setState(() => ddBtnValues[1] = v);
          },
          underline: Divider(height:1, thickness: 1),
        ),
        DropdownButton(
          isDense: true,
          value: ddBtnValues[2],
          items: _tenseOptions.map((e)=>DropdownMenuItem(child: Text(e, style: textStyle,), value: e,)).toList(),
          onChanged: (v) {
            _sentences.filter.tense = v != _tenseOptions.first ? v : null;
            setState(() => ddBtnValues[2] = v);
          },
          underline: Divider(height:1, thickness: 1),
        ),
        DropdownButton(
          isDense: true,
          value: ddBtnValues[3],
          items: _formOptions.map((e)=>DropdownMenuItem(child: Text(e, style: textStyle,), value: e,)).toList(),
          onChanged: (v) {
            _sentences.filter.pattern__icontains = v != _formOptions.first ? v : null;
            setState(() => ddBtnValues[3] = v);
          },
          underline: Divider(height:1, thickness: 1),
        ),
        TextButton(
          child: Text('添加例句', style: TextStyle(fontSize: 12)),
          onPressed: () async {
            var s = (await Navigator.pushNamed(context, '/edit_sentence', arguments: {'title':'添加句子'})) as SentenceSerializer;
            if(s != null) {
              bool ret = await s.save();
              if(ret) {
                var find = _sentences.results.where((e) => e.id == s.id);
                if(find.isEmpty) _sentences.results.add(s);
                else find.first.from(s);
              }
            }
            setState((){});
          },
        ),
      ],
    );

  Widget _buildFilter(BuildContext context) =>
    Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
    );
  
  Widget _buildListSentences(BuildContext context) =>
    Container(
      margin: EdgeInsets.only(top: 10),
      child: Pagination(
        pages: (_sentences.count / _perPage).ceil(),
        curPage: _pageIndex,
        goto: (num index) async {
          _pageIndex = index;
          bool ret = await _sentences.retrieve(queries:{'page_size':_perPage, 'page_index':_pageIndex});
          if(ret) setState((){});
        },
        perPage: _perPage,
        perPageSet: [10, 20, 30, 50],
        perPageChange: (v) async {
          _pageIndex = 1;
          _perPage = v;
          bool ret = await _sentences.retrieve(queries:{'page_size':_perPage, 'page_index':_pageIndex});
          if(ret) setState((){});
        },
        rows: _sentences.results.map<Widget>((e) => 
          sentenceItem(
            context: context,
            sentence: e,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.star, color: e.studySentenceSet.isEmpty ? Colors.black54 : Colors.redAccent, size: 17),
                  tooltip: '收藏',
                  splashRadius: 5.0,
                  onPressed: () async {
                    var categories = e.studySentenceSet.isEmpty ? <String>[] : e.studySentenceSet.first.categories;
                    String category = await popSelectSentenceCategoryDialog(context, categories);
                    if(category == null) return;
                    if(categories.contains(category)) {
                      e.studySentenceSet.first.categories.remove(category);
                      if(e.studySentenceSet.first.categories.isEmpty) {
                        await e.studySentenceSet.first.delete();
                        e.studySentenceSet.clear();
                      } else {
                        await e.studySentenceSet.first.save();
                      }
                    } else {
                      if(e.studySentenceSet.isEmpty) {
                        var newSs = StudySentenceSerializer()..sentence = SentenceSerializer().from(e) // 不能直接赋值，要用from()深拷贝赋值，不然会进入死循环。
                                                         ..foreignUser = Global.localStore.user.id
                                                         ..categories.add(category);
                        var ret = await newSs.save();
                        if(ret) e.studySentenceSet.add(newSs);
                      } else {
                        e.studySentenceSet.first.categories.add(category);
                        await e.studySentenceSet.first.save();
                      }
                    }
                    setState(() {});
                  },
                ),
                EditDelete(
                  edit: () async {
                    var sentence = (await Navigator.pushNamed(context,
                                                              '/edit_sentence',
                                                              arguments: {
                                                                'title': '编辑句子',
                                                                'sentence': SentenceSerializer().from(e)})
                                    ) as SentenceSerializer;
                    if(sentence != null) await e.from(sentence).save();
                    setState(() {});
                  },
                  delete: () {
                    e.delete();
                    _sentences.results.remove(e);
                    setState(() {});
                  },
                ),
              ]
            )
          )
        ).toList(),
      ),
    );
}
