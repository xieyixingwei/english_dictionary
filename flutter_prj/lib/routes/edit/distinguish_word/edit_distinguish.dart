import 'package:flutter/material.dart';
import 'package:flutter_prj/serializers/distinguish.dart';
import 'package:flutter_prj/widgets/pop_dialog.dart';
import 'package:flutter_prj/widgets/wrap_custom.dart';
import 'package:flutter_prj/widgets/ok_cancel.dart';


class EditDistinguish extends StatefulWidget {
  final String _title;
  final DistinguishSerializer _distinguish;

  EditDistinguish({Key key, String title, DistinguishSerializer distinguish})
    : _title = title,
      _distinguish = distinguish ?? DistinguishSerializer(),
      super(key:key);

  @override
  _EditDistinguishState createState() => _EditDistinguishState();
}

class _EditDistinguishState extends State<EditDistinguish> {
  final GlobalKey _formKey =  GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      Navigator.pop(context, widget._distinguish);
                  },
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
              child: Form(
                key: _formKey, //设置globalKey，用于后面获取FormState
                autovalidateMode: AutovalidateMode.always, //开启自动校验
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      autofocus: false,
                      initialValue: widget._distinguish.id.toString(),
                      keyboardType: TextInputType.number, // 键盘回车键的样式
                      textInputAction: TextInputAction.next,
                      maxLines: 1,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        labelText: "id",
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          splashRadius: 1.0,
                          icon: Icon(Icons.search),
                          tooltip: '搜索',
                          onPressed: () async {
                            bool ret = await widget._distinguish.retrieve();
                            if(ret) setState((){});
                          },
                        ),
                      ),
                      onChanged: (v) => widget._distinguish.id = num.parse(v.trim()),
                      //validator: (v) => v.trim().isNotEmpty ? null : "不能为空",
                    ),
                    SizedBox(height: 20,),
                    WrapOutlineTag(
                      data: widget._distinguish.wordsForeign,
                      labelText: '辨析单词',
                      suffix: TextButton(
                        child: Text('添加',),
                        onPressed: () => popInputDialog(
                          context: context,
                          title: Text('输入辨析单词'),
                          close: (v) => setState(() => widget._distinguish.wordsForeign.add(v)),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      autofocus: false,
                      keyboardType: TextInputType.number, // 键盘回车键的样式
                      textInputAction: TextInputAction.next,
                      controller: TextEditingController(text: widget._distinguish.content),
                      minLines: 1,
                      maxLines: null,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        labelText: "内容(markdown)",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (v) => widget._distinguish.content = v.trim(),
                      validator: (v) => v.trim().isNotEmpty ? null : "不能为空",
                    ),
                  ]
              ),
          ),
        ),
      );
  }
}
