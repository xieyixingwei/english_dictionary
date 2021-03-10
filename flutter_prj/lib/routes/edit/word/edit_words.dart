import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/routes/edit/word/show_word.dart';
import 'package:flutter_prj/serializers/index.dart';


class EditWords extends StatefulWidget {
  @override
  _EditWordsState createState() => _EditWordsState();
}

class _EditWordsState extends State<EditWords> {
  WordsPaginationSerializer _words = WordsPaginationSerializer();
  static final List<String> _tagOptions = ['请选择Tags'] + Global.wordTagOptions;
  //static final List<String> tenseOptions = ['请选择词根'] + Global.;
  List<String> _ddBtnValues = [_tagOptions.first];
  num _pageSize = 10;
  num _pageIndex = 1;

  @override
  void initState() {
    super.initState();
    retrieve();
  }

  void retrieve() async {
    await _words.retrieve(queryParameters:{'page_size':_pageSize, 'page_index':_pageIndex}, update: true);
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

  Widget _buildFilter(BuildContext context) =>
    Wrap(
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.end,
      spacing: 10.0,
      children: [
        Container(
          width: 100,
          child: TextField(
            maxLines: null,
            onChanged: (val) => _words.filter.w_name = val.trim().length == 0 ? null : val.trim(),
            decoration: InputDecoration(
              labelText: '单词',
            ),
          ),
        ),
        DropdownButton(
          value: _ddBtnValues[0],
          items: _tagOptions.map((e)=>DropdownMenuItem(child: Text(e), value: e,)).toList(),
          onChanged: (v) {setState(() => _ddBtnValues[0] = v); _words.filter.w_tags__icontains = v != _tagOptions.first ? v : null;},
        ),
        IconButton(
          splashRadius: 1.0,
          tooltip: '搜索',
          icon: Icon(Icons.search),
          onPressed: () async {
            await _words.retrieve(queryParameters:{'page_size':_pageSize, 'page_index':_pageIndex}, update: true);
            setState((){});
          },
        ),
        IconButton(
          splashRadius: 1.0,
          tooltip: '添加单词',
          icon: Icon(Icons.add),
          onPressed: () async {
            var word = (await Navigator.pushNamed(context, '/edit_word', arguments: {'title':'添加句子'})) as WordSerializer;
            if(word != null) {
              _words.results.add(word);
              word.create(update: true);
            }
            setState((){});
          },
        ),
      ],
    );

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
