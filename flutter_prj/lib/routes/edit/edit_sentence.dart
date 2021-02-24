import 'package:flutter/material.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/SentencePatternEdit.dart';


class EditSentence extends StatefulWidget {
  final SentenceSerializer _data;

  EditSentence({Key key, SentenceSerializer data})
    : _data = data,
      super(key:key);

  @override
  _EditSentenceState createState() => _EditSentenceState();
}

class _EditSentenceState extends State<EditSentence> {

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
                    SentencePatternEdit(data: widget._data, ),
                  ],
                ),
              ),
            );
  }
}

/*

                  */
