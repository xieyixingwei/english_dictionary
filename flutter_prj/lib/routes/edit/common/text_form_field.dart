import 'package:flutter/material.dart';

final _textStyle = const TextStyle(fontSize: 14,);

Widget textFiledForm({
  String text,
  String labelText,
  Widget suffixIcon,
  Function(String) onChanged,
  Function(String) validator
}) =>
  TextFormField(
    controller: TextEditingController(text: text),
    maxLines: 1,
    style: _textStyle,
    decoration: InputDecoration(
      //isDense: true,
      //contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
      labelText: labelText,
      border: OutlineInputBorder(),
      suffixIcon: suffixIcon,
    ),
    onChanged: (v) => onChanged != null ? onChanged(v.trim()) : null,
    validator: (v) => validator != null ? validator(v.trim()) : null,
  );
