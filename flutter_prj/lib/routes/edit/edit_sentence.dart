import 'package:flutter/material.dart';
import 'package:flutter_prj/common/http.dart';
import 'package:flutter_prj/states/sentence_state.dart';
import 'package:flutter_prj/widgets/SentencePatternEdit.dart';
import 'package:provider/provider.dart';
import '../../states/store.dart';


class EditSentence extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer2<SentenceState, Store>(
      builder: (BuildContext context, SentenceState sentence, Store store, Widget child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("编辑例句"),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SentencePatternEdit(
                    data: sentence.sentence,
                  ),
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
                ],
              ),
            ), 
          ),
        );
      }
    );
  }
}
