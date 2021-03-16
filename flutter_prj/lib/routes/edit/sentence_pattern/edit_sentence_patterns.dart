import 'package:flutter/material.dart';
import 'package:flutter_prj/routes/edit/sentence_pattern/show_sentence_pattern.dart';
import 'package:flutter_prj/serializers/index.dart';


class EditSentencePatterns extends StatefulWidget {

  @override
  _EditSentencePatternsState createState() => _EditSentencePatternsState();
}

class _EditSentencePatternsState extends State<EditSentencePatterns> {
  SentencePatternPaginationSerializer _sentencePatterns = SentencePatternPaginationSerializer();

  @override
  void initState() { 
    super.initState();
    _init();
  }

  _init() async {
    await _sentencePatterns.retrieve();
    setState((){});
  }

Widget _buildFilter(BuildContext context) =>
  Wrap(
    spacing: 10.0,
    children: [
      IconButton(
        splashRadius: 1.0,
        tooltip: '搜索',
        icon: Icon(Icons.search),
        onPressed: () async {
          await _sentencePatterns.retrieve(queries:{"page_size": 10, "page_index":1});
          setState((){});
        },
      ),
      IconButton(
        splashRadius: 1.0,
        icon: Icon(Icons.add),
        tooltip: '添加常用句型',
        onPressed: () async {
          var sp = (await Navigator.pushNamed(context, '/edit_sentence_pattern', arguments:{'title':'添加常用句型'})) as SentencePatternSerializer;
          if(sp != null) {
            _sentencePatterns.results.add(sp);
            await sp.save();
          }
          setState((){});
        },
      ),
    ],
  );


  Widget _buildListSentencePatterns(BuildContext context) =>
    Expanded(
      child: ListView(
        children: _sentencePatterns.results.map<Widget>(
          (e) => ShowSentencePattern(
            sentencePattern: e,
            delete: () {e.delete(); setState(()=>_sentencePatterns.results.remove(e));},
          )
        ).toList(),
      )
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
                appBar: AppBar(
                  title: Text('编辑常用句型'),
                ),
                body: Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFilter(context),
                        SizedBox(height: 20,),
                        _buildListSentencePatterns(context),
                      ],
                    ),
                  ),
                );
  }
}




