import 'package:flutter/material.dart';
import 'package:flutter_prj/models/user_model.dart';
import 'package:provider/provider.dart';
import '../login.dart';


class UserTab extends StatelessWidget {
  final listItems = [
    {
      'title': '我的课程',
      'icon': Icon(Icons.subtitles),
    },
    {
      'title': '我的收藏',
      'icon': Icon(Icons.favorite),
    },
  ];
  final listItemsOfRoot = [
    {
      'title': '用户管理',
      'icon': Icon(Icons.people_outline),
      'route': '/list_users',
    },
    {
      'title': '编辑单词',
      'icon': Icon(Icons.drive_file_rename_outline),
      'route': '/list_words',
    },
    {
      'title': '编辑例句',
      'icon': Icon(Icons.edit),
      'route': '/list_sentences',
    },
    {
      'title': '编辑语法',
      'icon': Icon(Icons.grid_on),
      'route': '/list_grammars',
    },
    {
      'title': '编辑词根词缀',
      'icon': Icon(Icons.hdr_strong),
      'route': '/list_etymas',
    },
    {
      'title': '编辑常用句型',
      'icon': Icon(Icons.gesture),
      'route': '/list_sentence_patterns',
    },
    {
      'title': '编辑词义辨析',
      'icon': Icon(Icons.transform),
      'route': '/list_distinguishes'
    }
  ];
  final statistics = [
    {
      'title': '已学单词',
      'value': 1000,
    },
  ];
  final statisticsOfRoot = [
    {
      'title': '单词数',
      'value': 12560,
    },
    {
      'title': '例句数',
      'value': 454,
    },
    {
      'title': '语法数',
      'value': 560,
    },
  ];

  final titleTextStyle = const TextStyle(fontSize: 16.0);
  final arrowForwardIosIcon = const Icon(Icons.arrow_forward_ios, size:20.0);

    @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(
      builder: (BuildContext context, UserModel user, Widget child) =>
        user.isLogin ? _buildCustomScrollView(context, user) : LoginPage()
    );
  }

  _buildStatistics(UserModel user) {
    List statisticsTotal = [];
    statisticsTotal.addAll(statistics);
    if(user.user.uname == 'root') {
      statisticsTotal.addAll(statisticsOfRoot);
    }
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: statisticsTotal.map((e) =>
              Column(
                children: [
                  Text(e['value'].toString(), style: const TextStyle(fontSize: 12.0)),
                  Text(e['title'], style: const TextStyle(fontSize: 12.0))
                ],
              )).toList()
            );
  }

  Widget _buildHeader(BuildContext context, UserModel user) =>
    Container(
      padding: EdgeInsets.only(bottom: 20),
      color: Colors.white,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(Icons.settings, size: 16),
              onPressed: () => Navigator.pushNamed(context, '/setting'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.insert_emoticon, size: 50.0),
            title:  Text(user.user.uname, style: const TextStyle( fontSize: 24.0)),
            subtitle: Text('RegID: ' + user.user.id.toString(), style: const TextStyle(fontSize: 10.0)),
          ),
          SizedBox(height: 10,),
          _buildStatistics(user),
        ],
      ),
    );

  Widget _listOptions(BuildContext context, UserModel user) {
    List listItemsTotal = [];
    listItemsTotal.addAll(listItems);
    if(user.user.uname == 'root') {
      listItemsTotal.addAll(listItemsOfRoot);
    }

    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        children: listItemsTotal.map((e) =>
          Container(
            margin: EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(3)),
            ),
            child: ListTile(
              leading: e['icon'],
              title: Text(e['title'], style: const TextStyle( fontSize: 16.0)),
              trailing: arrowForwardIosIcon,
              onTap: () => e['route'] != null ? Navigator.pushNamed(context, e['route']) : false,
            )
          )
        ).toList(),
      ),
    );
  }

  Widget _buildCustomScrollView(BuildContext context, UserModel user) =>
    SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(6, 6, 6, 0),
      child: Column( children: [
        _buildHeader(context, user),
        _listOptions(context, user),
      ],
      ),
    );
}
