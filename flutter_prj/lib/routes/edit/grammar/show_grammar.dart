import 'package:flutter/material.dart';
import 'package:flutter_prj/serializers/grammar.dart';


Widget grammarItem({BuildContext context, GrammarSerializer grammar, Widget trailing}) {
  String subTitle = grammar.type.join('/') + '   ' + grammar.tag.join('/');

  return ListTile(
    dense: true,
    horizontalTitleGap: 0,
    minVerticalPadding: 0,
    minLeadingWidth: 30,
    contentPadding: EdgeInsets.only(left: 14, right: 14, top: 0, bottom: 0),
    leading: Text('${grammar.id}', style: TextStyle(fontSize: 14, color: Colors.black54),),
    title: Text('${grammar.title}', style: TextStyle(fontSize: 14, color: Colors.black87)),
    subtitle: Text(subTitle, style: TextStyle(fontSize: 12, color: Colors.black45)),
    trailing: trailing,
  );
}
