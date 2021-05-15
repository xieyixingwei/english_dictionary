import 'package:flutter/material.dart';
import 'package:flutter_prj/serializers/grammar.dart';


Widget grammarItem({BuildContext context, GrammarSerializer grammar, Widget trailing}) {
  Widget title = Text.rich(
    TextSpan(
        children: [
          TextSpan(text: '${grammar.title}', style: TextStyle(fontSize: 14, color: Colors.black87)),
          grammar.type.isNotEmpty ? TextSpan(text: '    ${grammar.type.join('/')}', style: TextStyle(fontSize: 10, color: Colors.black45)) : null,
          TextSpan(text: '    ${grammar.tag.join('/')}', style: TextStyle(fontSize: 10, color: Colors.black45)),
        ].where((e) => e != null).toList()
      )
  );

  return ListTile(
    dense: true,
    horizontalTitleGap: 0,
    minVerticalPadding: 0,
    minLeadingWidth: 30,
    contentPadding: EdgeInsets.only(left: 14, right: 14, top: 0, bottom: 0),
    leading: Text('${grammar.id}', style: TextStyle(fontSize: 14, color: Colors.black54),),
    title: title,
    trailing: trailing,
  );
}
