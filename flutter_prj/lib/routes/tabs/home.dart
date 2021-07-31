import 'package:flutter/material.dart';
import 'package:flutter_prj/routes/common/utils.dart';
import 'package:flutter_prj/routes/sentence_pattern/show_sentence_pattern.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/column_space.dart';


class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _style1 = TextStyle(fontSize: 17, color: Colors.blueAccent);
  String _target = '';
  final wordPagen = WordPaginationSerializer();
  final distinguishPagen = DistinguishPaginationSerializer();
  final sentencePatternPagen = SentencePatternPaginationSerializer();
  final sentencePagen = SentencePaginationSerializer();
  final paraphrasePagen = ParaphrasePaginationSerializer();

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Container(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: _search,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 30, 0, 10),
              child: ColumnSpace(
                crossAxisAlignment: CrossAxisAlignment.start,
                divider: SizedBox(height: 7,),
                children: _wordResult + _distinguishResult + _sentencePatternResult + _sentenceResult,
              ),
            ),
          ],
        ),
      ),
    );

  Widget get _search =>
    TextField(
      maxLines: 1,
      style: TextStyle(
        fontSize: 16,
      ),
      onChanged: (v) => _target = v.trim(),
      decoration: InputDecoration(
        hintText: "输入单词或句子",
        border: OutlineInputBorder(),
        suffixIcon: IconButton(
          splashRadius: 1.0,
          iconSize: 28,
          tooltip: '搜索',
          icon: Icon(Icons.search),
          onPressed: () async {
            if(_target.isEmpty) return;
            _clear();
            if(strType(_target) == StringType.english) {
              wordPagen.filter.name__icontains = _target;
              wordPagen.queryset.page_size = 20;
              await wordPagen.retrieve();

              //distinguishes.filter.wordsForeign__icontains = _target;
              //await distinguishes.retrieve(queries:{'page_size': 20, 'page_index': 1});

              sentencePatternPagen.filter.content__icontains = _target;
              sentencePatternPagen.queryset.page_size = 20;
              await sentencePatternPagen.retrieve();

              sentencePagen.filter.en__icontains = _target;
              sentencePagen.queryset.page_size = 20;
              await sentencePagen.retrieve();
            }
            else if(strType(_target) == StringType.chinese) {
              paraphrasePagen.filter.interpret__icontains = _target;
              paraphrasePagen.queryset.page_size = 20;
              await paraphrasePagen.retrieve();

              await Future.forEach<ParaphraseSerializer>(paraphrasePagen.results, (e) async {
                if(e.wordForeign != null && e.wordForeign.isNotEmpty
                  && (null == wordPagen.results.firstWhere((r) => r.name == e.wordForeign, orElse: ()=>null))) {
                  var w = WordSerializer()..name = e.wordForeign;
                  await w.retrieve();
                  wordPagen.results.add(w);
                }
                if(e.sentencePatternForeign != null && e.sentencePatternForeign > 0) {
                  var sp = SentencePatternSerializer()..id = e.sentencePatternForeign;
                  await sp.retrieve();
                  sentencePatternPagen.results.add(sp);
                }
              });

              sentencePagen.filter.cn__icontains = _target;
              sentencePagen.queryset.page_size = 20;
              await sentencePagen.retrieve(queries:{'page_size': 20, 'page_index': 1});
            }
            setState(() {});
          },
        ),
      ),
    );

  void _clear() {
    wordPagen.results.clear();
    distinguishPagen.results.clear();
    sentencePatternPagen.results.clear();
    sentencePagen.results.clear();
    paraphrasePagen.results.clear();
  }

  List<Widget> get _wordResult =>
    wordPagen.results.map<Widget>((e) =>
      InkWell(
        child: Text(e.name, style: _style1,),
        onTap: () => Navigator.pushNamed(context, '/show_word', arguments: {'title': '', 'word': e}),
      )
    ).toList();

  List<Widget> get _distinguishResult =>
    distinguishPagen.results.map<Widget>((e) =>
      InkWell(
        child: Text('词义辨析: ${e.wordsForeign.join(", ")}', style: _style1,),
        onTap: () => Navigator.pushNamed(context, '/show_distinguish', arguments: {'title': '词义辨析', 'distinguish': e}),
      )
    ).toList();
  
  List<Widget> get _sentencePatternResult =>
    sentencePatternPagen.results.map<Widget>((e) =>
      InkWell(
        child: Text(e.content, style: _style1,),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ShowSentencePatternPage(title: '固定表达', sentencePattern: e,),
          )
        ),
      )
    ).toList();
  
  List<Widget> get _sentenceResult {
    var excludeIds = [];
    wordPagen.results.forEach((e) =>
      e.paraphraseSet.forEach((p) {
        excludeIds.addAll(p.sentenceSet.map((s) => s.id).toList());
      })
    );
    return sentencePagen.results.where((e) => !excludeIds.contains(e.id)).map<Widget>((e) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(e.en, style: TextStyle(fontSize: 17, color: Colors.black87),),
          Text(e.cn, style: TextStyle(fontSize: 14, color: Colors.black45),),
        ],
      )
    ).toList();
  }
}
