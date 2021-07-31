import 'package:flutter/material.dart';


List<Widget> practiceActionsWidget(List<Map<String, dynamic>> actions, Function update) {
  return actions.map((e) => 
    Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(e['label'], style: const TextStyle(fontSize: 14, color: Colors.black45),),
        SizedBox(width: 3,),
        Switch(
          value: e['value'],
          onChanged: (v) {
            e['value'] = v;
            update();
          },
        ),
      ],
    )
  ).toList();
}
