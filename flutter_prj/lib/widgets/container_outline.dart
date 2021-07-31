import 'package:flutter/material.dart';

class ContainerOutline extends StatelessWidget {
  final Widget _child;
  final InputDecoration _decoration;

  const ContainerOutline({ Key key, Widget child, InputDecoration decoration})
    : _child = child,
      _decoration = decoration ?? const InputDecoration(border: OutlineInputBorder()),
      super(key: key);

  @override
  Widget build(BuildContext context) =>
    Container(
      child: InputDecorator(
        decoration: _decoration,
        child: _child,
      ),
    );
}
