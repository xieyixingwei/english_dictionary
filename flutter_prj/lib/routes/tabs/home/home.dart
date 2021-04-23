import 'package:flutter/material.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/RatingStar.dart';
import 'package:flutter_prj/widgets/column_space.dart';
import 'package:flutter_prj/widgets/container_outline.dart';
import 'package:flutter_prj/widgets/row_space.dart';


class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final WordSerializer _word = WordSerializer()..name = 'dense';
  final Color _colorA = Color.fromRGBO(47,184,203,1.0);
  final Color _colorB = Color.fromRGBO(132,132,132,1.0);
  bool _paraphraseOnOff = true;
  bool _sentencePatternOnOff = true;

  @override
    void initState() {
      _init();
      super.initState();
    }
  
  void _init() async {
    await _word.retrieve();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          children:[
            //_header,
            Container(
              padding: EdgeInsets.fromLTRB(40, 20, 40, 10),
              child: _search,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(40, 10, 20, 10),
              child: _wordShow,
            ),
          ],
        ),
      ),
    );

  Widget get _header =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "会说英语",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10,),
        Text(
          "让英语学习更高效",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );

  Widget get _search =>
    TextField(
      maxLines: 1,
      style: TextStyle(
        fontSize: 16,
      ),
      onChanged: (v) => _word.name = v.trim(),
      decoration: InputDecoration(
        hintText: "输入单词或句子",
        border: OutlineInputBorder(),
        suffixIcon: IconButton(
          splashRadius: 1.0,
          iconSize: 28,
          tooltip: '搜索',
          icon: Icon(Icons.search),
          onPressed: () async {
            if(_word.name.trim().isEmpty) return;
            await _word.retrieve();
            setState(() {});
          },
        ),
      ),
    );


  Widget get _wordShow => _word.name.isNotEmpty ?
    ColumnSpace(
      crossAxisAlignment: CrossAxisAlignment.start,
      divider: SizedBox(height: 10,),
      children: [
        _wordNameShow,
        RowSpace(
          divider: SizedBox(width: 10,),
          children: [
            _voiceUsShow,
            _voiceUkShow,
          ],
        ),
        _tagShow,
        _etymaShow,
        _morphShow,
        _originShow,
        _shorthandShow,
        _paraphraseSetShow,
        _sentencePatternSetShow,
      ],
    ) : null;

  Widget get _wordNameShow => _word.name.isNotEmpty ?
    Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SelectableText(
          _word.name,
          style: TextStyle(
            color: Color.fromRGBO(0,153,68,1),
            fontWeight: FontWeight.w700,
            fontSize: 28,
            height: 1,
          ),
        ),
        IconButton(
          icon: Icon(Icons.assignment, color: Color.fromRGBO(42,165,183,1)),
          tooltip: '添加到单词本',
          splashRadius: 1,
          onPressed: () => print("添加到单词本"),
        ),
        ratingStar(3.3,5),
      ],
    ) : null;

  Widget get _voiceUsShow => _word.voiceUs.isNotEmpty ?
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SelectableText(
          '美 ${_word.voiceUs}',
          style: TextStyle(fontSize: 12, color: _colorB, height: 1,),
        ),
        SizedBox(width: 6,),
        InkWell(
          child: Icon(Icons.volume_up_outlined, color: Color.fromRGBO(50,169,186,1), size: 20,),
          onTap: () => print("发音"),
        ),
      ]
    ) : null;

  Widget get _voiceUkShow => _word.voiceUk.isNotEmpty ?
    Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SelectableText(
          '英 ${_word.voiceUk}',
          style: TextStyle(fontSize: 12, color: _colorB, height: 1,),
        ),
        SizedBox(width: 6,),
        InkWell(
          child: Icon(Icons.volume_up_outlined, color: Color.fromRGBO(50,169,186,1), size: 20,),
          onTap: () => print("发音"),
        ),
      ]
    ) : null;

  Widget get _tagShow => _word.tag.isNotEmpty ?
    Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SelectableText(
          'Tags: ',
          style: TextStyle(
            fontSize: 12,
            color: Color.fromRGBO(50,169,186,1),
            //fontWeight: FontWeight.bold
            height: 1,
          ),
        ),
        SelectableText(
          _word.tag.join(', '),
          style: TextStyle(
            fontSize: 12,
            color: _colorB,
            height: 1,
            fontWeight: FontWeight.bold,
          ),
        )
      ]
    ) : null;

  Widget get _etymaShow => _word.etyma.isNotEmpty ?
    Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SelectableText(
          '词根词缀: ',
          style: TextStyle(
            fontSize: 12,
            color: Color.fromRGBO(50,169,186,1),
            height: 1,
          ),
        ),
        SelectableText(
          _word.etyma.join(', '),
          style: TextStyle(
            fontSize: 12,
            color: _colorB,
            height: 1,
          ),
        )
      ],
    ): null;

  Widget get _morphShow => _word.morph.isNotEmpty ?
    Wrap(
      spacing: 8.0,
      runSpacing: 6.0,
      children: <Widget>[
        SelectableText(
          '单词变形:',
          style: TextStyle(
            fontSize: 12,
            color: Color.fromRGBO(50,169,186,1),
            height: 1,
          ),
        ),
        Wrap(
          spacing: 8.0,
          runSpacing: 6.0,
          children: _word.morph.map<Widget>((e) =>
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SelectableText(
                  e.split(' ').first,
                  style: TextStyle(
                    fontSize: 12,
                    color: _colorB,
                    height: 1,
                  ),
                ),
                InkWell(
                  child: Text(
                    e.split(' ').last,
                    style: TextStyle(
                      fontSize: 12,
                      color: _colorB,
                      height: 1,
                    ),
                  ),
                  onTap: () async {
                    var w = WordSerializer()..name = e.split(' ').last;
                    bool ret = await w.retrieve();
                    if(ret) _word.from(w);
                    setState(() {});
                  },
                ),
              ],
            )
          ).toList(),
        )
      ],
    ): null;

  Widget get _originShow => _word.origin.isNotEmpty ?
    ContainerOutline(
      decoration: InputDecoration(
        prefixText: '词源: ',
        prefixStyle: TextStyle(fontSize: 12, color: _colorA,),
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: InputBorder.none, //去掉下划线
      ),
      child: SelectableText(
        _word.origin,
        style: TextStyle(
          fontSize: 12,
          color: _colorB,
          height: 1,
        ),
      ),
    ) : null;

  Widget get _shorthandShow => _word.shorthand.isNotEmpty ?
    ContainerOutline(
      decoration: InputDecoration(
        prefixText: '速记: ',
        prefixStyle: TextStyle(fontSize: 12, color: _colorA,),
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: InputBorder.none, //去掉下划线
      ),
      child: SelectableText(
        _word.shorthand,
        style: TextStyle(
          fontSize: 12,
          color: _colorB,
          height: 1,
        ),
      ),
    ) : null;

  Widget get _paraphraseSetShow => _word.paraphraseSet.isNotEmpty ?
    Container(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '释义:',
                style: TextStyle(fontSize: 12, color: _colorA,),
              ),
              InkWell(
                radius: 1.0,
                child: Icon(_paraphraseOnOff ? Icons.arrow_right : Icons.arrow_drop_down, color: Color.fromRGBO(34, 154, 172, 1.0),),
                onTap: () => setState(() => _paraphraseOnOff = !_paraphraseOnOff),
              )
            ],
          ),
          Offstage(
            offstage: _paraphraseOnOff,
            child: Container(
              margin: EdgeInsets.fromLTRB(28, 8, 0, 12),
              child: _paraphraseListShow(_word.paraphraseSet),
            ),
          )
        ],
      ),
    ) : null;

  Widget _paraphraseListShow(List<ParaphraseSerializer> paraphraseSet) =>
    Column(
      children: sortParaphraseSet(paraphraseSet).map((e) =>
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              e.keys.first,
              style: TextStyle(fontSize: 12, color: Color.fromRGBO(0,153,68,1), fontWeight: FontWeight.bold),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(12, 8, 0, 0),
              child: ColumnSpace(
                divider: SizedBox(height: 8,),
                children: e.values.first.asMap().map((i, v) =>
                  MapEntry(i, _paraphraseShow(i+1, v))
                ).values.toList(),
              )
            ),
          ]
        )
      ).toList(),
    );

