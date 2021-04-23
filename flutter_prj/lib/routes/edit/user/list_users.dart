import 'package:flutter/material.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/edit_delete.dart';


class ListUsers extends StatefulWidget {
  ListUsers({Key key}) : super(key: key);

  @override
  _ListUsersState createState() => _ListUsersState();
}


class _ListUsersState extends State<ListUsers> {
  List<UserSerializer> _users = [];

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    var users = await UserSerializer.list();
    setState(() => _users = users);
  }

  _buildListUsers(BuildContext context) =>
    Expanded(
      child: ListView(
        children: _users.map<Widget>((e) =>
          ListTile(
            title: Text(e.uname),
            trailing: EditDelete(
              edit: () async {
                var user = (await Navigator.pushNamed(context, '/edit_user', arguments:{'title':'编辑用户','user': UserSerializer().from(e)})) as UserSerializer;
                if(user != null) await e.from(user).update();
                setState(() {});
              },
              delete: () { e.delete(); setState(() => _users.remove(e));},
            ),
          )
        ).toList(),
      )
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('管理用户'),
          centerTitle: true,
        ),
        body: Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildListUsers(context),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        child: Text("添加用户"),
                        onPressed: () async {
                           var user = (await Navigator.pushNamed(context, '/edit_user', arguments:{'title':'编辑用户'})) as UserSerializer;
                          if(user != null) {
                            bool ret = await user.register();
                            if(ret) setState(() => _users.add(user));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
  }
}
