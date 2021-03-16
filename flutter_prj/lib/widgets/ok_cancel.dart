
import 'package:flutter/material.dart';


class OkCancel extends StatelessWidget {
  final Function _ok;
  final Function _cancel;

  OkCancel({Key key,Function ok, Function cancel})
    : _ok = ok,
      _cancel = cancel,
     super(key: key);

  @override
  Widget build(BuildContext context) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          splashRadius: 1.0,
          icon: Icon(Icons.done, color: Colors.green,),
          tooltip: '确定',
          onPressed: _ok,
        ),
        SizedBox(width: 8,),
        IconButton(
          splashRadius: 1.0,
          icon: Icon(Icons.clear, color: Colors.grey,),
          tooltip: '取消',
          onPressed: _cancel ?? () => Navigator.pop(context),
        ),
      ]
    );
}
