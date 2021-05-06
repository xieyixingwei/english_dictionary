import 'package:flutter/material.dart';
import 'routes/tabs/discover.dart';
import 'routes/tabs/home/home.dart';
import 'routes/tabs/practice.dart';
import 'routes/tabs/user_tab.dart';


class DictionaryApp extends StatefulWidget {
  int _currentIndex;

  DictionaryApp({Key key, int index = 0})
    : _currentIndex = index,
      super(key: key);

  @override
  _DictionaryApp createState() => _DictionaryApp();
}

class _DictionaryApp extends State<DictionaryApp> {

  final List<Widget> _tabs = [
    Home(),
    TabPractice(),
    TabDiscover(),
    UserTab(),
  ];

  final List<BottomNavigationBarItem> _items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home), //(Icons.home, color:Colors.grey,),
      //activeIcon: Icon(Icons.home, color:Colors.blue,),
      label: "首页",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.import_contacts),
      label: "练习",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.remove_red_eye),
      label: "发现",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: "我的",
    ),
  ];


  @override
  Widget build(BuildContext context) {
    // print(MediaQuery.of(context).size.toString());
    return Scaffold(
      body: _tabs[widget._currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget._currentIndex,
        iconSize: 24,
        elevation: 50,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (int index) {
          setState(() {
            widget._currentIndex = index;
          });
        },
        items: _items,
      ),
    );
  }
}
