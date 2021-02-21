import 'package:flutter/material.dart';
import '../common/global.dart';


class Setting extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('设置'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('账号管理'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            title: Text('学习设置'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 25, 15, 25),
            child: RaisedButton(
              child: Text('退出登录'),
              color: Colors.redAccent,
              onPressed: () {
                Global.clear();
                Navigator.pushNamed(context, "/login");
              } 
            ),
          ),
        ],
      ),
    );
  }
}
