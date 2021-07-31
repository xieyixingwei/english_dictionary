import 'package:flutter/material.dart';
import 'package:flutter_prj/widgets/Tag.dart';
import 'package:flutter_prj/widgets/pop_dialog.dart';


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
