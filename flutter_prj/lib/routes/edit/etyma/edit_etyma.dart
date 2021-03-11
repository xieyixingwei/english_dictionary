import 'package:flutter/material.dart';
import 'package:flutter_prj/serializers/etyma.dart';
import 'package:flutter_prj/widgets/ok_cancel.dart';


class EditEtyma extends StatefulWidget {
  final String _title;
  final EtymaSerializer _etyma;

  EditEtyma({Key key, String title, EtymaSerializer etyma})
    : _title = title,
      _etyma = etyma ?? EtymaSerializer(),
      super(key: key);

  @override
  _EditEtymaState createState() => _EditEtymaState();
}

class _EditEtymaState extends State<EditEtyma> {
  final GlobalKey _formKey =  GlobalKey<FormState>();
  static const List<String> _options = ['前缀', '后缀', '词根'];
  String _select = _options.first;

  @override
  void initState() {
    super.initState();
    _select = _options[widget._etyma.type];
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(fontSize: 14,);
    return Scaffold(
          appBar: AppBar(
            title: Text(widget._title),
            automaticallyImplyLeading: false, // 取消返回按钮
          ),
          body: Container(
            padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: Form(
              key: _formKey, //设置globalKey，用于后面获取FormState
              autovalidateMode: AutovalidateMode.always, //开启自动校验
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField(
                    autofocus: false,
                    value: _select,
                    items: _options.map((e)=>DropdownMenuItem(child: Text(e), value: e,)).toList(),
                    decoration: InputDecoration(
                      labelText: "类型",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (v) {
                      widget._etyma.type = _options.indexOf(v);
                      setState(() => _select = v);
                    },
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    autofocus: false,
                    keyboardType: TextInputType.number, // 键盘回车键的样式
                    textInputAction: TextInputAction.next,
                    controller: TextEditingController(text:widget._etyma.name ?? ''),
                    maxLines: 1,
                    style: textStyle,
                    decoration: InputDecoration(
                      labelText: "词根词缀",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => widget._etyma.name = value.trim(),
                    validator: (v) => v.trim().isNotEmpty ? null : "不能为空",
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    autofocus: false,
                    keyboardType: TextInputType.number, // 键盘回车键的样式
                    textInputAction: TextInputAction.next,
                    controller: TextEditingController(text:widget._etyma.interpretation),
                    minLines: 1,
                    maxLines: null,
                    style: textStyle,
                    decoration: InputDecoration(
                      labelText: "含义",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => widget._etyma.interpretation = value.trim(),
                    //validator: (v) => v.trim().isNotEmpty ? null : "不能为空",
                  ),
                  SizedBox(height: 20,),
                  OkCancel(ok: () {
                    if((_formKey.currentState as FormState).validate()) // 验证各个表单字段是否合法
                      Navigator.pop(context, widget._etyma);
                  }),
                ]
            ),
          ),
        ),
    );
  }
}