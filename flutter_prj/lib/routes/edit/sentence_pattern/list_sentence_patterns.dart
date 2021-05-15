import 'package:flutter/material.dart';
import 'package:flutter_prj/routes/edit/sentence_pattern/show_sentence_pattern.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/pagination.dart';
import 'package:flutter_prj/widgets/edit_delete.dart';


class ListSentencePatterns extends StatefulWidget {

  @override
  _ListSentencePatternsState createState() => _ListSentencePatternsState();
}

class _ListSentencePatternsState extends State<ListSentencePatterns> {
  SentencePatternPaginationSerializer _sentencePatterns = SentencePatternPaginationSerializer();
  final textStyle = const TextStyle(fontSize: 12,);
  num _perPage = 10;
  num _pageIndex = 1;

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    await _sentencePatterns.retrieve(queries:{'page_size':_perPage, 'page_index':_pageIndex});
    setState((){});
  }

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        title: Text('编辑常用句型'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(6, 20, 6, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilter(context),
            _buildListSentencePatterns(context),
          ],
        ),
      ),
    );

  Widget _buildFilterOptions(BuildContext context) =>
    Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 10,
      children: [
        SizedBox(width: 2,),
        TextButton(
          child: Text('添加常用句型', style: TextStyle(fontSize: 12)),
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

            
  Widget _buildFilter(BuildContext context) =>
    Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            maxLines: 1,
            style: TextStyle(fontSize: 14,),
            onChanged: (v) => {},
            decoration: InputDecoration(
              hintText: '关键字',
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                splashRadius: 1.0,
                tooltip: '搜索',
                icon: Icon(Icons.search),
                onPressed: () async {
                  await _sentencePatterns.retrieve(queries:{"page_size": 10, "page_index":1});
                  setState((){});
                },
              ),
            ),
          ),
          _buildFilterOptions(context),
        ],
      ),
    );

  Widget _buildListSentencePatterns(BuildContext context) =>
    Container(
      padding: EdgeInsets.only(top: 10),
      child: Pagination(
        pages: (_sentencePatterns.count / _perPage).ceil(),
        curPage: _pageIndex,
        goto: (num index) async {
          _pageIndex = index;
          bool ret = await _sentencePatterns.retrieve(queries:{'page_size':_perPage, 'page_index':_pageIndex});
          if(ret) setState((){});
        },
        perPage: _perPage,
        perPageSet: [10, 20, 30, 50],
        perPageChange: (v) async {
          _pageIndex = 1;
          _perPage = v;
          bool ret = await _sentencePatterns.retrieve(queries:{'page_size':_perPage, 'page_index':_pageIndex});
          if(ret) setState((){});
        },
        rows: _sentencePatterns.results.map<Widget>((e) => 
          sentencePattrenItem(
            context: context,
            sp: e,
            trailing: EditDelete(
              edit: () async {
                var sentencePattern = (await Navigator.pushNamed(
                  context, '/edit_sentence_pattern',
                  arguments:{'title':'编辑常用句型','sentence_pattern': SentencePatternSerializer().from(e)})
                ) as SentencePatternSerializer;
                if(sentencePattern != null) e.from(sentencePattern).save();
                setState(() {});
              },
              delete: () {
                e.delete();
                _sentencePatterns.results.remove(e);
                setState(() {});
              },
            ),
          )
        ).toList(),
      ),
    );
}
