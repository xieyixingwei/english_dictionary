import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/sentence_details.dart';


class ListSentence extends StatefulWidget {
  @override
  _ListSentenceState createState() => _ListSentenceState();
}

class _ListSentenceState extends State<ListSentence> {
  ListSentencesSerializer sentences = ListSentencesSerializer();
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
    if(sentences == null) return Text("hello");

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
              onTap: () {Navigator.pushNamed(context, "/edit_sentence", arguments:e);},
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
      children: [
        Expanded(
          child: TextField(
            onChanged: (val) => sentences.filter.s_en__icontains = val.trim().length == 0 ? null : val.trim(),
            decoration: InputDecoration(
              labelText: '英文关键字',
            ),
          ),
        ),
        SizedBox(width: 10,),
        Expanded(
          child: TextField(
            onChanged: (val) => sentences.filter.s_ch__icontains = val.trim().length == 0 ? null : val.trim(),
            decoration: InputDecoration(
              labelText: '中文关键字',
            ),
          ),
        ),
        SizedBox(width: 10,),
        DropdownButton(
          //hint: Text(filterTypeOptions.first),
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
          //color: Theme.of(context).primaryColor,
          child: Text("添加句子"),
          onTap: () {
            var s = SentenceSerializer();
            Navigator.pushNamed(context, "/edit_sentence", arguments:s);
            setState(() => sentences.results.add(s));
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
