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
  final words = WordPaginationSerializer();
  final distinguishes = DistinguishPaginationSerializer();
  final sentencePatterns = SentencePatternPaginationSerializer();
  final sentences = SentencePaginationSerializer();
  final paraphrases = ParaphrasePaginationSerializer();

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
              words.filter.name__icontains = _target;
              await words.retrieve(queries:{'page_size': 20, 'page_index': 1});
              //distinguishes.filter.wordsForeign__icontains = _target;
              //await distinguishes.retrieve(queries:{'page_size': 20, 'page_index': 1});
              sentencePatterns.filter.content__icontains = _target;
              await sentencePatterns.retrieve(queries:{'page_size': 20, 'page_index': 1});
              sentences.filter.en__icontains = _target;
              await sentences.retrieve(queries:{'page_size': 20, 'page_index': 1});
            }
            else if(strType(_target) == StringType.chinese) {
              paraphrases.filter.interpret__icontains = _target;
              await paraphrases.retrieve(queries:{'page_size': 20, 'page_index': 1});

              await Future.forEach<ParaphraseSerializer>(paraphrases.results, (e) async {
                if(e.wordForeign != null && e.wordForeign.isNotEmpty
                  && (null == words.results.firstWhere((r) => r.name == e.wordForeign, orElse: ()=>null))) {
                  var w = WordSerializer()..name = e.wordForeign;
                  await w.retrieve();
                  words.results.add(w);
                }
                if(e.sentencePatternForeign != null && e.sentencePatternForeign > 0) {
                  var sp = SentencePatternSerializer()..id = e.sentencePatternForeign;
                  await sp.retrieve();
                  sentencePatterns.results.add(sp);
                }
              });

              sentences.filter.cn__icontains = _target;
              await sentences.retrieve(queries:{'page_size': 20, 'page_index': 1});
            }
            setState(() {});
          },
        ),
      ),
    );

  void _clear() {
    words.results.clear();
    distinguishes.results.clear();
    sentencePatterns.results.clear();
    sentences.results.clear();
    paraphrases.results.clear();
  }

  List<Widget> get _wordResult =>
    words.results.map<Widget>((e) =>
      InkWell(
        child: Text(e.name, style: _style1,),
        onTap: () => Navigator.pushNamed(context, '/show_word', arguments: {'title': '', 'word': e}),
      )
    ).toList();

  List<Widget> get _distinguishResult =>
    distinguishes.results.map<Widget>((e) =>
      InkWell(
        child: Text('词义辨析: ${e.wordsForeign.join(", ")}', style: _style1,),
        onTap: () => Navigator.pushNamed(context, '/show_distinguish', arguments: {'title': '词义辨析', 'distinguish': e}),
      )
    ).toList();
  
  List<Widget> get _sentencePatternResult =>
    sentencePatterns.results.map<Widget>((e) =>
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
    words.results.forEach((e) =>
      e.paraphraseSet.forEach((p) {
        excludeIds.addAll(p.sentenceSet.map((s) => s.id).toList());
      })
    );
    return sentences.results.where((e) => !excludeIds.contains(e.id)).map<Widget>((e) =>
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
