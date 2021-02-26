import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      (GrammarSerializer e) => Padding(
        padding: EdgeInsets.only(top:20),
        child: TextField(
          maxLines: null,
          controller: TextEditingController(text: e.g_content),
          decoration: InputDecoration(
            labelText: "相关语法",
            border: OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () => setState(() => widget._sentence.sentence_grammar.remove(e)),
            ),
          ),
          onChanged: (String value) => e.g_content = value,
        )
      )
    ).toList();

    children.add(
      Padding(
        padding: EdgeInsets.only(top:20),
        child: RaisedButton(
          color: Theme.of(context).primaryColor,
          child: Text('添加相关语法'),
          onPressed: () => setState(() => widget._sentence.sentence_grammar.add(GrammarSerializer())),
        ),
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
                          child: Text("保存"),
                          onPressed: () async {
                            if(widget._sentence.s_id == -1) {
                              await widget._sentence.create();
                              widget._sentence.s_id = widget._sentence.s_id;
                              widget._sentence.sentence_grammar.forEach(
                                (GrammarSerializer e) async {
                                  e.g_sentence = widget._sentence.s_id;
                                  e.g_id == -1 ? e.create() : e.update();
                                }
                              );
                            }
                            else {
                              widget._sentence.update();
                              widget._sentence.sentence_grammar.forEach(
                                (GrammarSerializer e) async {
                                  e.g_sentence = widget._sentence.s_id;
                                  e.g_id == -1 ? e.create() : e.update();
                                }
                              );
                            }
                          },
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
