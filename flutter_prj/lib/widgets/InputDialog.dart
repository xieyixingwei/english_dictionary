import 'package:flutter/material.dart';


class InputDialog extends StatelessWidget {
  final String _title;
  final Widget _icon;
  final String _tooltip;
  final Function(String) _close;
  final TextEditingController _textFeildCtrl = TextEditingController();

  InputDialog({Key key, String title, Widget icon, String tooltip="", Function(String) close})
    : _title = title,
      _icon = icon,
      _tooltip = tooltip,
      _close = close,
      super(key: key);

  void _simpleDialog(BuildContext context) async {

    await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(_title != null ? _title : _tooltip),
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10,0,10,10),
              child: TextField(
                controller: _textFeildCtrl,
              ),
            ),
          ],
        );
      },
    );

    if(_close != null)
      _close(_textFeildCtrl.text);
  }

  @override
  Widget build(BuildContext context) {
    var onPressed = () => _simpleDialog(context);

    return _title != null ? 
          RaisedButton(
            child: Text(_title),
            onPressed: onPressed,
          ) : (
            _icon != null ?
              IconButton(
                icon: _icon,
                tooltip: this._tooltip,
                onPressed: onPressed,
            ) : Text("Error")
          );
  }
}


void popInputDialog({BuildContext context, Widget title, Function(String value) close}) async {
  final TextEditingController textFeildCtrl = TextEditingController();
  await showDialog(
    context: context,
    builder: (context) =>
      SimpleDialog(
        title: title,
        contentPadding: EdgeInsets.fromLTRB(10,10,10,10),
        children: [
          TextField(
            maxLines: null,
            controller: textFeildCtrl,
          ),
        ],
      ),
  );

  String value = textFeildCtrl.text.trim();
  close != null && value.length > 0 ? close(textFeildCtrl.text.trim()) : null;
}
