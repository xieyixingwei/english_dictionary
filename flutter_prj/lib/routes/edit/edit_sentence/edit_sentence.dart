import 'package:flutter/material.dart';
import 'package:flutter_prj/routes/edit/edit_grammars.dart';
import 'package:flutter_prj/routes/edit/edit_sentence/SentencePatternEdit.dart';
import 'package:flutter_prj/serializers/index.dart';


class EditSentence extends StatefulWidget {
  final String _title;
  final SentenceSerializer _sentence;

  EditSentence({Key key, String title, SentenceSerializer sentence})
    : _title = title,
      _sentence = sentence,
      super(key:key);

  @override
  _EditSentenceState createState() => _EditSentenceState();
}

class _EditSentenceState extends State<EditSentence> {

  _buildGrammer(BuildContext context) {
    List<Widget> children = widget._sentence.sentence_grammar.map<Widget>(
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
              onTap: () {e.delete(); setState(() => widget._sentence.sentence_grammar.remove(e));},
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
                var grammar = await Navigator.pushNamed(context, '/edit_grammar', arguments:GrammarSerializer());
                setState(() => widget._sentence.sentence_grammar.add(grammar));
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
              title: Text(widget._title),
              automaticallyImplyLeading: false, // 取消返回按钮
            ),
            body: Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SentencePatternEdit(sentence: widget._sentence, ),
                  _buildGrammer(context),
                  Row(
                    children: [
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          child: Text('确定'),
                          onPressed: () => Navigator.pop(context, widget._sentence),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          child: Text('取消'),
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
