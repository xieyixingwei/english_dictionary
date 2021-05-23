import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:fluttertoast/fluttertoast.dart';


class RegisterPage extends StatelessWidget {
  final TextEditingController _unameController = TextEditingController();
  final TextEditingController _pwdController1 = TextEditingController();
  final TextEditingController _pwdController2 = TextEditingController();
  final GlobalKey _formKey =  GlobalKey<FormState>();
  final bool pwdShow = false;

  void _onRegister(BuildContext context) async {
    // 提交前，先验证各个表单字段是否合法
    if ((_formKey.currentState as FormState).validate()) {
      ///showLoading(context);
      UserSerializer user = UserSerializer();
      bool ret = false;
      try {
        ret = await user.register(data:{"uname":_unameController.text, "passwd":_pwdController1.text});
        // 因为登录页返回后，首页会build，所以我们传false，更新user后不触发更新
        ///Provider.of<UserModel>(context, listen: false).user = user;
      } catch (e) {
        if (e.response?.statusCode == 401) {
          Fluttertoast.showToast(msg:"User name or password wrong!");///GmLocalizations.of(context).userNameOrPasswordWrong);
        } else {
          Fluttertoast.showToast(msg:e.toString());
        }
      } finally {
        //Navigator.of(context).pop(); // 隐藏loading框
      }

      if (ret) {
        Navigator.of(context).pop(); // 返回
      }
    }
  }

  Widget _buildForm(BuildContext context) =>
    Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        children: <Widget>[
          TextFormField(
            autofocus: false,
            keyboardType: TextInputType.text,
            controller: _unameController,
            decoration: InputDecoration(
              labelText: "用户名或邮箱",
              hintText: "用户名或邮箱",
              icon: Icon(Icons.person),
            ),
            validator: (v) { // 校验用户名
              return v.trim().length > 0 ? null : "用户名不能为空";
            }
          ),
          TextFormField(
            autofocus: false,
            controller: _pwdController1,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "密码", hintText: "输入密码", icon: Icon(Icons.lock)
            ),
            obscureText: true,
            validator: (v) { // 校验密码
              return v.trim().length > 2 ? null : "密码不能少于6位";
            }
          ),
          TextFormField(
            autofocus: false,
            controller: _pwdController2,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "密码", hintText: "再次输入密码", icon: Icon(Icons.lock)
            ),
            obscureText: true,
            validator: (v) {
              return v.trim() == _pwdController1.text.trim() ? null : "请输入相同的密码";
            }
          ),
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    padding: EdgeInsets.all(15.0),
                    child: Text("注册"),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () => _onRegister(context),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("注册"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 120.0,
              alignment:Alignment.centerLeft,
              padding: EdgeInsets.only(left:30.0),
              color: Colors.white,
            ),
            Container(
              color: Colors.white,
              alignment: Alignment.center,
              padding: EdgeInsets.only(left:30.0, right:30.0),
              child: Container(
                child: _buildForm(context),
              ),
            ),
          ],
        ),
      )
    );
  }
}
