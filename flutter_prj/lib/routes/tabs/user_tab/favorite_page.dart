import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/routes/sentence/favorite_sentences.dart';
import 'package:flutter_prj/routes/sentence_pattern/favorite_sentence_pattern.dart';
import 'package:flutter_prj/routes/word/favorite_words.dart';
import 'package:flutter_prj/serializers/index.dart';


class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  var _studyWordPagination = StudyWordPaginationSerializer();
  var _studySentencePagination = StudySentencePaginationSerializer();
  var _studySentencePatternPagination = StudySentencePatternPaginationSerializer();

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    _studyWordPagination.filter.foreignUser = Global.localStore.user.id;
    _studySentencePagination.filter.foreignUser = Global.localStore.user.id;
    _studySentencePatternPagination.filter.foreignUser = Global.localStore.user.id;
    await _studyWordPagination.retrieve();
    await _studySentencePagination.retrieve();
    await _studySentencePatternPagination.retrieve();
    setState(() {});
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
            _card(context, '收藏的单词', _studyWordPagination.count, () =>
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteWordPage(),
                )
              )
            ),
            _card(context, '收藏的词义辨析', Global.localStore.user.studyPlan == null ? 0 : Global.localStore.user.studyPlan.distinguishes.length,
              () {}),
            _card(context, '收藏的句子', _studySentencePagination.count, () =>
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteSentencePage(),
                )
              )
            ),
            _card(context, '收藏的固定表达', _studySentencePatternPagination.count, () =>
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteSentencePatternPage(),
                )
              )
            ),
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
