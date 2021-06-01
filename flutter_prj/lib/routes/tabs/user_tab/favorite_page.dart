import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/serializers/index.dart';


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
            _card(context, '收藏的单词', Global.localStore.user.studyWordSet.length,
              () => Navigator.pushNamed(context, '/list_favorite_page', arguments: {'type': FavoriteType.word})),
            _card(context, '收藏的词义辨析', Global.localStore.user.studyPlan == null ? 0 : Global.localStore.user.studyPlan.distinguishes.length,
              () => Navigator.pushNamed(context, '/list_favorite_page', arguments: {'type': FavoriteType.distinguish})),
            _card(context, '收藏的句子', Global.localStore.user.studySentenceSet.length,
              () async {
                await Future.forEach<StudySentenceSerializer>(Global.localStore.user.studySentenceSet, (e) async {
                  if(e.sentenceObj != null) return;
                  e.sentenceObj = SentenceSerializer()..id = e.sentence;
                  await e.sentenceObj.retrieve();
                });
                Navigator.pushNamed(context, '/list_favorite_page', arguments: {'type': FavoriteType.sentence});
              }
            ),
            _card(context, '收藏的固定表达', Global.localStore.user.studyGrammarSet.length,
              ()=>Navigator.pushNamed(context, '/list_favorite_page', arguments: {'type': FavoriteType.sentencePattern})),
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

enum FavoriteType { word, distinguish, sentence, sentencePattern} 

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
      case FavoriteType.sentencePattern:
        _title = '收藏的固定表达';
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _children(),
        ),
      ),
    );

  List<Widget> _children() {
    switch(widget.type) {
      case FavoriteType.word:
        return Global.localStore.user.studyWordSet.map((e) =>
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: InkWell(
              child: Text(e.word, style: TextStyle(color: Colors.black87, fontSize: 17)),
              onTap: () async {
                if(e.wordObj == null) {
                  e.wordObj = WordSerializer()..name = e.word;
                  await e.wordObj.retrieve();
                }
                var word = (await Navigator.pushNamed(
                  context, '/edit_word',
                  arguments: {'title':'编辑单词','word':WordSerializer().from(e.wordObj)})
                ) as WordSerializer;
                if(word != null) await e.wordObj.from(word).save();
                setState(() {});
              },
            ),
            title: Text('${e.familiarity} 熟悉度', style: TextStyle(color: Colors.black54, fontSize: 12)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  child: Text(e.inplan ? '取消学习' : '加入学习', style: TextStyle(color: e.inplan ? Colors.black54 : Colors.blue),),
                  onPressed: () async {
                    e.inplan = !e.inplan;
                    await e.save();
                    Global.saveLocalStore();
                    setState(() {});
                  }
                ),
                SizedBox(width: 10,),
                TextButton(
                  child: Text('取消收藏'),
                  onPressed: () async {
                    var ret = await e.delete();
                    if(ret) {
                      Global.localStore.user.studyWordSet.remove(e);
                      Global.saveLocalStore();
                      setState(() {});
                    }
                  },
                ),
              ],
            )
          )
        ).toList();
      case FavoriteType.distinguish:
        return Global.localStore.user.studyPlan.distinguishes.map((e) =>
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: Text(e.toString(), style: TextStyle(color: Colors.black87, fontSize: 17)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  child: Text('取消收藏'),
                  onPressed: () async {
                      Global.localStore.user.studyPlan.distinguishes.remove(e);
                      await Global.localStore.user.studyPlan.save();
                      Global.saveLocalStore();
                      setState(() {});
                  },
                ),
              ],
            )
          )
        ).toList();
      case FavoriteType.sentence:
        return Global.localStore.user.studySentenceSet.map((e) =>
         ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: Text(e.id.toString()),
            title: Text(e.sentenceObj.en),
            subtitle: Text(e.sentenceObj.cn),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  child: Text(e.inplan ? '取消学习' : '加入学习', style: TextStyle(color: e.inplan ? Colors.black54 : Colors.blueAccent),),
                  onPressed: () async {
                    e.inplan = !e.inplan;
                    await e.save();
                    Global.saveLocalStore();
                    setState(() {});
                  }
                ),
                SizedBox(width: 10,),
                TextButton(
                  child: Text('取消收藏'),
                  onPressed: () async {
                    var ret = await e.delete();
                    if(ret) {
                      Global.localStore.user.studySentenceSet.remove(e);
                      Global.saveLocalStore();
                      setState(() {});
                    }
                  },
                ),
              ],
            )
          )
        ).toList();
      case FavoriteType.sentencePattern:
        return null;
    }
  }
}
