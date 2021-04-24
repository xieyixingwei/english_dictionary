import 'package:flutter/material.dart';
import 'package:flutter_prj/routes/edit/word/show_word.dart';
import 'package:flutter_prj/serializers/index.dart';


class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final WordSerializer _word = WordSerializer()..name = 'dense';
  

  @override
    void initState() {
      _init();
      super.initState();
    }

  void _init() async {
    await _word.retrieve();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          children:[
            //_header,
            Container(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: _search,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
              child: ShowWord(word: _word,),
            ),
          ],
        ),
      ),
    );

  Widget get _header =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "会说英语",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10,),
        Text(
          "让英语学习更高效",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );

  Widget get _search =>
    TextField(
      maxLines: 1,
      style: TextStyle(
        fontSize: 16,
      ),
      onChanged: (v) => _word.name = v.trim(),
      decoration: InputDecoration(
        hintText: "输入单词或句子",
        border: OutlineInputBorder(),
        suffixIcon: IconButton(
          splashRadius: 1.0,
          iconSize: 28,
          tooltip: '搜索',
          icon: Icon(Icons.search),
          onPressed: () async {
            if(_word.name.trim().isEmpty) return;
            await _word.retrieve();
            setState(() {});
          },
        ),
      ),
    );


}
