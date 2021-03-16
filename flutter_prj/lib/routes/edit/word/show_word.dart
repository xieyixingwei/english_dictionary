import 'package:flutter/material.dart';
import 'package:flutter_prj/routes/edit/word/word_details.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/edit_delete.dart';


class ShowWord extends StatefulWidget {
  final WordSerializer _word;
  final Function _delete;

  ShowWord({Key key, WordSerializer word, Function delete})
    : _word = word,
      _delete = delete,
      super(key:key);

  @override
  _ShowWordState createState() => _ShowWordState();
}

class _ShowWordState extends State<ShowWord> {

  @override
  Widget build(BuildContext context) =>
  ListTile(
    title: Wrap(
      spacing: 10.0,
      children:[
        Text(widget._word.name),
        WordDetails(word: widget._word),
        //_buildOthers(),
      ],
    ),
    trailing: EditDelete(
      edit: () async {
        var word = (await Navigator.pushNamed(context, '/edit_word', arguments: {'title':'编辑单词','word':WordSerializer().from(widget._word)})) as WordSerializer;
        if(word != null) await widget._word.from(word).save();
        setState(() {});
      },
      delete: widget._delete,
    ),
  );
}
