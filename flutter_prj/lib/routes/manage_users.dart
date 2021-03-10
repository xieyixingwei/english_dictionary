import 'package:flutter/material.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/InputDialog.dart';


class ManageUsers extends StatefulWidget {
  ManageUsers({Key key}) : super(key: key);

  @override
  _ManageUsersState createState() => _ManageUsersState();
}


class _ManageUsersState extends State<ManageUsers> {

  List<UserSerializer> users;

  Future<List<UserSerializer>> _init() async {
    var res = await UserSerializer.list();

    setState(() {
      users = res;
    });
  }

  @override
  void initState() { 
    super.initState();
    _init();
  }

  _children() {
    if(users == null) return [Text("")];
    var children = users.map((e) =>
        ListTile(
          title: Text(e.u_uname),
          trailing: IconButton(
            splashRadius: 1.0,
            icon: Icon(Icons.clear),
            onPressed: () {
              e.delete();
              setState(() => users.remove(e));
            },
          ),
        )
      ).toList();
    children.add(
      ListTile(
        title: Text("创建用户"),
        leading: PopInputDialog(
          close: (String value) {
          },
        ),
      ),
    );
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
                appBar: AppBar(
                  title: Text("管理用户"),
                ),
                body: ListView(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    children: _children(),
                  ),
              );
  }
}
