import 'package:flutter/material.dart';


class OnOffWidget extends StatefulWidget {

  OnOffWidget({Key key, this.label, this.child}) : super(key:key);

  final Widget label;
  final Widget child;

  @override
  _OnOffWidgetState createState() => _OnOffWidgetState();
}

class _OnOffWidgetState extends State<OnOffWidget> {
  bool _hide = false;

  @override
  Widget build(BuildContext context) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => setState(() => _hide = !_hide),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.label,
              Icon(_hide ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up, color: Colors.grey, size: 18,),
            ],
          ),
        ),
        Offstage(
          offstage: _hide,
          child: widget.child,
        ),
      ],
    );
}
