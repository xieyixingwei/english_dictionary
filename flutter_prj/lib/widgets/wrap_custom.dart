import 'package:flutter/material.dart';
import 'package:flutter_prj/widgets/Tag.dart';
import 'package:flutter_prj/widgets/container_outline.dart';


class WrapOutlineTag extends StatefulWidget {
  final List<String> _data;
  final String _labelText;
  final Widget _suffix;

  WrapOutlineTag({Key key, List<String> data, String labelText, Widget child, Widget suffix})
    : _data = data,
      _labelText = labelText,
      _suffix = suffix,
      super(key: key);

  @override
  _WrapOutlineTagState createState() => _WrapOutlineTagState();
}

class _WrapOutlineTagState extends State<WrapOutlineTag> {

  @override
  Widget build(BuildContext context) =>
    WrapOutline(
      labelText: widget._labelText,
      children: (widget._data.map<Widget>((e) =>
            Tag(
              label:Text(e, style: TextStyle(color: Colors.black87)),
              onDeleted: () => setState(() => widget._data.remove(e)),
              )
            ).toList()
        ),
      suffix: widget._suffix,
    );
}


class WrapOutline extends StatelessWidget {
  final String _labelText;
  final List<Widget> _children;
  final Widget _suffix;

  WrapOutline({Key key, String labelText, List<Widget> children, Widget suffix})
    : _labelText = labelText,
      _children = children,
      _suffix = suffix,
      super(key: key);

  @override
  Widget build(BuildContext context) =>
    ContainerOutline(
      decoration: InputDecoration(
        labelText: _labelText,
        border: OutlineInputBorder(),
        suffix: _suffix
      ),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: _children,
      ),
    );
}
