
import 'package:flutter/material.dart';


class EditDelete extends StatelessWidget {
  final Function _edit;
  final Function _delete;

  EditDelete({Key key,Function edit, Function delete})
    : _edit = edit,
      _delete = delete,
     super(key: key);

  _buildDelete() => 
    _delete != null ?
    Padding(
      padding: EdgeInsets.only(left: 10),
      child: InkWell(
          child: Text('删除', style: TextStyle(color: Colors.pink,)),
          onTap: _delete,
        ),
    )
    : Container(height: 0, width: 0,);

  @override
  Widget build(BuildContext context) =>
    Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          child: Text('编辑', style: TextStyle(color: Colors.blueAccent),),
          onTap: _edit,
        ),
        _buildDelete(),
      ],
    );
}
