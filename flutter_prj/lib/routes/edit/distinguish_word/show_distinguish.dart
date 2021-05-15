import 'package:flutter/material.dart';
import 'package:flutter_prj/serializers/distinguish.dart';


Widget distinguishItem({BuildContext context, DistinguishSerializer distinguish, Widget trailing}) {
  String title = distinguish.wordsForeign.join(', ');
  return ListTile(
    dense: true,
    horizontalTitleGap: 0,
    minVerticalPadding: 0,
    minLeadingWidth: 30,
    contentPadding: EdgeInsets.only(left: 14, right: 14, top: 0, bottom: 0),
    leading: Text('${distinguish.id}', style: TextStyle(fontSize: 14, color: Colors.black54),),
    title: Text(title, style: TextStyle(fontSize: 14, color: Colors.black87)),
    trailing: trailing,
  );
}
