import 'package:flutter/material.dart';
import 'package:flutter_prj/serializers/dialog.dart';


Widget dialogItem({BuildContext context, DialogSerializer dialog, Widget trailing}) {
  Widget title = Text.rich(
    TextSpan(
        children: [
          TextSpan(text: '${dialog.title}', style: TextStyle(fontSize: 14, color: Colors.black87)),
          TextSpan(text: '    ${dialog.tag.join('/')}', style: TextStyle(fontSize: 10, color: Colors.black45)),
        ]
      )
  );

  return ListTile(
    dense: true,
    horizontalTitleGap: 0,
    minVerticalPadding: 0,
    minLeadingWidth: 30,
    contentPadding: EdgeInsets.only(left: 14, right: 14, top: 0, bottom: 0),
    title: title,
    trailing: trailing,
    onTap: () => Navigator.pushNamed(context, '/practice_dialog', arguments: {'title': '对话练习', 'dialog': dialog}),
  );
}
