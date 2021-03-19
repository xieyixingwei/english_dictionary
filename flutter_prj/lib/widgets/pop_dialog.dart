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

void popSelectDialog({BuildContext context, Widget title, List<String> options, Function(String) close}) async {
  var optionWidgets = options.map((e) =>
    SimpleDialogOption(
      child: Text(e),
      onPressed: () => Navigator.pop(context, e), // 关闭Dialog并传值出去
    )
  ).toList();

  String res = await showDialog(
    context: context,
    builder: (context) {
      return SimpleDialog(
        title: title,
        children: optionWidgets,
      );
    },
  );

  if(close != null && res != null) close(res);
  }
