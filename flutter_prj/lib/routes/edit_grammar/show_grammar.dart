import 'package:flutter/material.dart';
import 'package:flutter_prj/routes/edit_grammar/grammar_details.dart';
import 'package:flutter_prj/serializers/index.dart';


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
      //leading: Text('相关语法'),
      title: Text(widget._grammar.g_content),
      subtitle: GrammarDetails(widget._grammar, false),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            child: Text('编辑', style: TextStyle(color: Theme.of(context).primaryColor),),
            onTap: () async {
              GrammarSerializer grammar = GrammarSerializer().fromJson(widget._grammar.toJson());
              var g = (await Navigator.pushNamed(context, '/edit_grammar', arguments:{'title':'编辑语法','grammar': grammar})) as GrammarSerializer;
              if(g != null){
                widget._grammar.fromJson(g.toJson());
                widget._grammar.save();
              }
              setState(() {});
            },
          ),
          SizedBox(width: 10,),
          widget._delete != null ?
          InkWell(
            child: Text('删除', style: TextStyle(color: Colors.pink,)),
            onTap: () {widget._grammar.delete(); widget._delete();},
          ) : SizedBox(width: 0,),
        ],
      )
    );
}
