import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prj/routes/edit/edit_grammar.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/SentencePatternEdit.dart';


class EditSentence extends StatefulWidget {
  final SentenceSerializer _sentence;

  EditSentence({Key key, SentenceSerializer sentence})
    : _sentence = sentence,
      super(key:key);

  @override
  _EditSentenceState createState() => _EditSentenceState();
}

class _EditSentenceState extends State<EditSentence> {

  _buildGrammer(BuildContext context) {
    List<Widget> children = widget._sentence.sentence_grammar.map<Widget>(
      (e) => ListTile(
        title: Text(e.g_content),
        subtitle: GrammarDetails(e, false),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              child: Text('编辑', style: TextStyle(color: Theme.of(context).primaryColor),),
              onTap: () {Navigator.pushNamed(context, '/edit_grammar', arguments:e);},
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
                          child: Text("保存"),
                          onPressed: () => widget._sentence.save(),
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
