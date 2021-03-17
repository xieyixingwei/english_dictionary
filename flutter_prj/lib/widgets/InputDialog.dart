import 'package:flutter/material.dart';


class PopInputDialog extends StatefulWidget {
  final Widget _title;
  final List<Widget> _children;
  final Function(String) _close;

  PopInputDialog({Key key, Widget title, List<Widget> children, Function(String value) close})
    : _title = title,
      _children = children,
      _close = close,
      super(key:key);

  @override
  _PopInputDialogState createState() => _PopInputDialogState();
}


class _PopInputDialogState extends State<PopInputDialog> {

  void _simpleDialog(BuildContext context) async {
    final TextEditingController textFeildCtrl = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: widget._title,
          children: widget._children != null ? widget._children: [
          TextField(
            maxLines: null,
            controller: textFeildCtrl,
          ),
        ],
        );
      },
    );

    String value = textFeildCtrl.text.trim();
    if(widget._close != null && value.isNotEmpty && widget._children == null) widget._close(value);
    if(widget._close != null && widget._children != null) widget._close(null);
  }

  @override
  Widget build(BuildContext context) {
    var onPressed = () => _simpleDialog(context);

    return RaisedButton(
            child: Text('input'),
            onPressed: onPressed,
          );
  }
}

void popInputDialog({BuildContext context, Widget title, List<Widget> children, Function(String value) close}) async {
  final TextEditingController textFeildCtrl = TextEditingController();
  await showDialog(
    context: context,
    builder: (context) =>
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) =>
          SimpleDialog(
            title: title,
            contentPadding: EdgeInsets.fromLTRB(10,10,10,10),
            children: children ?? [
              TextField(
                maxLines: null,
                controller: textFeildCtrl,
              ),
            ],
          ),
      ),
  );

  String value = textFeildCtrl.text.trim();
  if(close != null && value.isNotEmpty && children == null) close(value);
  if(close != null && children != null) close(null);
}
