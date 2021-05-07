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
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          children: [
            _card(context, '收藏的单词', Global.localStore.user.studyWordSet.length, ()=>Navigator.pushNamed(context, '/list_favorite_page', arguments: {'type': FavoriteType.word})),
            _card(context, '收藏的词义辨析', Global.localStore.user.studyPlan == null ? 0 : Global.localStore.user.studyPlan.distinguishes.length, ()=>Navigator.pushNamed(context, '/list_favorite_page', arguments: {'type': FavoriteType.distinguish})),
            _card(context, '收藏的句子', Global.localStore.user.studySentenceSet.length, ()=>Navigator.pushNamed(context, '/list_favorite_page', arguments: {'type': FavoriteType.sentence})),
            _card(context, '收藏的语法', Global.localStore.user.studyGrammarSet.length, ()=>Navigator.pushNamed(context, '/list_favorite_page', arguments: {'type': FavoriteType.grammar})),
          ],
        ),
      ),
    );

  Widget _card(BuildContext context, String title, num count, Function onPressed) =>
    Container(
      padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
      alignment: Alignment.center,
      height: 160,
      width: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        /*boxShadow: [
          BoxShadow(color: Colors.black26, offset: Offset(5.0, 5.0), blurRadius: 5.0, spreadRadius: 1.0),
          BoxShadow(color: Colors.black26, offset: Offset(1.0, 1.0)), BoxShadow(color: Colors.black26)
        ],*/
      ),
      child: InkWell(
        child: Column(
         mainAxisSize: MainAxisSize.min,
          children: [
          Text('$count', style: TextStyle(fontSize: 14),),
          Text(title, style: TextStyle(fontSize: 17),),
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
          children: _children(),
        ),
      ),
    );

  List<Widget> _children() {
    switch(widget.type) {
      case FavoriteType.word:
        return Global.localStore.user.studyWordSet.map((e) =>
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(e.word),
              TextButton(
                child: Text('加入学习计划'),
                onPressed: () => e.inplan = true,
              ),
              TextButton(
                child: Text('取消收藏'),
                onPressed: () {
                  e.delete();
                  Global.localStore.user.studyWordSet.remove(e);
                  setState((){});
                },
              ),
            ],
          )
        ).toList();
      case FavoriteType.distinguish:
        return Global.localStore.user.studyPlan.distinguishes.map((e) =>
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('$e'),
              TextButton(
                child: Text('取消收藏'),
                onPressed: () {
                  Global.localStore.user.studyPlan.distinguishes.remove(e);
                  setState((){});
                },
              ),
            ],
          )
        ).toList();
      case FavoriteType.sentence:
        return Global.localStore.user.studySentenceSet.map((e) =>
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('${e.sentence}'),
              TextButton(
                child: Text('加入学习计划'),
                onPressed: () => e.inplan = true,
              ),
              TextButton(
                child: Text('取消收藏'),
                onPressed: () {
                  e.delete();
                  Global.localStore.user.studySentenceSet.remove(e);
                  setState((){});
                },
              ),
            ],
          )
        ).toList();
      case FavoriteType.grammar:
        return Global.localStore.user.studyGrammarSet.map((e) =>
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('${e.grammar}'),
              TextButton(
                child: Text('加入学习计划'),
                onPressed: () => e.inplan = true,
              ),
              TextButton(
                child: Text('取消收藏'),
                onPressed: () {
                  e.delete();
                  Global.localStore.user.studyGrammarSet.remove(e);
                  setState((){});
                },
              ),
            ],
          )
        ).toList();
    }
  }
}
