import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/widgets/column_space.dart';


class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

  @override
  void initState() {
    super.initState();
    retrieve();
  }

  void retrieve() async {
    setState((){});
  }

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        title: Text('我的收藏'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
        child: ColumnSpace(
          crossAxisAlignment: CrossAxisAlignment.start,
          divider: SizedBox(height: 14,),
          children: [
            _card(context, '收藏的单词', Global.localStore.user.studyWordSet.length, (){}),
            _card(context, '收藏的词义辨析', Global.localStore.user.studyPlan.distinguishes.length, (){}),
            _card(context, '收藏的句子', Global.localStore.user.studySentenceSet.length, (){}),
            _card(context, '收藏的语法', Global.localStore.user.studyGrammarSet.length, (){}),
          ],
        ),
      ),
    );

  Widget _card(BuildContext context, String title, num count, Function onPressed) =>
    Container(
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(3)),
        boxShadow: [
          BoxShadow(color: Colors.black26, offset: Offset(5.0, 5.0), blurRadius: 5.0, spreadRadius: 1.0),
          BoxShadow(color: Colors.black26, offset: Offset(1.0, 1.0)), BoxShadow(color: Colors.black26)
        ],
      ),
      child: InkWell(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.favorite, color: Colors.redAccent,),
            SizedBox(width: 14,),
            Text(title, style: TextStyle(fontSize: 24),),
            SizedBox(width: 14,),
            Text('$count', style: TextStyle(fontSize: 14),)
          ],
        ),
        onTap: onPressed,
      ),
    );
}

enum FavoriteType { word, distinguish, sentence, grammar} 

class ListFavoritePage extends StatefulWidget {
  ListFavoritePage({Key key, this.type}) : super(key:key);

  final FavoriteType type;

  @override
  _ListFavoritePageState createState() => _ListFavoritePageState();
}

class _ListFavoritePageState extends State<ListFavoritePage> {

  String _title;

  @override
  void initState() {
    switch(widget.type) {
      case FavoriteType.word:
        _title = '收藏的单词';
        break;
      case FavoriteType.distinguish:
        _title = '收藏的词义辨析';
        break;
      case FavoriteType.sentence:
        _title = '收藏的句子';
        break;
      case FavoriteType.grammar:
        _title = '收藏的语法';
        break;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        title: Text(_title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
        child: ColumnSpace(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: ,
        ),
      ),
    );
  
  List<Widget> _children() {
    switch(widget.type) {
      case FavoriteType.word:
        return Global.localStore.user.studyWordSet.map((e) =>
          Row(
            children: [
              Text(e.word),
              SizedBox(width: 8,),
              InkWell(
                
              )
            ],
          )
        ).toList();
      case FavoriteType.distinguish:
        _title = '收藏的词义辨析';
      case FavoriteType.sentence:
        _title = '收藏的句子';
      case FavoriteType.grammar:
        _title = '收藏的语法';
    }
  }
}
