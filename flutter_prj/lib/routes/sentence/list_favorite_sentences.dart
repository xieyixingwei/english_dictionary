import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/pagination.dart';


class ListFavoriteSentencePage extends StatefulWidget {
  ListFavoriteSentencePage({Key key, this.category}) : super(key:key);
  final String category;

  @override
  _ListFavoriteSentencePageState createState() => _ListFavoriteSentencePageState();
}

class _ListFavoriteSentencePageState extends State<ListFavoriteSentencePage> {
  var _studySentences = StudySentencePaginationSerializer();

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    _studySentences.filter.foreignUser = Global.localStore.user.id;
    _studySentences.filter.categories__icontains = widget.category;
    _studySentences.queryset.page_size = 10;
    _studySentences.queryset.page_index = 1;
    await _studySentences.retrieve();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        title: Text('收藏的(${widget.category})单词'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildListSentences(context),
          ],
        ),
      ),
    );

    Widget _buildListSentences(BuildContext context) =>
    Container(
      padding: EdgeInsets.only(top: 10),
      child: Pagination(
        pages: (_studySentences.count / _studySentences.queryset.page_size).ceil(),
        curPage: _studySentences.queryset.page_index,
        goto: (num index) async {
          _studySentences.queryset.page_index = index;
          bool ret = await _studySentences.retrieve();
          if(ret) setState((){});
        },
        perPage: _studySentences.queryset.page_size,
        perPageSet: [10, 20, 30, 50],
        perPageChange: (v) async {
          _studySentences.queryset.page_index = 1;
          _studySentences.queryset.page_size = v;
          bool ret = await _studySentences.retrieve();
          if(ret) setState((){});
        },
        rows: _studySentences.results.map<Widget>((e) => 
          _studySentenceItem(context, e)
        ).toList(),
      ),
    );

  Widget _studySentenceItem(BuildContext context, StudySentenceSerializer ss) =>
    ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: Text('${ss.sentence.id}', style: TextStyle(color: Colors.black54, fontSize: 17)),
      title: InkWell(
        child: Text(ss.sentence.en, style: TextStyle(color: Colors.black87, fontSize: 17)),
        onTap: () async {
          var s = (await Navigator.pushNamed(context, '/edit_sentence',
                                              arguments: {
                                                'title': '编辑例句',
                                                'sentence': SentenceSerializer().from(ss.sentence)})
                      ) as SentenceSerializer;
          if(s != null) await ss.sentence.from(s).save();
          setState(() {});
        },
      ),
      subtitle: Text('${ss.familiarity} 熟悉度  ${ss.categories.join("/")}', style: TextStyle(color: Colors.black54, fontSize: 12)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            child: Text(ss.inplan ? '取消学习' : '加入学习', style: TextStyle(color: ss.inplan ? Colors.black54 : Colors.blue),),
            onPressed: () async {
              ss.inplan = !ss.inplan;
              await ss.save();
              setState(() {});
            }
          ),
          SizedBox(width: 10,),
          TextButton(
            child: Text('取消收藏'),
            onPressed: () async {
              var ret = await ss.delete();
              if(ret) {
                _studySentences.results.remove(ss);
                setState(() {});
              }
            },
          ),
        ],
      )
    );
}
