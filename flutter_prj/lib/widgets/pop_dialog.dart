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

Future<String> popSelectDialog({
  BuildContext context,
  Widget title,
  List<String> options,
  Function(String) close
  }) async {
  String res = await showDialog(
    context: context,
    builder: (context) =>
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) =>
          SimpleDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                title,
                IconButton(
                  icon: Icon(Icons.clear, color: Colors.black54, size: 24,),
                  tooltip: '取消',
                  splashRadius: 1.0,
                  onPressed: () => Navigator.pop(context),
                ),
              ]
            ),
            children: options.map<Widget>((e) =>
              SimpleDialogOption(
                child: Text(e),
                onPressed: () => Navigator.pop(context, e), // 关闭Dialog并传值出去
              )
            ).toList(),
          ),
        )
      );

  if(close != null && res != null) close(res);
  return res;
}


Future<String> popSelectWidgetDialog({
  BuildContext context,
  Widget title,
  List<Widget> options,
  List<Widget> actions
  }) async {
  var res = await showDialog(
    context: context,
    builder: (context) =>
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) =>
          SimpleDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                title,
                IconButton(
                  icon: Icon(Icons.clear, color: Colors.black54, size: 24,),
                  tooltip: '取消',
                  splashRadius: 1.0,
                  onPressed: () => Navigator.pop(context),
                ),
              ]
            ),
            children: options,
          ),
        ),
    );

  return res;
}
