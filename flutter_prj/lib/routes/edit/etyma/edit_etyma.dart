import 'package:flutter/material.dart';
import 'package:flutter_prj/serializers/etyma.dart';


class EditEtyma extends StatefulWidget {
  static const List<String> options = ['前缀', '后缀', '词根'];
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
  
  String _select = EditEtyma.options.first;

  @override
  void initState() {
    super.initState();
    _select = EditEtyma.options[widget._etyma.type];
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(fontSize: 14,);
    return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: Text(widget._title),
            centerTitle: true,
            //automaticallyImplyLeading: false, // 取消返回按钮
            leading: TextButton(
              child: Text('取消', style: TextStyle(color: Colors.white),),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              TextButton(
                child: Text('确定', style: TextStyle(color: Colors.white),),
                onPressed: () {
                  if((_formKey.currentState as FormState).validate()) // 验证各个表单字段是否合法
                    Navigator.pop(context, widget._etyma);
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
            child: Form(
              key: _formKey, //设置globalKey，用于后面获取FormState
              autovalidateMode: AutovalidateMode.always, //开启自动校验
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 120),
                        child: DropdownButtonFormField(
                          autofocus: false,
                          value: _select,
                          elevation: 0,
                          items: EditEtyma.options.map((e)=>DropdownMenuItem(child: Text(e, style: textStyle,), value: e,)).toList(),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.fromLTRB(10,18,2,18),
                            prefixText: '类型:  ',
                            prefixStyle: TextStyle(fontSize: 14, color: Color.fromRGBO(132,132,132,1.0)),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (v) {
                            widget._etyma.type = EditEtyma.options.indexOf(v);
                            setState(() => _select = v);
                          },
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        flex: 5,
                        child: TextFormField(
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
                      ),
                    ],
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
                ]
            ),
          ),
        ),
    );
  }
}
