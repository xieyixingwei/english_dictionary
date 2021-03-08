import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/routes/edit/edit_grammars.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/SentencePatternEdit.dart';
import 'package:flutter_prj/widgets/Tag.dart';


class EditSentences extends StatefulWidget {
  @override
  _EditSentencesState createState() => _EditSentencesState();
}

class _EditSentencesState extends State<EditSentences> {
  SentencesPaginationSerializer sentences = SentencesPaginationSerializer();
  static final List<String> typeOptions = ["所有的类型", "句子", "短语"];
  static final List<String> tagOptions = ["请选择Tags"] + Global.sentenceTagOptions;
  static final List<String> tenseOptions = ["请选择Tense"] + Global.tenseOptions;
  static final List<String> formOptions = ["请选择句型"] + Global.sentenceFormOptions;
  List<String> ddBtnValues = [typeOptions.first, tagOptions.first, tenseOptions.first, formOptions.first];

  @override
  void initState() {
    super.initState();

    retrieve();
  }

  void retrieve() async {
    var tmp = await sentences.retrieve(queryParameters:{"page_size": 10, "page_index":1}, update: true);
    setState(() {
      sentences = tmp;
      /*
      ddBtnValues[0] = typeOptions[sentences.filter.s_type == null ? 0 : sentences.filter.s_type + 1];
      ddBtnValues[1] = sentences.filter.s_tags__icontains == null ? "请选择Tags" : sentences.filter.s_tags__icontains;
      ddBtnValues[2] = sentences.filter.s_tense__icontains == null ? "请选择Tense" : sentences.filter.s_tense__icontains;
      ddBtnValues[3] = sentences.filter.s_form__icontains == null ? "请选择句型" : sentences.filter.s_form__icontains;
      */
    });
  }

  Widget _buildListSentences(BuildContext context) {
    List<Widget> children = sentences.results.map<ListTile>((e) => 
      ListTile(
        title: Text(e.s_en),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(e.s_ch),
            SentenceDetails(sentence: e),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              child: Text("编辑", style: TextStyle(color: Theme.of(context).primaryColor),),
              onTap: () async {
                var sentence = await Navigator.pushNamed(context, "/edit_sentence", arguments:e);
                setState(() => e = sentence);
              }
            ),
            SizedBox(width: 10,),
            InkWell(
              child: Text("删除", style: TextStyle(color: Colors.pink,)),
              onTap: () {e.delete(); setState(() => sentences.results.remove(e));},
            ),
          ],
        )
      ),
    ).toList();

    return Expanded(
      child: ListView(
        children: children,
      )
    );
  }

  Widget _buildFilter(BuildContext context) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
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
            var tmp = await sentences.retrieve(queryParameters:{"page_size": 10, "page_index":1}, update: true);
            setState(() => sentences = tmp);
          },
        ),
        SizedBox(width: 10,),
        InkWell(
          child: Text("添加句子", style: TextStyle(color: Theme.of(context).primaryColor,),),
          onTap: () async {
            var sentence = await Navigator.pushNamed(context, "/edit_sentence", arguments: SentenceSerializer());
            setState(() => sentences.results.add(sentence));
          },
        ),
      ],
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
                appBar: AppBar(
                  title: Text("编辑例句"),
                ),
                body: Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFilter(context),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: Divider(
                            height: 1.0,
                            indent: 1.0,
                          ),
                        ),
                        _buildListSentences(context),
                      ],
                    ),
                  ),
                );
  }
}


class EditSentence extends StatefulWidget {
  final SentenceSerializer sentence;

  EditSentence({Key key, SentenceSerializer sentence})
    : sentence = sentence,
      super(key:key);

  @override
  _EditSentenceState createState() => _EditSentenceState();
}

class _EditSentenceState extends State<EditSentence> {

