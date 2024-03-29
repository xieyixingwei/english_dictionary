import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/routes/common/common.dart';
import 'package:flutter_prj/routes/word/show_word.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/pagination.dart';
import 'package:flutter_prj/widgets/edit_delete.dart';


class ListWords extends StatefulWidget {
  @override
  _ListWordsState createState() => _ListWordsState();
}

class _ListWordsState extends State<ListWords> {
  WordPaginationSerializer _wordPagen = WordPaginationSerializer();
  static final List<String> _tagOptions = ['Tag'] + Global.wordTagOptions;
  static final List<String> _etymaOptions = ['词根'] + Global.etymaOptions;
  List<String> _ddBtnValues = [_tagOptions.first, _etymaOptions.first];
  static const _textStyle = const TextStyle(fontSize: 12,);

  @override
  void initState() {
    super.initState();
    retrieve();
  }

  void retrieve() async {
    await _wordPagen.retrieve();
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
        padding: EdgeInsets.fromLTRB(6, 20, 6, 20),
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
          onChanged: (v) {setState(() => _ddBtnValues[0] = v); _wordPagen.filter.tag__icontains = v != _tagOptions.first ? v : null;},
          underline: Divider(height:1, thickness: 1),
        ),
        DropdownButton(
          isDense: true,
          hint: Text('词根', style: TextStyle(fontSize: 12, color: Color.fromRGBO(132,132,132,1.0))),
          value: _ddBtnValues[1],
          items: _etymaOptions.map((e)=>DropdownMenuItem(child: Text(e, style: _textStyle,), value: e,)).toList(),
          onChanged: (v) {setState(() => _ddBtnValues[1] = v); _wordPagen.filter.etyma__icontains = v != _etymaOptions.first ? v : null;},
          underline: Divider(height:1, thickness: 1),
        ),
        TextButton(
          child: Text('添加单词', style: TextStyle(fontSize: 12)),
          onPressed: () async {
            var word = (await Navigator.pushNamed(context, '/edit_word', arguments: {'title':'添加单词'})) as WordSerializer;
            if(word != null && word.name.isNotEmpty) {
              var ret = await word.save();
              if(ret)
                _wordPagen.results.add(word);
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
          style: TextStyle(fontSize: 14,),
          onChanged: (v) => _wordPagen.filter.name = v.trim().isEmpty ? null : v.trim(),
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
                bool ret = await _wordPagen.retrieve();
                if(ret) setState((){});
              },
            ),
          ),
        ),
        _buildFilterOptions(context),
      ],
    ),
  );

  Widget _buildListWords(BuildContext context) =>
    Container(
      padding: EdgeInsets.only(top: 10),
      child: Pagination(
        pages: (_wordPagen.count / _wordPagen.queryset.page_size).ceil(),
        curPage: _wordPagen.queryset.page_index,
        goto: (num index) async {
          _wordPagen.queryset.page_index = index;
          bool ret = await _wordPagen.retrieve();
          if(ret) setState((){});
        },
        perPage: _wordPagen.queryset.page_size,
        perPageSet: [10, 20, 30, 50],
        perPageChange: (v) async {
          _wordPagen.queryset.page_index = 1;
          _wordPagen.queryset.page_size = v;
          bool ret = await _wordPagen.retrieve();
          if(ret) setState((){});
        },
        rows: _wordPagen.results.map<Widget>((e) => 
          wordItem(
            context: context,
            word: e,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.star, color: e.studyWordSet.isEmpty ? Colors.black54 : Colors.redAccent, size: 17),
                  tooltip: '收藏',
                  splashRadius: 5.0,
                  onPressed: () async {
                    var categories = e.studyWordSet.isEmpty ? <String>[] : e.studyWordSet.first.categories;
                    String category = await popSelectWordCategoryDialog(context, categories);
                    if(category == null) return;
                    if(categories.contains(category)) {
                      e.studyWordSet.first.categories.remove(category);
                      if(e.studyWordSet.first.categories.isEmpty) {
                        await e.studyWordSet.first.delete();
                        e.studyWordSet.clear();
                      } else {
                        await e.studyWordSet.first.save();
                      }
                    } else {
                      if(e.studyWordSet.isEmpty) {
                        var newSw = StudyWordSerializer()..word = WordSerializer().from(e) // 不能直接赋值，要用from()深拷贝赋值，不然会进入死循环。
                                                         ..foreignUser = Global.localStore.user.id
                                                         ..inplan = true
                                                         ..categories.add(category);
                        var ret = await newSw.save();
                        if(ret) e.studyWordSet.add(newSw);
                      } else {
                        e.studyWordSet.first.categories.add(category);
                        await e.studyWordSet.first.save();
                      }
                    }
                    setState(() {});
                  },
                ),
                EditDelete(
                  edit: () async {
                    var word = (await Navigator.pushNamed(
                      context, '/edit_word',
                      arguments: {'title':'编辑单词','word':WordSerializer().from(e)})
                    ) as WordSerializer;
                    if(word != null) await e.from(word).save();
                    setState(() {});
                  },
                  delete: () {
                    e.delete();
                    _wordPagen.results.remove(e);
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
