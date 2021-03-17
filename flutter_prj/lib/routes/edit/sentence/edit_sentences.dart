import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/routes/edit/sentence/show_sentence.dart';
import 'package:flutter_prj/serializers/index.dart';


class EditSentences extends StatefulWidget {
  @override
  _EditSentencesState createState() => _EditSentencesState();
}

class _EditSentencesState extends State<EditSentences> {
  SentencePaginationSerializer _sentences = SentencePaginationSerializer();
  static final List<String> _typeOptions = ['All', '句子', '短语'];
  static final List<String> _tagOptions = ['All'] + Global.sentenceTagOptions;
  static final List<String> _tenseOptions = ['All'] + Global.tenseOptions;
  static final List<String> _formOptions = ['All'] + Global.sentenceFormOptions;
  List<String> ddBtnValues = [_typeOptions.first, _tagOptions.first, _tenseOptions.first, _formOptions.first];
  num _pageSize = 10;
  num _pageIndex = 1;

  @override
  void initState() {
    super.initState();

    retrieve();
  }

  void retrieve() async {
    await _sentences.retrieve(queries:{'page_size':_pageSize, 'page_index':_pageIndex});
    setState((){});
  }

  Widget _buildListSentences(BuildContext context) {
    List<Widget> children = _sentences.results.map<Widget>(
          (e) => ShowSentence(
            sentence: e,
            delete: () {e.delete(); setState(()=>_sentences.results.remove(e));},
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
              value: ddBtnValues.first,
              items: _tagOptions.map((e)=>DropdownMenuItem(child: Text(e, style: textStyle,), value: e,)).toList(),
              onChanged: (v) {
                num index = _typeOptions.indexOf(v);
                _sentences.filter.type = index == 0 ? null : index - 1;
                setState(() => ddBtnValues.first = v);
              },
              underline: Container(width: 0, height:0,),
            ),
            SizedBox(width: 8,),
            Text('Tag: ', style: TextStyle(fontSize: 12, color: Color.fromRGBO(132,132,132,1.0))),
            DropdownButton(
              elevation: 0,
              value: ddBtnValues[1],
              items: _tagOptions.map((e)=>DropdownMenuItem(child: Text(e, style: textStyle,), value: e,)).toList(),
              onChanged: (v) {
                _sentences.filter.tag__icontains = v != _tagOptions.first ? v : null;
                setState(() => ddBtnValues[1] = v);
              },
              underline: Container(width: 0, height:0,),
            ),
            SizedBox(width: 8,),
            Text('时态: ', style: TextStyle(fontSize: 12, color: Color.fromRGBO(132,132,132,1.0))),
            DropdownButton(
              elevation: 0,
              value: ddBtnValues[2],
              items: _tenseOptions.map((e)=>DropdownMenuItem(child: Text(e, style: textStyle,), value: e,)).toList(),
              onChanged: (v) {
                _sentences.filter.tense = v != _tenseOptions.first ? v : null;
                setState(() => ddBtnValues[2] = v);
              },
              underline: Container(width: 0, height:0,),
            ),
            SizedBox(width: 8,),
            Text('句型: ', style: TextStyle(fontSize: 12, color: Color.fromRGBO(132,132,132,1.0))),
            DropdownButton(
              elevation: 0,
              value: ddBtnValues[3],
              items: _formOptions.map((e)=>DropdownMenuItem(child: Text(e, style: textStyle,), value: e,)).toList(),
              onChanged: (v) {
                _sentences.filter.pattern__icontains = v != _formOptions.first ? v : null;
                setState(() => ddBtnValues[3] = v);
              },
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
                  title: Text('编辑例句'),
                ),
                body: Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFilter(context),
                        SizedBox(height: 20,),
                        _buildListSentences(context),
                      ],
                    ),
                  ),
                );
  }
}


/*
class EditSentences extends StatefulWidget {
  @override
  _EditSentencesState createState() => _EditSentencesState();
}

class _EditSentencesState extends State<EditSentences> {
  SentencesPaginationSerializer _sentences = SentencesPaginationSerializer();
  static final List<String> typeOptions = ['所有的类型', '句子', '短语'];
  static final List<String> tagOptions = ['请选择Tags'] + Global.sentenceTagOptions;
  static final List<String> tenseOptions = ['请选择Tense'] + Global.tenseOptions;
  static final List<String> formOptions = ['请选择句型'] + Global.sentenceFormOptions;
  List<String> _ddBtnValues = [typeOptions.first, tagOptions.first, tenseOptions.first, formOptions.first];

  @override
  void initState() {
    super.initState();
    _retrieve();
  }

  void _retrieve() async {
    var tmp = await _sentences.retrieve(queryParameters:{'page_size': 10, 'page_index':1}, update: true);
    setState(() => _sentences = tmp);
  }

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        title: Text('编辑例句'),
      ),
      body: SingleChildScrollView(
        //scrollDirection: Axis.horizontal,
        child: PaginatedDataTable(
          header: Text('header'),
          columns: [
            DataColumn(label: Text('句子')),
          ],
          actions: [
            DropdownButton(
              value: _ddBtnValues.first,
              items: typeOptions.map((e)=>DropdownMenuItem(child: Text(e), value: e,)).toList(),
              onChanged: (v) {
                num index = typeOptions.indexOf(v);
                _sentences.filter.s_type = index == 0 ? null : index - 1;
                setState(() => _ddBtnValues.first = v);
              },
            ),
            IconButton(
              splashRadius: 1.0,
              icon: Icon(Icons.search),
              onPressed: () async {
                var tmp = await _sentences.retrieve(queryParameters:{'page_size': 10, 'page_index':1}, update: true);
                setState(() => _sentences = tmp);
              },
            ),
            InkWell(
              child: Text('添加句子', style: TextStyle(color: Theme.of(context).primaryColor,),),
              onTap: () async {
                SentenceSerializer sentence = SentenceSerializer();
                var s = await Navigator.pushNamed(context, '/edit_sentence', arguments: {'title':'添加句子','sentence':sentence});
                setState(() => _sentences.results.add(s));
                sentence.save();
              },
            ),
          ],
          source: SentencesSource(_sentences.results),
        ),
      ),
    );
    
}

class SentencesSource extends DataTableSource {
  final List<SentenceSerializer> sentences;

  SentencesSource(this.sentences);

  @override
  DataRow getRow(int index) {
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Row(children:[ShowSentence(sentence:sentences[index])])),
      ],
    );
  }
  @override
  int get selectedRowCount {
    return 0;
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => sentences.length;

}
*/
