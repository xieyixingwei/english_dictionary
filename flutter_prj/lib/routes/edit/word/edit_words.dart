import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/routes/edit/word/show_word.dart';
import 'package:flutter_prj/serializers/index.dart';


class EditWords extends StatefulWidget {
  @override
  _EditWordsState createState() => _EditWordsState();
}

class _EditWordsState extends State<EditWords> {
  WordPaginationSerializer _words = WordPaginationSerializer();
  static final List<String> _tagOptions = ['All'] + Global.wordTagOptions;
  static final List<String> _etymaOptions = ['All'] + Global.etymaOptions;
  List<String> _ddBtnValues = [_tagOptions.first, _etymaOptions.first];
  num _pageSize = 10;
  num _pageIndex = 1;

  @override
  void initState() {
    super.initState();
    retrieve();
  }

  void retrieve() async {
    await _words.retrieve(queries:{'page_size':_pageSize, 'page_index':_pageIndex});
    setState((){});
  }

  Widget _buildListWords(BuildContext context) {
    List<Widget> children = _words.results.map<Widget>(
          (e) => ShowWord(
            word: e,
            delete: () {e.delete(); setState(()=>_words.results.remove(e));},
          )
        ).toList();

    return Expanded(
      child: ListView(
        children: children,
      )
    );
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
                onChanged: (val) => _words.filter.name = val.trim().length == 0 ? null : val.trim(),
                decoration: InputDecoration(
                  hintText: '单词',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    splashRadius: 1.0,
                    tooltip: '搜索',
                    icon: Icon(Icons.search),
                    onPressed: () async {
                      bool ret = await _words.retrieve(queries:{'page_size':_pageSize, 'page_index':_pageIndex});
                      if(ret) setState((){});
                    },
                  ),
                ),
              ),
            ),
            SizedBox(width: 10,),
            TextButton(
              child: Text('添加单词'),
              onPressed: () async {
                var word = (await Navigator.pushNamed(context, '/edit_word', arguments: {'title':'添加句子'})) as WordSerializer;
                if(word != null && word.name.isNotEmpty) {
                  _words.results.add(word);
                  await word.save();
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
            Text('Tag: ', style: TextStyle(fontSize: 12, color: Color.fromRGBO(132,132,132,1.0))),
            DropdownButton(
              elevation: 0,
              value: _ddBtnValues[0],
              items: _tagOptions.map((e)=>DropdownMenuItem(child: Text(e, style: textStyle,), value: e,)).toList(),
              onChanged: (v) {setState(() => _ddBtnValues[0] = v); _words.filter.tag__icontains = v != _tagOptions.first ? v : null;},
              underline: Container(width: 0, height:0,),
            ),
            SizedBox(width: 8,),
            Text('时态: ', style: TextStyle(fontSize: 12, color: Color.fromRGBO(132,132,132,1.0))),
            DropdownButton(
              elevation: 0,
              value: _ddBtnValues[1],
              items: _etymaOptions.map((e)=>DropdownMenuItem(child: Text(e, style: textStyle,), value: e,)).toList(),
              onChanged: (v) {setState(() => _ddBtnValues[1] = v); _words.filter.etyma__icontains = v != _etymaOptions.first ? v : null;},
              underline: Container(width: 0, height:0,),
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
                appBar: AppBar(
                  title: Text('编辑单词'),
                ),
                body: Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFilter(context),
                        SizedBox(height: 20,),
                        _buildListWords(context),
                      ],
                    ),
                  ),
                );
  }
}
