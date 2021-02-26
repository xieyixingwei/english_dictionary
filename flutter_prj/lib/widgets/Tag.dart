import 'package:flutter/material.dart';


class Tag extends StatefulWidget {
  final Widget _label;
  final Function _onDeleted;

  Tag({Key key, Widget label, Function onDeleted,})
    : _label = label,
      _onDeleted = onDeleted,
      super(key:key);

  @override
  _TagState createState() => _TagState();
}

class _TagState extends State<Tag> {

  List<Widget> _children() {
    List<Widget> children = [widget._label];
    widget._onDeleted != null ? children.add(
      InkWell(
        child: Icon(Icons.clear, size: 12.0,),
        onTap: () => widget._onDeleted(),
      )
    ) : null;
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        children: _children(),
  );
  }
}
