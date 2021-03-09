import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/routes/edit/edit_sentence/show_sentence.dart';
import 'package:flutter_prj/serializers/index.dart';


class EditSentences extends StatefulWidget {
  @override
  _EditSentencesState createState() => _EditSentencesState();
}

class _EditSentencesState extends State<EditSentences> {
  SentencesPaginationSerializer sentences = SentencesPaginationSerializer();
  static final List<String> typeOptions = ['所有的类型', '句子', '短语'];
  static final List<String> tagOptions = ['请选择Tags'] + Global.sentenceTagOptions;
  static final List<String> tenseOptions = ['请选择Tense'] + Global.tenseOptions;
  static final List<String> formOptions = ['请选择句型'] + Global.sentenceFormOptions;
  List<String> ddBtnValues = [typeOptions.first, tagOptions.first, tenseOptions.first, formOptions.first];

  @override
  void initState() {
    super.initState();

    retrieve();
  }

  void retrieve() async {
    await sentences.retrieve(queryParameters:{'page_size': 10, 'page_index':1}, update: true);
    setState((){});
  }

  Widget _buildListSentences(BuildContext context) =>
    Expanded(
      child: ListView(
        children: sentences.results.map<Widget>(
          (e) => ShowSentence(
            sentence: e,
            delete: () {e.delete(); setState(()=>sentences.results.remove(e));},)).toList(),
      )
    );

  Widget _buildFilter(BuildContext context) =>
    Wrap(
      spacing: 8.0,
      children: [
        Expanded(
          flex: 1,
          child: TextField(
            onChanged: (val) => sentences.filter.s_en__icontains = val.trim().length == 0 ? null : val.trim(),
            decoration: InputDecoration(
              labelText: '英文关键字',
            ),
          ),
        ),
        SizedBox(width: 10,),
        Expanded(
          flex: 1,
          child: TextField(
            onChanged: (val) => sentences.filter.s_ch__icontains = val.trim().length == 0 ? null : val.trim(),
            decoration: InputDecoration(
              labelText: '中文关键字',
            ),
          ),
        ),
        SizedBox(width: 10,),
        DropdownButton(
          value: ddBtnValues.first,
          items: typeOptions.map((e)=>DropdownMenuItem(child: Text(e), value: e,)).toList(),
          onChanged: (v) {
            num index = typeOptions.indexOf(v);
            sentences.filter.s_type = index == 0 ? null : index - 1;
            setState(() => ddBtnValues.first = v);
          },
        ),
        SizedBox(width: 10,),
        DropdownButton(
          value: ddBtnValues[1],
          items: tagOptions.map((e)=>DropdownMenuItem(child: Text(e), value: e,)).toList(),
          onChanged: (v) {setState(() => ddBtnValues[1] = v); sentences.filter.s_tags__icontains = v != tagOptions.first ? v : null;},
        ),
        SizedBox(width: 10,),
        DropdownButton(
          value: ddBtnValues[2],
          items: tenseOptions.map((e)=>DropdownMenuItem(child: Text(e), value: e,)).toList(),
          onChanged: (v) {setState(() => ddBtnValues[2] = v); sentences.filter.s_tense__icontains = v != tenseOptions.first ? v : null;},
        ),
        SizedBox(width: 10,),
        DropdownButton(
          value: ddBtnValues[3],
          items: formOptions.map((e)=>DropdownMenuItem(child: Text(e), value: e,)).toList(),
          onChanged: (v) {setState(() => ddBtnValues[3] = v); sentences.filter.s_form__icontains = v != formOptions.first ? v : null;},
        ),
        SizedBox(width: 10,),
        IconButton(
          splashRadius: 1.0,
          icon: Icon(Icons.search),
          onPressed: () async {
            await sentences.retrieve(queryParameters:{'page_size': 10, 'page_index':1}, update: true);
            setState((){});
          },
        ),
        SizedBox(width: 10,),
        InkWell(
          child: Text('添加句子', style: TextStyle(color: Theme.of(context).primaryColor,),),
          onTap: () async {
            SentenceSerializer sentence = SentenceSerializer();
            var s = await Navigator.pushNamed(context, '/edit_sentence', arguments: {'title':'添加句子','sentence':sentence});
            setState(() => sentences.results.add(s));
            sentence.save();
          },
        ),
      ],
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
