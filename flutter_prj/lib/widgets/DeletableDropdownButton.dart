import 'package:flutter/material.dart';

class DeletableDropdownButton extends StatefulWidget {
  final List<String> _options;
  final String _value;
  final Function() _delete;
  final Function(String) _close;

    DeletableDropdownButton({
      Key key,
      List<String> options,
      String value,
      Function() delete,
      Function(String) close})
    : _options = options,
      _value = value,
      _delete = delete,
      _close = close,
      super(key:key);

  @override
  _DeletableDropdownButtonState createState() => _DeletableDropdownButtonState();
}

class _DeletableDropdownButtonState extends State<DeletableDropdownButton> {
  bool status = true;

  @override
  Widget build(BuildContext context) {
    //print("----- PatternLineEdit build ${_hintText[0]}");
    var items = widget._options.map((value)=>DropdownMenuItem(child: Text(value), value: value,));

    return MouseRegion(
      onEnter: (e) => setState((){ status = !status;}),
      onExit: (e)=> setState((){ status = !status;}),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton(
            hint: Text(widget._value),
            items: items.toList(),
            onChanged: (value) {if(widget._close != null) widget._close(value);},
          ),
          Offstage(
            offstage: status,
            child: InkWell(
              child: Icon(Icons.clear, color: Color.fromRGBO(158,158,158,1),),
              onTap: (){if(widget._delete != null) widget._delete();},
            ),
          ),
        ],
      ),
  );
  }
}
