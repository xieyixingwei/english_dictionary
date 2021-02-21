import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../common/http.dart';
import '../models/index.dart';
import '../states/user_model.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _unameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  final GlobalKey _formKey =  GlobalKey<FormState>();
  bool pwdShow = false;

  void _onLogin(BuildContext context) async {
    // 提交前，先验证各个表单字段是否合法
    if ((_formKey.currentState as FormState).validate()) {
      ///showLoading(context);
      User user;
      try {
        user = await Http(context).login(_unameController.text, _pwdController.text);
        // 因为登录页返回后，首页会build，所以我们传false，更新user后不触发更新
        Provider.of<UserModel>(context, listen: false).user = user;
      } catch (e) {
        if (e.response?.statusCode == 401) {
          Fluttertoast.showToast(msg:"User name or password wrong!");///GmLocalizations.of(context).userNameOrPasswordWrong);
        } else {
          Fluttertoast.showToast(msg:e.toString());
        }
      } finally {
        //Navigator.of(context).pop(); // 隐藏loading框
      }

      if (user != null) {
        Navigator.pushNamed(context, "/", arguments:3);
      }
    }
  }

  Widget _buildForm(BuildContext context) =>
    Form(
      key: _formKey, //设置globalKey，用于后面获取FormState
      autovalidateMode: AutovalidateMode.always, //开启自动校验
      child: Column(
        children: <Widget>[
          TextFormField(
            autofocus: false,
            keyboardType: TextInputType.number, // 键盘回车键的样式
            textInputAction: TextInputAction.next,
            controller: _unameController,
            decoration: InputDecoration(
              labelText: "用户名或邮箱",
              hintText: "用户名或邮箱",
              icon: Icon(Icons.person)
            ),
            validator: (v) { // 校验用户名
              return v.trim().length > 0 ? null : "用户名不能为空";
            }
          ),
          TextFormField(
            autofocus: false,
            controller: _pwdController,
            decoration: InputDecoration(
              labelText: "密码", hintText: "您的登录密码", icon: Icon(Icons.lock)
            ),
            obscureText: true,
            validator: (v) {
              return v.trim().length > 2 ? null : "密码不能少于6位";
            }
          ),
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    padding: EdgeInsets.all(15.0),
                    child: Text("登录"),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () => _onLogin(context),
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
      appBar: AppBar(
        title: Text("登录"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 120.0,
            alignment:Alignment.centerLeft,
            padding: EdgeInsets.only(left:30.0),
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.only(right: 30),
              child: InkWell(
                child: Text("注册", style: TextStyle(color: Theme.of(context).primaryColor,),),
                onTap: () => Navigator.pushNamed(context, "/register"),
              ),
            ),
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
    );
  }
}
