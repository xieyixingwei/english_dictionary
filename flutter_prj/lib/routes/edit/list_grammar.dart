import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prj/routes/edit/edit_grammar.dart';
import 'package:flutter_prj/serializers/index.dart';


class ListGrammer extends StatefulWidget {

  @override
  _ListGrammerState createState() => _ListGrammerState();
}

class _ListGrammerState extends State<ListGrammer> {

  List<GrammarSerializer> grammars;

  @override
  void initState() { 
    super.initState();
    _init();
  }

  _init() async {
    List<GrammarSerializer> res = await GrammarSerializer.list();
    setState(() {
      grammars = res;
    });
  }

  Widget _buildListGrammars(BuildContext context) {
    if(grammars == null) return Text('hello');

    List<Widget> children = grammars.map<ListTile>((e) => 
      ListTile(
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
              onTap: () {e.delete(); setState(() => grammars.remove(e));},
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
              child: Text('添加语法'),
              onPressed: () {
                Navigator.pushNamed(context, '/edit_grammar', arguments:GrammarSerializer());
              },
            ),
          ),
        ],
      ),
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
                appBar: AppBar(
                  title: Text('编辑语法'),
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
                        _buildListGrammars(context),
                      ],
                    ),
                  ),
                );
  }
}
