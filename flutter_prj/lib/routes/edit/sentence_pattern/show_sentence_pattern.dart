import 'package:flutter/material.dart';
import 'package:flutter_prj/serializers/index.dart';


Widget sentencePattrenItem({BuildContext context, SentencePatternSerializer sp, Widget trailing}) {

  return ListTile(
    dense: true,
    horizontalTitleGap: 0,
    minVerticalPadding: 0,
    minLeadingWidth: 30,
    contentPadding: EdgeInsets.only(left: 14, right: 14, top: 0, bottom: 0),
    leading: Text('${sp.id}', style: TextStyle(fontSize: 14, color: Colors.black54),),
    title: Text(sp.content, style: TextStyle(fontSize: 14, color: Colors.black87)),
    trailing: trailing,
  );
}
