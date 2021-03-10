import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/serializers/index.dart';


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
  Widget build(BuildContext context) =>
    ListTile(
      //leading: Text('相关语法'),
      title: Row(
        children: [
          Text(widget._etyma.e_name),
          SizedBox(width: 10,),
          Text(widget._etyma.e_type == null ? 'null' : Global.etymaTypeOptions[widget._etyma.e_type], style: TextStyle(fontSize: 12),),
        ]
      ),
      subtitle: Text(widget._etyma.e_meaning),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            child: Text('编辑', style: TextStyle(color: Theme.of(context).primaryColor),),
            onTap: () async {
              EtymaSerializer etyma = EtymaSerializer().fromJson(widget._etyma.toJson());
              var e = (await Navigator.pushNamed(context, '/edit_etyma', arguments:{'title':'编辑词根词缀','etyma': etyma})) as EtymaSerializer;
              if(e != null){
                widget._etyma.fromJson(e.toJson());
                widget._etyma.update(update: true);
              }
              setState(() {});
            },
          ),
          SizedBox(width: 10,),
          widget._delete != null ?
          InkWell(
            child: Text('删除', style: TextStyle(color: Colors.pink,)),
            onTap: () => widget._delete(),
          ) : SizedBox(width: 0,),
        ],
      )
    );
}
