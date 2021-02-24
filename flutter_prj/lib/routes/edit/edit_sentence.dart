import 'package:flutter/material.dart';
import 'package:flutter_prj/common/http.dart';
import 'package:flutter_prj/models/misc_model.dart';
import 'package:flutter_prj/models/sentence_model.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/SentencePatternEdit.dart';
import 'package:provider/provider.dart';


class EditSentence extends StatefulWidget {
  @override
  _EditSentenceState createState() => _EditSentenceState();
}

class _EditSentenceState extends State<EditSentence> {

  Future<List<SentenceSerializer>> _init() async {
    return await Http().listSentences(page_size: 10, page_index:1);
  }

  _children(List<SentenceSerializer> sentences) {
    if(sentences == null) return [Text("hello")];
    return sentences.map((e) => 
      SentencePatternEdit(
        data: e,
      )
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
            future: _init(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) =>
              Scaffold(
                appBar: AppBar(
                  title: Text("编辑例句"),
                ),
                body: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //SentencePatternEdit(
                        //  data: sentence.sentence,
                        //),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: Divider(
                            height: 1.0,
                            indent: 1.0,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _children(snapshot.data),
                        ),
                      ],
                    ),
                  ), 
                ),
              ),
        );
  }
}

/*
Padding(
                    padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: RaisedButton(
                            color: Theme.of(context).primaryColor,
                            padding: EdgeInsets.all(15.0),
                            child: Text("保存"),
                            onPressed: () {
                              Http().createSentenceOption(sentence.sentence);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  */