Widget _paraphraseShow(int index, ParaphraseSerializer paraphrase) =>
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SelectableText(
            '$index. ',
            style: TextStyle(fontSize: 12, color: _colorB, fontWeight: FontWeight.bold, height: 1),
          ),
          SelectableText(
            paraphrase.interpret,
            style: TextStyle(fontSize: 12, color: _colorB, fontWeight: FontWeight.bold, height: 1),
          ),
        ].where((e) => e != null).toList(),
      ),
      paraphrase.sentenceSet.isNotEmpty ? 
      Container(
        padding: EdgeInsets.only(left: 16, top: 8),
        child: _sentenceSetShow(paraphrase.sentenceSet),
      ) : null,
    ].where((e) => e != null).toList(),
  );

  Widget _sentenceSetShow(List<SentenceSerializer> sentenceSet) =>
    ColumnSpace(
      crossAxisAlignment: CrossAxisAlignment.start,
      divider: SizedBox(height: 8,),
      children: sentenceSet.map((e) => _sentenceShow(e)).toList(),
    );

  Widget _sentenceShow(SentenceSerializer sentence) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(
          sentence.en,
          style: TextStyle(fontSize: 12, color: _colorB,),
        ),
        SelectableText(
          sentence.cn,
          style: TextStyle(fontSize: 12, color: _colorB,),
        ),
      ]
    );

  List<Map<String, List<ParaphraseSerializer>>> sortParaphraseSet(List<ParaphraseSerializer> paraphrases) {
    List<Map<String, List<ParaphraseSerializer>>> ret = [];
    paraphrases.forEach( (e) {
      var find = ret.singleWhere((ele) => ele.keys.first == e.partOfSpeech, orElse: () => null);
      find == null
            ? ret.add({e.partOfSpeech: [e]})
            : find.values.first.add(e);
    });
    return ret;
  }

  Widget get _sentencePatternSetShow => _word.sentencePatternSet.isNotEmpty ?
    Container(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '常用句型:',
                style: TextStyle(fontSize: 12, color: _colorA,),
              ),
              InkWell(
                radius: 1.0,
                child: Icon(_sentencePatternOnOff ? Icons.arrow_right : Icons.arrow_drop_down, color: Color.fromRGBO(34, 154, 172, 1.0),),
                onTap: () => setState(() => _sentencePatternOnOff = !_sentencePatternOnOff),
              )
            ],
          ),
          Offstage(
            offstage: _sentencePatternOnOff,
            child: Container(
              margin: EdgeInsets.fromLTRB(28, 8, 0, 12),
              child: ColumnSpace(
                divider: SizedBox(height: 8,),
                children: _word.sentencePatternSet.asMap().map((i, e) =>
                  MapEntry(i, _sentencePatternShow(i+1, e))
                ).values.toList(),
              ),
            ),
          )
        ],
      ),
    ) : null;

  Widget _sentencePatternShow(num index, SentencePatternSerializer sp) =>
    Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SelectableText(
            '$index. ',
            style: TextStyle(fontSize: 12, color: _colorB, fontWeight: FontWeight.bold, height: 1),
          ),
          SelectableText(
            sp.content,
            style: TextStyle(fontSize: 12, color: _colorB, fontWeight: FontWeight.bold, height: 1),
          ),
        ].where((e) => e != null).toList(),
      ),
      sp.paraphraseSet.isNotEmpty ?
      Container(
        padding: EdgeInsets.only(left: 16, top: 8),
        child: _paraphraseListShow(sp.paraphraseSet),
      ) : null,
    ].where((e) => e != null).toList(),
  );

}
