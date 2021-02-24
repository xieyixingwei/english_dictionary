import 'package:flutter/material.dart';
import 'package:flutter_prj/common/http.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/sentence_details.dart';


class ListSentence extends StatefulWidget {
  @override
  _ListSentenceState createState() => _ListSentenceState();
}

class _ListSentenceState extends State<ListSentence> {
  ListSentecesSerializer _listSentences;

  @override
  void initState() { 
    super.initState();
    _init();
  }

  _init() async {
    var res = await Http().listSentences(page_size: 10, page_index:1);
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
              onTap: () {setState(() => _listSentences.results.remove(e)); Http().deleteSentence(e.s_id);},
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

  Widget _buildButton(BuildContext context) =>
    Padding(
      padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
      child: Row(
        children: [
          Expanded(
            child: RaisedButton(
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.all(15.0),
              child: Text("添加句子"),
              onPressed: () {
                Navigator.pushNamed(context, "/edit_sentence", arguments:SentenceSerializer());
              },
            ),
          ),
        ],
      ),
    );

  @override
  Widget build(BuildContext context) {
    print('--- build ListSentence');
    return Scaffold(
                appBar: AppBar(
                  title: Text("编辑例句"),
                ),
                body: Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildButton(context),
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
