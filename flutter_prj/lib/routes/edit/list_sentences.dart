import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/sentence_details.dart';


class ListSentence extends StatefulWidget {
  @override
  _ListSentenceState createState() => _ListSentenceState();
}

class _ListSentenceState extends State<ListSentence> {
  ListSentencesSerializer _listSentences;
  static final List<String> filterTypeOptions = ["所有的类型", "句子", "短语"];
  List<String> ddBtnValues = [filterTypeOptions.first, "请选择Tags", "请选择Tense", "请选择句型"];

  @override
  void initState() { 
    super.initState();
    _init();
  }

  _init() async {
    ListSentencesSerializer res = await ListSentencesSerializer().retrieve(queryParameters:{"page_size": 10, "page_index":1});
    setState(() {
      _listSentences = res;
    });
  }

  Widget _buildListSentences(BuildContext context) {
    if(_listSentences == null) return Text("hello");

    List<Widget> children = _listSentences.results.map<ListTile>((e) => 
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
              onTap: () {e.delete(); setState(() => _listSentences.results.remove(e));},
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
        DropdownButton(
          //hint: Text(filterTypeOptions.first),
          value: ddBtnValues.first,
          items: filterTypeOptions.map<DropdownMenuItem>((e)=>DropdownMenuItem(child: Text(e), value: e,)).toList(),
          onChanged: (v) {
            num index = filterTypeOptions.indexOf(v);
            _listSentences.filter.s_type = index == 0 ? null : index - 1;
            setState(() => ddBtnValues.first = v);
          },
        ),
        SizedBox(width: 10,),
        DropdownButton(
          value: ddBtnValues[1],
          items: (["请选择Tags"] + Global.sentenceTagOptions).map<DropdownMenuItem<String>>((e)=>DropdownMenuItem<String>(child: Text(e), value: e,)).toList(),
          onChanged: (v) {print(v); setState(() => ddBtnValues[1] = v); _listSentences.filter.s_tags__icontains = v != "请选择Tags" ? v : null;},
        ),
        SizedBox(width: 10,),
        DropdownButton(
          value: ddBtnValues[2],
          items: (["请选择Tense"] + Global.tenseOptions).map((e)=>DropdownMenuItem(child: Text(e), value: e,)).toList(),
          onChanged: (v) {setState(() => ddBtnValues[2] = v); _listSentences.filter.s_tense__icontains = v != "请选择Tense" ? v : null;},
        ),
        SizedBox(width: 10,),
        DropdownButton(
          value: ddBtnValues[3],
          items: (["请选择句型"] + Global.sentenceFormOptions).map((e)=>DropdownMenuItem(child: Text(e), value: e,)).toList(),
          onChanged: (v) {setState(() => ddBtnValues[3] = v); _listSentences.filter.s_form__icontains = v != "请选择句型" ? v : null;},
        ),
        SizedBox(width: 10,),
        IconButton(
          splashRadius: 1.0,
          icon: Icon(Icons.search),
          onPressed: () async {
            var tmp = await _listSentences.retrieve(queryParameters:{"page_size": 10, "page_index":1});
            setState(() => _listSentences = tmp);
          },
        ),
        SizedBox(width: 10,),
        InkWell(
          //color: Theme.of(context).primaryColor,
          child: Text("添加句子"),
          onTap: () {
            Navigator.pushNamed(context, "/edit_sentence", arguments:SentenceSerializer());
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
