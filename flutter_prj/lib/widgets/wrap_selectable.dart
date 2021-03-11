import 'package:flutter/material.dart';
import 'package:flutter_prj/widgets/SelectDialog.dart';
import 'package:flutter_prj/widgets/Tag.dart';


class WrapSelectable extends StatefulWidget {
  final List<String> _data;
  final List<String> _options;
  final Widget _lable;
  final Widget _action;
  final Widget _trailing;

  WrapSelectable({Key key, List<String> data, List<String> options, Widget lable, Widget action, Widget trailing})
    : _data = data,
      _options = options,
      _lable = lable,
      _action = action,
      _trailing = trailing,
      super(key: key);

  @override
  _WrapSelectableState createState() => _WrapSelectableState();
}

class _WrapSelectableState extends State<WrapSelectable> {

  @override
  Widget build(BuildContext context) {
    return Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: (<Widget>[widget._lable]
              + widget._data.map<Widget>((e) =>
                Tag(
                  label:Text(e, style: TextStyle(color: Colors.amberAccent)),
                  onDeleted: () => setState(() => widget._data.remove(e)),
                  )
                ).toList()
              + [InkWell(
                child: widget._action,
                onTap: () => popSelectDialog(
                  context: context,
                  title: widget._lable,
                  options: widget._options,
                  close: (v) => setState(() => widget._data.add(v)),
                ),
              )]
              + <Widget>[widget._trailing]).where((e) => e != null).toList(),
            );
  }
}

/*
class WrapCustom<T> extends StatefulWidget {
  final List<T> _data;
  final Widget _lable;
  final Widget _action;
  final Widget _trailing;

  WrapCustom({Key key, List<T> data, Widget lable, Widget action, Widget trailing})
    : _data = data,
      _lable = lable,
      _action = action,
      _trailing = trailing,
      super(key: key);

  @override
  _WrapCustomState createState() => _WrapCustomState();
}


class _WrapCustomState extends State<WrapCustom> {
  @override
  Widget build(BuildContext context) =>
    Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: (<Widget>[widget._lable] +
        widget._data.map<Widget>((e) =>
          Tag(
            label: Text('$e', style: TextStyle(color: Colors.amberAccent)),
            onDeleted: () => 
            onPressed: () async {
              var grammar = (await Navigator.pushNamed(context, '/edit_grammar', arguments: {'title':'编辑句子语法', 'grammar': GrammarSerializer().from(e)})) as GrammarSerializer;
              if(grammar != null) {
                e.from(grammar);
              }
              setState((){});
            },
          )).toList() + 
          [TextButton(
            child: Text('添加',style: TextStyle(color: Colors.blueAccent)),
            onPressed: () async {
              var grammar = (await Navigator.pushNamed(context, '/edit_grammar', arguments: {'title':'给句子添加语法'})) as GrammarSerializer;
              if(grammar != null) {
                setState(() => widget._sentence.grammarSet.add(grammar));
              }
            },
          )]).where((e) => e != null).toList(),
    );
*/