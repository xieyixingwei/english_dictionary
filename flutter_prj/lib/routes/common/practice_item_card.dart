import 'package:flutter/material.dart';
import 'package:flutter_prj/widgets/column_space.dart';

Widget practiceItemCard(BuildContext context, String title, String count, Function onPressed) =>
  Container(
    padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
    alignment: Alignment.center,
    height: 160,
    width: 160,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(8)),
      /*boxShadow: [
        BoxShadow(color: Colors.black26, offset: Offset(5.0, 5.0), blurRadius: 5.0, spreadRadius: 1.0),
        BoxShadow(color: Colors.black26, offset: Offset(1.0, 1.0)), BoxShadow(color: Colors.black26)
      ],*/
    ),
    child: Center(
      child: InkWell(
        child: ColumnSpace(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            count == null ? null : Text(count, style: TextStyle(fontSize: 17),),
            Text(title, style: TextStyle(fontSize: 17),),
          ]
        ),
        onTap: onPressed,
      ),
    ),
  );
