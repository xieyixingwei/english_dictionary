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

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget._label,
          InkWell(
            child: Icon(Icons.clear, size: 12.0,),
            onTap: () {if(widget._onDeleted != null) widget._onDeleted();},
          ),
        ],
  );
  }
}