  _buildGrammer(BuildContext context) {
    List<Widget> children = widget.sentence.sentence_grammar.map<Widget>(
      (e) => ListTile(
        leading: Text('相关语法'),
        title: Text(e.g_content),
        subtitle: GrammarDetails(e, false),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              child: Text('编辑', style: TextStyle(color: Theme.of(context).primaryColor),),
              onTap: () async {
                var grammar = await Navigator.pushNamed(context, '/edit_grammar', arguments:e);
                setState(() => e = grammar);
              },
            ),
            SizedBox(width: 10,),
            InkWell(
              child: Text('删除', style: TextStyle(color: Colors.pink,)),
              onTap: () {e.delete(); setState(() => widget.sentence.sentence_grammar.remove(e));},
            ),
          ],
        )
      ),
    ).toList();

    children.add(
      Row(
        children: [
          Expanded(
            child: RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text('添加相关语法'),
              onPressed: () async {
                var grammar = await Navigator.pushNamed(context, "/edit_grammar", arguments:GrammarSerializer());
                setState(() => widget.sentence.sentence_grammar.add(grammar));
              },
            ),
          )
        ]
      )
    );
    return Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              children: children,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              title: Text("编辑例句"),
              automaticallyImplyLeading: false, // 取消返回按钮
            ),
            body: Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SentencePatternEdit(sentence: widget.sentence, ),
                  _buildGrammer(context),
                  Row(
                    children: [
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          child: Text("确定"),
                          onPressed: () => Navigator.pop(context, widget.sentence),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          child: Text("取消"),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ]
                  ),
                ],
              ),
            ),
          );
  }
}


class SentenceDetails extends StatefulWidget {
  final SentenceSerializer _sentence;
  final bool _editable;
  SentenceDetails({Key key, SentenceSerializer sentence, bool editable=false})
    : _sentence = sentence,
      _editable = editable,
      super(key:key);

  @override
  _SentenceDetailsState createState() => _SentenceDetailsState();
}

class _SentenceDetailsState extends State<SentenceDetails> {
  static const List<String> _types = ["句子", "短语"];

  Widget _buildType(BuildContext context) {
    final TextStyle style = TextStyle(fontSize: 12.0, color: Colors.green);
    return Text(_types[widget._sentence.s_type], style: style);
  }

  List<Widget> _buildTags(BuildContext context) {
    final TextStyle style = TextStyle(fontSize: 12.0, color: Theme.of(context).primaryColor);
    List<Widget> tags = [];
    if(widget._sentence.s_tags == null || widget._sentence.s_tags.length == 0) return tags;
    tags.add(Text("Tags:", style: style));
    tags.addAll(
      widget._sentence.s_tags.map((e) => 
        Tag(
          label: Text(e, style: style,),
          onDeleted: widget._editable ? () => setState(() => widget._sentence.s_tags.remove(e)) : null,
        )
      ).toList()
    );
    return tags;
  }

  List<Widget> _buildTense(BuildContext context) {
    final TextStyle style = TextStyle(fontSize: 12.0, color: Colors.pinkAccent);
    List<Widget> tense = [];
    if(widget._sentence.s_tense == null || widget._sentence.s_tense.length == 0) return tense;
    tense.add(Text("时态:", style: style));
    tense.addAll(
      widget._sentence.s_tense.map((e) => 
        Tag(
          label: Text(e, style: style,),
          onDeleted: widget._editable ? () => setState(() => widget._sentence.s_tense.remove(e)) : null,
        )
      ).toList()
    );
    return tense;
  }

  List<Widget> _buildForm(BuildContext context) {
    final TextStyle style = TextStyle(fontSize: 12.0, color: Colors.orange);
    List<Widget> form = [];
    if(widget._sentence.s_form == null || widget._sentence.s_form.length == 0) return form;
    form.add(Text("句型:", style: style));
    form.addAll(
      widget._sentence.s_form.map((e) => 
        Tag(
          label: Text(e, style: style,),
          onDeleted: widget._editable ? () => setState(() => widget._sentence.s_form.remove(e)) : null,
        )
      ).toList()
    );
    return form;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    children.add(_buildType(context));
    children.addAll(_buildTags(context));
    children.addAll(_buildTense(context));
    children.addAll(_buildForm(context));
    return Wrap(
            spacing: 8.0,
            runSpacing: 8.0, 
            children: children,
          );
  }
}
