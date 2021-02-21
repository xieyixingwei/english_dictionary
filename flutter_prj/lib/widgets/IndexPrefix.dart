import 'package:flutter/material.dart';


class IndexPrefix extends StatelessWidget {
  final int index;
  final int indent;

  IndexPrefix(this.index, {Key key, int indent=1})
    : this.indent = indent,
      super(key:key);

  String _type() {
    String indexStr = index.toString();
    switch (indent) {
      case 1:
        return indexStr + ".";
      case 2:
        return "[" + indexStr + ".]";
      case 3:
        return "(" + indexStr + ".)";
      default: return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
            _type(),
            style:TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          );
  }
}
