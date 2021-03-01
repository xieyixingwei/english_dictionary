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
  static final List<String> filterTypeOptions = ["All", "句子", "短语"];
  num filterType;
  String filterTag;
  String filterTense;
  String filterForm;

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
        Expanded(
          child: TextField(

          ),
        ),
        DropdownButton(
          value: "请选择Type",
          items: filterTypeOptions.map((e)=>DropdownMenuItem(child: Text(e), value:e,)),
          onChanged: (v) {num index = filterTypeOptions.indexOf(v); filterType = index == 0 ? null : index - 1;},
        ),
        DropdownButton(
          value: "请选择Tags",
          items: Global.sentenceTagOptions.map((e)=>DropdownMenuItem(child: Text(e), value:e,)),
          onChanged: (v) {filterTag = v;},
        ),
        DropdownButton(
          value: "请选择Tense",
          items: Global.tenseOptions.map((e)=>DropdownMenuItem(child: Text(e), value:e,)),
          onChanged: (v) {filterTense = v;},
        ),
        DropdownButton(
          value: "请选择句型",
          items: Global.sentenceTagOptions.map((e)=>DropdownMenuItem(child: Text(e), value:e,)),
          onChanged: (v) {filterForm = v;},
        ),
        IconButton(
          splashRadius: 1.0,
          icon: Icon(Icons.search),
          onPressed: () {
            ;//ListSentencesSerializer
          },
        ),
        RaisedButton(
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.all(15.0),
          child: Text("添加句子"),
          onPressed: () {
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
