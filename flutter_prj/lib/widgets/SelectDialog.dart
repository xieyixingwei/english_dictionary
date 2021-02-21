import 'package:flutter/material.dart';


void popSelectDialog({BuildContext context, String title, List<String> options, Function(String) close}) async {
    var optionWidgets = options.map(
      (e) => SimpleDialogOption(
              child: Text(e),
              onPressed: () {
                Navigator.pop(context, e); // 关闭Dialog并传值出去
              }
            )
          );

    String res = await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(title),
          children: optionWidgets.toList(),
        );
      },
    );

    if(close != null) close(res);
  }


class SelectDialog extends StatelessWidget {
  final List<String> _options;
  final String _title;
  final Widget _icon;
  final String _tooltip;
  final Function(String) _close;

  SelectDialog({Key key, List<String> options, String title, Widget icon, String tooltip="", Function(String) close})
    : _options = options,
      _title = title,
      _icon = icon,
      _tooltip = tooltip,
      _close = close,
      super(key: key);

  @override
  Widget build(BuildContext context) {
    var onPressed = (){if(_options != null) popSelectDialog(context:context, title:_title??_tooltip, options:_options, close:_close);};

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
