import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/common/http.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/column_space.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey _formKey =  GlobalKey<FormState>();
  bool pwdShow = false;

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        title: Text("登录"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(6, 20, 6, 0),
        child: ColumnSpace(
          crossAxisAlignment: CrossAxisAlignment.start,
          divider: SizedBox(height: 20,),
          children: [
            TextButton(
              child: Text("注册", style: TextStyle(color: Colors.blueAccent),),
              onPressed: () => Navigator.pushNamed(context, "/register"),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 20, 30, 0),
              child: _buildForm(context),
            ),
          ],
        ),
      ),
    );

  Widget _buildForm(BuildContext context) =>
    Form(
      key: _formKey, //设置globalKey，用于后面获取FormState
      //autovalidateMode: AutovalidateMode.always, //开启自动校验
      child: ColumnSpace(
        divider: SizedBox(height: 20,),
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: "用户名或邮箱",
              hintText: "用户名或邮箱",
              icon: Icon(Icons.person)
            ),
            onChanged: (v) => Global.localStore.user.uname = v.trim(),
            validator: (v) => Global.localStore.user.uname.isEmpty ? "用户名不能为空" : null, // 校验用户名
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: "密码", hintText: "您的登录密码", icon: Icon(Icons.lock)
            ),
            obscureText: true,
            onChanged: (v) => Global.localStore.user.passwd = v.trim(),
            validator: (v) => Global.localStore.user.passwd.length < 2 ? "密码不能少于6位" : null,
          ),
          Container(
            margin: const EdgeInsets.only(left: 30, right: 30, top: 20),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    child: Text("登录"),
                    onPressed: () => _onLogin(context),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );

  void _onLogin(BuildContext context) async {
    // 提交前，先验证各个表单字段是否合法
    if ((_formKey.currentState as FormState).validate()) {
      ///showLoading(context);
      LoginSerializer login = LoginSerializer();
      var ret = await login.login(queries:{"uname":Global.localStore.user.uname, "passwd":Global.localStore.user.passwd});
      if(!ret) return;

      Global.localStore.token = login.token;
      Http.token = login.token;

      Global.isLogin = await Global.localStore.user.retrieve();
      if(!Global.isLogin) return;

      Global.netCache.clear(); //清空所有缓存
      Global.saveLocalStore();
      Navigator.pushNamed(context, "/", arguments:3);
    }
  }
}
