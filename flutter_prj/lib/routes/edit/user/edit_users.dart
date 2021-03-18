import 'package:flutter/material.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/edit_delete.dart';


class EditUsers extends StatefulWidget {
  EditUsers({Key key}) : super(key: key);

  @override
  _EditUsersState createState() => _EditUsersState();
}


class _EditUsersState extends State<EditUsers> {
  List<UserSerializer> _users = [];

  void _init() async {
    var users = await UserSerializer.list();
    setState(() => _users = users);
  }

  @override
  void initState() { 
    super.initState();
    _init();
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
        ),
        body: Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        padding: EdgeInsets.all(15.0),
                        child: Text("添加用户"),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
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
                _buildListUsers(context),
              ],
            ),
          ),
        );
  }
}
