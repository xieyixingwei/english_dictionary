import 'package:flutter/material.dart';


class OnOffWidget extends StatelessWidget {
  final String _label;
  final Widget _child;
  final IconData _icon;
  final Function(bool) _click;
  final bool _hide;

  OnOffWidget({String label="", Widget child, bool hide, Function(bool) click})
    : _label = label,
      _child = child,
      _click = click,
      _hide = hide,
      _icon = hide ? Icons.keyboard_arrow_right : Icons.keyboard_arrow_down;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            InkWell(
              child: Icon(_icon, color: Colors.grey),
              onTap: (){
                  if(_click != null) _click(_hide);
                  },
            ),
            Text(_label+" "),
            Expanded(
              child: Divider(height: 2.0, indent: 0.0, endIndent: 0.0, thickness: 1, color: Colors.grey,),
            ),
          ],
        ),
        Offstage(
          offstage: _hide,
          child: Padding(
            padding: EdgeInsets.fromLTRB(40,0,0,0),
            child: _child,
          ),
        ),
      ],
    );
  }
}

/*
class OnOffWidget extends StatefulWidget {
  final String _label;
  final Widget _child;
  final bool _hide;
  final IconData _showIcon = Icons.keyboard_arrow_down;
  final IconData _hideIcon = Icons.keyboard_arrow_right;

  OnOffWidget({Key key, String label="", Widget child, bool hide=true})
    : _label = label,
      _child = child,
      _hide = hide,
      super(key:key);

  @override
  _OnOffWidgetState createState() => _OnOffWidgetState();
}

class _OnOffWidgetState extends State<OnOffWidget> {
  IconData _icon;
  bool _hide;

  _OnOffWidgetState() {
     _hide = widget._hide;
    _icon = widget._hide ? widget._hideIcon : widget._showIcon;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            InkWell(
              child: Icon(_icon, color: Colors.grey),
              onTap: (){
                setState(() {
                  _icon = _hide ? widget._showIcon : widget._hideIcon;
                  _hide = !_hide;
                  });
              },
            ),
            Text(widget._label+" "),
            Expanded(
              child: Divider(height: 2.0, indent: 0.0, endIndent: 0.0, thickness: 1, color: Colors.grey,),
            ),
          ],
        ),
        Offstage(
          offstage: _hide,
          child: Padding(
            padding: EdgeInsets.fromLTRB(40,0,0,0),
            child: widget._child,
          ),
        ),
      ],
    );
  }
}
*/
