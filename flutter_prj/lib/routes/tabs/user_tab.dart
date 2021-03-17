import 'package:flutter/material.dart';
import 'package:flutter_prj/models/user_model.dart';
import 'package:flutter_prj/models/word_model.dart';
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
      'icon': Icon(Icons.person_add_disabled),
      'route': '/manage_users',
    },
    {
      'title': '编辑单词',
      'icon': Icon(Icons.drive_file_rename_outline),
      'route': '/edit_words',
    },
    {
      'title': '编辑例句',
      'icon': Icon(Icons.edit),
      'route': '/edit_sentences',
    },
    {
      'title': '编辑语法',
      'icon': Icon(Icons.g_translate_sharp),
      'route': '/edit_grammars',
    },
    {
      'title': '编辑词根词缀',
      'icon': Icon(Icons.g_translate_sharp),
      'route': '/edit_etymas',
    },
    {
      'title': '编辑常用句型',
      'icon': Icon(Icons.g_translate_sharp),
      'route': '/edit_sentence_patterns',
    },
    {
      'title': '编辑词义辨析',
      'icon': Icon(Icons.g_translate_sharp),
      'route': '/edit_distinguishes'
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
  final arrowForwardIosIcon = const Icon(Icons.arrow_forward_ios, size:30.0);

  _buildStatistics(UserModel user) {
    List statisticsTotal = [];
    statisticsTotal.addAll(statistics);
    if(user.user.uname == 'root') {
      statisticsTotal.addAll(statisticsOfRoot);
    }
    return statisticsTotal.map((e) => 
        Expanded(
          flex: 1,
          child: ListTile(
            title:  Text(e['value'].toString(), style: const TextStyle(color: Colors.white, fontSize: 18.0)),
            subtitle: Text(e['title'], style: const TextStyle(color: Colors.white, fontSize: 10.0)),
          ),
        )
      ).toList();
  }

  _buildSliverAppBar(BuildContext context, UserModel user) =>
    SliverAppBar(
      floating: true,
      pinned: false,
      snap: true,
      backgroundColor: Colors.blue,
      iconTheme: IconThemeData(color: Colors.transparent),
      expandedHeight: 280.0,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: InkWell(
                        child: Icon(Icons.settings, size: 20, color: Colors.white,),
                        onTap: () => Navigator.pushNamed(context, '/setting'),
                      ),
                    )
                ]
              ),
              Row(
                children:[
                  Expanded(
                    flex: 1,
                    child: ListTile(
                      title:  Text(user.user.uname, style: const TextStyle(color: Colors.white, fontSize: 24.0)),
                      subtitle: Text('RegID: ' + user.user.id.toString(), style: const TextStyle(color: Colors.white, fontSize: 10.0)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 40, 0),
                    child: Icon(Icons.insert_emoticon, size: 60.0, color: Colors.white,),
                  )
                ],
              ),
              Row(
                children: _buildStatistics(user),
              ),
            ],
          ),
        ),
      ),
    );

  _buildSliverChildBuilderDelegate(BuildContext context, UserModel user) {
    List listItemsTotal = [];
    listItemsTotal.addAll(listItems);
    if(user.user.uname == 'root') {
      listItemsTotal.addAll(listItemsOfRoot);
    }
    return SliverChildBuilderDelegate(
      (BuildContext context, int index) =>
        Container(
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () =>
              Navigator.pushNamed(context, listItemsTotal[index]['route']),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                  child: Row(
                    children: <Widget>[
                      listItemsTotal[index]['icon'],
                      SizedBox(width: 20,),
                      Expanded(
                        child: Text(
                          listItemsTotal[index]['title'],
                          style: titleTextStyle,
                        ),
                      ),
                      arrowForwardIosIcon,
                    ],
                  ),
                ),
                Divider(height: 1.0,)
              ],
            ),
          )
        ),
      childCount: listItemsTotal.length,
    );
  }

  _buildSliverFixedExtentList(BuildContext context, UserModel user) =>
    SliverFixedExtentList(
      delegate: _buildSliverChildBuilderDelegate(context, user),
      itemExtent: 61.0
    );

  _buildCustomScrollView(BuildContext context, UserModel user) =>
    CustomScrollView(
      reverse: false,
      shrinkWrap: false,
      slivers: <Widget>[
        _buildSliverAppBar(context, user),
        _buildSliverFixedExtentList(context, user),
      ]
    );

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserModel, WordModel>(
      builder: (BuildContext context, UserModel user, WordModel word, Widget child) =>
        user.isLogin ? _buildCustomScrollView(context, user) : LoginPage()
    );
  }
}
