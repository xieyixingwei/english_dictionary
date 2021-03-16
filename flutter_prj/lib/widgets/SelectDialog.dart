import 'package:flutter/material.dart';


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

