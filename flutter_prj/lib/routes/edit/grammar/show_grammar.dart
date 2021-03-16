import 'package:flutter/material.dart';
import 'package:flutter_prj/routes/edit/grammar/grammar_details.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/edit_delete.dart';


class ShowGrammar extends StatefulWidget {
  final GrammarSerializer _grammar;
  final Function _delete;

  ShowGrammar({Key key, GrammarSerializer grammar, Function delete})
    : _grammar = grammar,
      _delete = delete,
      super(key:key);

  @override
  _ShowGrammarState createState() => _ShowGrammarState();
}

class _ShowGrammarState extends State<ShowGrammar> {

  @override
  Widget build(BuildContext context) =>
    ListTile(
      leading: Text('id[${widget._grammar.id}]', style: TextStyle(fontSize: 12, color: Colors.deepOrange),),
      title: Text(widget._grammar.content),
      subtitle: GrammarDetails(widget._grammar, false),
      trailing: EditDelete(
        edit: () async {
          var grammar = (await Navigator.pushNamed(context, '/edit_grammar', arguments:{'title':'编辑语法','grammar': GrammarSerializer().from(widget._grammar)})) as GrammarSerializer;
            if(grammar != null) await widget._grammar.from(grammar).save();
            setState(() {});
        },
        delete: widget._delete,
      ),
    );
}
