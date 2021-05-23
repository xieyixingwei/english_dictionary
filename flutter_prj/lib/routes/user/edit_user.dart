import 'package:flutter/material.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/ok_cancel.dart';


class EditUser extends StatefulWidget {
  final String _title;
  final UserSerializer _user;

  EditUser({Key key, String title, UserSerializer user})
    : _title = title,
      _user = user ?? UserSerializer(),
      super(key:key);

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final GlobalKey _formKey =  GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: Text(widget._title),
              automaticallyImplyLeading: false, // 取消返回按钮
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
              child: Form(
                key: _formKey, //设置globalKey，用于后面获取FormState
                autovalidateMode: AutovalidateMode.always, //开启自动校验
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      autofocus: false,
                      initialValue: widget._user.uname,
                      keyboardType: TextInputType.number, // 键盘回车键的样式
                      textInputAction: TextInputAction.next,
                      maxLines: 1,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        labelText: "用户名",
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          splashRadius: 1.0,
                          icon: Icon(Icons.search),
                          tooltip: '搜索',
                          onPressed: () async {
                            bool ret = await widget._user.retrieve();
                            if(ret) setState(() {});
                          },
                        ),
                      ),
                      onChanged: (v) => widget._user.uname = v.trim(),
                      validator: (v) => v.trim().isNotEmpty ? null : "不能为空",
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      autofocus: false,
                      initialValue: widget._user.passwd,
                      keyboardType: TextInputType.number, // 键盘回车键的样式
                      textInputAction: TextInputAction.next,
                      maxLines: 1,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        labelText: "密码",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (v) => widget._user.passwd = v.trim(),
                      validator: (v) => v.trim().isNotEmpty ? null : "不能为空",
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Text('管理员: ', style: TextStyle(fontSize: 12, color: Color.fromRGBO(132,132,132,1.0))),
                        Switch(
                          value: widget._user.isAdmin,
                          onChanged: (v) => setState(() => widget._user.isAdmin = v),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    OkCancel(ok: () {
                      if((_formKey.currentState as FormState).validate()) // 验证各个表单字段是否合法
                        Navigator.pop(context, widget._user);
                    }),
                  ]
              ),
          ),
        ),
      );
  }
}
