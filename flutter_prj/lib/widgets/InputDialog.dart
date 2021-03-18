import 'package:flutter/material.dart';

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
