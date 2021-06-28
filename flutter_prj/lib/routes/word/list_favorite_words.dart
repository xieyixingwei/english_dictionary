import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/pagination.dart';


class ListFavoriteWordPage extends StatefulWidget {
  ListFavoriteWordPage({Key key, this.category}) : super(key:key);
  final String category;

  @override
  _ListFavoriteWordPageState createState() => _ListFavoriteWordPageState();
}

class _ListFavoriteWordPageState extends State<ListFavoriteWordPage> {
  var _studyWords = StudyWordPaginationSerializer();

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    _studyWords.filter.foreignUser = Global.localStore.user.id;
    _studyWords.filter.categories__icontains = widget.category;
    _studyWords.queryset.page_size = 10;
    _studyWords.queryset.page_index = 1;
    await _studyWords.retrieve();
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
            _buildListWords(context),
          ],
        ),
      ),
    );

    Widget _buildListWords(BuildContext context) =>
    Container(
      padding: EdgeInsets.only(top: 10),
      child: Pagination(
        pages: (_studyWords.count / _studyWords.queryset.page_size).ceil(),
        curPage: _studyWords.queryset.page_index,
        goto: (num index) async {
          _studyWords.queryset.page_index = index;
          bool ret = await _studyWords.retrieve();
          if(ret) setState((){});
        },
        perPage: _studyWords.queryset.page_size,
        perPageSet: [10, 20, 30, 50],
        perPageChange: (v) async {
          _studyWords.queryset.page_index = 1;
          _studyWords.queryset.page_size = v;
          bool ret = await _studyWords.retrieve();
          if(ret) setState((){});
        },
        rows: _studyWords.results.map<Widget>((e) => 
          _studyWordItem(context, e)
        ).toList(),
      ),
    );

  Widget _studyWordItem(BuildContext context, StudyWordSerializer sw) =>
    ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: InkWell(
        child: Text('${sw.id}  ${sw.word.name}', style: TextStyle(color: Colors.black87, fontSize: 17)),
        onTap: () async {
          var w = (await Navigator.pushNamed(context, '/edit_word',
                                              arguments: {
                                                'title': '编辑单词',
                                                'word': WordSerializer().from(sw.word)})
                      ) as WordSerializer;
          if(w != null) await sw.word.from(w).save();
          setState(() {});
        },
      ),
      title: Text('${sw.familiarity} 熟悉度  ${sw.categories.join("/")}', style: TextStyle(color: Colors.black54, fontSize: 12)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            child: Text(sw.inplan ? '取消学习' : '加入学习', style: TextStyle(color: sw.inplan ? Colors.black54 : Colors.blue),),
            onPressed: () async {
              sw.inplan = !sw.inplan;
              await sw.save();
              setState(() {});
            }
          ),
          SizedBox(width: 10,),
          TextButton(
            child: Text('取消收藏'),
            onPressed: () async {
              var ret = await sw.delete();
              if(ret) {
                _studyWords.results.remove(sw);
                setState(() {});
              }
            },
          ),
        ],
      )
    );
}
