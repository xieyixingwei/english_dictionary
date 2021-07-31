import 'package:flutter/material.dart';
import 'package:flutter_prj/widgets/Tag.dart';
import 'package:flutter_prj/widgets/container_outline.dart';


class WrapOutlineTag extends StatefulWidget {

  WrapOutlineTag({Key key, this.data, this.labelText, this.suffix}) : super(key: key);

  final List<String> data;
  final String labelText;
  final Widget suffix;

  @override
  _WrapOutlineTagState createState() => _WrapOutlineTagState();
}

class _WrapOutlineTagState extends State<WrapOutlineTag> {

  @override
  Widget build(BuildContext context) =>
    WrapOutline(
      labelText: widget.labelText,
      children: widget.data.map<Widget>((e) =>
        Tag(
          label:Text(e, style: TextStyle(fontSize: 14, color: Colors.black87)),
          onDeleted: () => setState(() => widget.data.remove(e)),
        )
      ).toList(),
      suffix: widget.suffix,
    );
}


class WrapOutline extends StatelessWidget {

  WrapOutline({Key key, this.labelText, this.children, this.suffix}) : super(key: key);

  final String labelText;
  final List<Widget> children;
  final Widget suffix;

  @override
  Widget build(BuildContext context) =>
    ContainerOutline(
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
        suffix: suffix
      ),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: children,
      ),
    );
}

class ListOutline extends StatelessWidget {

  ListOutline({Key key, this.labelText, this.children, this.suffix}) : super(key: key);

  final String labelText;
  final List<Widget> children;
  final Widget suffix;

  @override
  Widget build(BuildContext context) =>
    ContainerOutline(
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
        suffix: suffix
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
}
