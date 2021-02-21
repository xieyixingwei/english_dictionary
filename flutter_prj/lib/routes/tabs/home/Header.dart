import 'package:flutter/material.dart';


class HomeHeader extends StatelessWidget {

  @override
    Widget build(BuildContext context) {
      return Column(
        // padding: EdgeInsets.all(5),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Text(
              "会说英语",
              style:TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10,),
            Text(
              "让英语学习更高效",
              style:TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
        ],
      );
    }
}
