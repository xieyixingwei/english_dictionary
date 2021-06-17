import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/routes/word/list_favorite_words.dart';
import 'package:flutter_prj/serializers/index.dart';


class FavoriteWordPage extends StatefulWidget {
  FavoriteWordPage({Key key}) : super(key: key);

  @override
  _FavoriteWordPageState createState() => _FavoriteWordPageState();
}


class _FavoriteWordPageState extends State<FavoriteWordPage> {
  final _studyWords = StudyWordPaginationSerializer();
  final _categoryCount = <String, num>{};

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    await Future.forEach<String>(Global.localStore.user.studyPlan.wordCategory, (e) async {
      _studyWords.filter.foreignUser = Global.localStore.user.id;
      _studyWords.filter.categories__icontains = e;
      var ret = await _studyWords.retrieve();
      if(ret)
        _categoryCount[e] = _studyWords.count;
    });
    setState(() { });
  }

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        title: Text('收藏的单词'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
        child: Center(
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            children: _categoryCount.map((category, count) =>
              MapEntry(
                category,
                _card(context, category, count, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListFavoriteWordPage(category: category,)
                    )
                  );
                }
              )
            )).values.toList()
          ),
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
      child: Center(
        child: InkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(count.toString(), style: TextStyle(fontSize: 17),),
              Text(title, style: TextStyle(fontSize: 17),),
            ]
          ),
          onTap: onPressed,
        ),
      ),
    );
}
