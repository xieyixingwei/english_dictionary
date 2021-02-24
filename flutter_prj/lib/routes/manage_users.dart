import 'package:flutter/material.dart';
import 'package:flutter_prj/common/http.dart';
import 'package:flutter_prj/widgets/InputDialog.dart';


class ManageUsers extends StatefulWidget {
  ManageUsers({Key key}) : super(key: key);

  @override
  _ManageUsersState createState() => _ManageUsersState();
}


class _ManageUsersState extends State<ManageUsers> {

  Future<List> _init() async {
    var users = await Http().listUsers();
    return users;
  }

  _children(List users) {
    if(users == null) return [Text("")];
    var children = users.map((e) =>
        ListTile(
          title: Text(e['u_uname']),
          trailing: IconButton(
            splashRadius: 1.0,
            icon: Icon(Icons.clear),
            onPressed: () {
              Http().deleteUser(e['u_uname']);
            },
          ),
        )
      ).toList();
    children.add(
      ListTile(
        title: Text("创建用户"),
        leading: InputDialog(
          title: "创建用户",
          icon: Icon(Icons.add),
          close: (String value) {
          },
        ),
      ),
    );
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
            future: _init(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) =>
              Scaffold(
                appBar: AppBar(
                  title: Text("管理用户"),
                ),
                body: ListView(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    children: _children(snapshot.data),
                  ),
              )
    );
  }
}
