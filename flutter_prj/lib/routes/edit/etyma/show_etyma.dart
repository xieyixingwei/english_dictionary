import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/edit_delete.dart';


class ShowEtyma extends StatefulWidget {
  final EtymaSerializer _etyma;
  final Function _delete;

  ShowEtyma({Key key, EtymaSerializer etyma, Function delete})
    : _etyma = etyma,
      _delete = delete,
      super(key:key);

  @override
  _ShowEtymaState createState() => _ShowEtymaState();
}

class _ShowEtymaState extends State<ShowEtyma> {

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 0.0,
      //leading: Text('相关语法'),
      title: Row(
        children: [
          Text(widget._etyma.name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
          SizedBox(width: 10,),
          Text('[ ${Global.etymaTypeOptions[widget._etyma.type]} ]', style: TextStyle(fontSize: 14, color: Colors.orangeAccent),),
          SizedBox(width: 10,),
          Text(widget._etyma.interpretation, style: TextStyle(fontSize: 14,),),
        ]
      ),
      trailing: EditDelete(
        edit: () async {
          var e = (await Navigator.pushNamed(context, '/edit_etyma', arguments:{'title':'编辑词根词缀','etyma': EtymaSerializer().from(widget._etyma)})) as EtymaSerializer;
          if(e != null) await widget._etyma.from(e).save();
          setState(() {});
        },
        delete: widget._delete,
      ),
    );
  }
}
