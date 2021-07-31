import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/pagination.dart';


class ListFavoriteSentencePatternPage extends StatefulWidget {
  ListFavoriteSentencePatternPage({Key key, this.category}) : super(key:key);
  final String category;

  @override
  _ListFavoriteSentencePatternPageState createState() => _ListFavoriteSentencePatternPageState();
}

class _ListFavoriteSentencePatternPageState extends State<ListFavoriteSentencePatternPage> {
  var _studySentencePatterns = StudySentencePatternPaginationSerializer();

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    _studySentencePatterns.filter.foreignUser = Global.localStore.user.id;
    _studySentencePatterns.filter.categories__icontains = widget.category;
    _studySentencePatterns.queryset.page_size = 10;
    _studySentencePatterns.queryset.page_index = 1;
    await _studySentencePatterns.retrieve();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        title: Text('收藏的(${widget.category})固定表达'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildListWords(context),
          ],
        ),
      ),
    );

    Widget _buildListWords(BuildContext context) =>
    Container(
      padding: EdgeInsets.only(top: 10),
      child: Pagination(
        pages: (_studySentencePatterns.count / _studySentencePatterns.queryset.page_size).ceil(),
        curPage: _studySentencePatterns.queryset.page_index,
        goto: (num index) async {
          _studySentencePatterns.queryset.page_index = index;
          bool ret = await _studySentencePatterns.retrieve();
          if(ret) setState((){});
        },
        perPage: _studySentencePatterns.queryset.page_size,
        perPageSet: [10, 20, 30, 50],
        perPageChange: (v) async {
          _studySentencePatterns.queryset.page_index = 1;
          _studySentencePatterns.queryset.page_size = v;
          bool ret = await _studySentencePatterns.retrieve();
          if(ret) setState((){});
        },
        rows: _studySentencePatterns.results.map<Widget>((e) => 
          _studySentencePatternItem(context, e)
        ).toList(),
      ),
    );

  Widget _studySentencePatternItem(BuildContext context, StudySentencePatternSerializer ssp) =>
    ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: Text('${ssp.sentencePattern.id}', style: TextStyle(color: Colors.black54, fontSize: 17)),
      title: InkWell(
        child: Text('${ssp.sentencePattern.content}', style: TextStyle(color: Colors.black87, fontSize: 17)),
        onTap: () async {
          var sp = (await Navigator.pushNamed(context,
                                                  '/edit_sentence_pattern',
                                                  arguments: {'title':'编辑固定表达',
                                                  'sentence_pattern': SentencePatternSerializer().from(ssp.sentencePattern)})
                        ) as SentencePatternSerializer;
          if(sp != null) await ssp.sentencePattern.from(sp).save();
          setState(() {});
        },
      ),
      subtitle: Text('${ssp.familiarity} 熟悉度  ${ssp.categories.join("/")}', style: TextStyle(color: Colors.black54, fontSize: 12)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            child: Text(ssp.inplan ? '取消学习' : '加入学习', style: TextStyle(color: ssp.inplan ? Colors.black54 : Colors.blue),),
            onPressed: () async {
              ssp.inplan = !ssp.inplan;
              await ssp.save();
              setState(() {});
            }
          ),
          SizedBox(width: 10,),
          TextButton(
            child: Text('取消收藏'),
            onPressed: () async {
              var ret = await ssp.delete();
              if(ret) _studySentencePatterns.results.remove(ssp);
              setState(() {});
            },
          ),
        ],
      )
    );
}
