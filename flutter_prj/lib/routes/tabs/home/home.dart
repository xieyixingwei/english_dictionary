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
  final WordSerializer _word = WordSerializer();
  final Color _colorA = Color.fromRGBO(47,184,203,1.0);
  final Color _colorB = Color.fromRGBO(132,132,132,1.0);
  List<bool> _offstage = [true, true, true, true, true];

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
        fontSize: 14,
      ),
      onChanged: (v) => _word.name = v.trim(),
      decoration: InputDecoration(
        hintText: "输入单词或句子",
        border: OutlineInputBorder(),
        suffixIcon: IconButton(
          iconSize: 38,
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


  Widget get _wordNameShow => _word.name.isNotEmpty ?
    Row(
      children: [
        Text(
          _word.name,
          style: TextStyle(
            color: Color.fromRGBO(0,153,68,1),
            fontWeight: FontWeight.w700,
            fontSize: 28
          ),
        ),
        IconButton(
          icon: Icon(Icons.assignment, color: Color.fromRGBO(42,165,183,1),),
          tooltip: '添加到单词本',
          splashRadius: 1,
          onPressed: () => print("添加到单词本"),
        ),
        ratingStar(3.3,5),
      ],
    ) : null;

  Widget get _voiceUsShow => _word.voiceUs.isNotEmpty ?
    Text(
      '美 ${_word.voiceUs}',
      style: TextStyle(fontSize: 12, color: _colorB,),
    ) : null;

  Widget get _voiceUkShow => _word.voiceUk.isNotEmpty ?
    Text(
      '英 ${_word.voiceUk}',
      style: TextStyle(fontSize: 12, color: _colorB,),
    ) : null;

  Widget get _tagShow => _word.tag.isNotEmpty ?
    Text(
      _word.tag.join(', '),
      style: TextStyle(
        fontSize: 12,
        color: Color.fromRGBO(230,150,80,1.0),
      ),
    ) : null;

  Widget get _etymaShow => _word.etyma.isNotEmpty ?
    Text(
      '词根词缀: ${_word.etyma.join(', ')}',
      style: TextStyle(
        fontSize: 12,
        color: Color.fromRGBO(230,150,80,1.0),
      ),
    ) : null;

  Widget get _morphShow => _word.morph.isNotEmpty ?
    Text(
      _word.morph.join(', '),
      style: TextStyle(fontSize: 12, color: _colorB),
    ) : null;

  Widget get _originShow => _word.origin.isNotEmpty ?
    ContainerOutline(
      decoration: InputDecoration(
        prefixText: '词源:',
        prefixStyle: TextStyle(fontSize: 12, color: _colorA,),
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: InputBorder.none, //去掉下划线
      ),
      child: Text(
        _word.origin,
        style: TextStyle(
          fontSize: 12,
          color: _colorB,
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
      child: Text(
        _word.shorthand,
        style: TextStyle(
          fontSize: 12,
          color: _colorB,
        ),
      ),
    ) : null;

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

  Widget _sentenceShow(SentenceSerializer sentence) =>
    ColumnSpace(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sentence.en,
          style: TextStyle(fontSize: 12, color: _colorB,),
        ),
        Text(
          sentence.cn,
          style: TextStyle(fontSize: 12, color: _colorB,),
        ),
      ]
    );


  Widget _paraphraseShow(int index, ParaphraseSerializer paraphrase) =>
    ColumnSpace(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RowSpace(
          crossAxisAlignment: CrossAxisAlignment.end,
          divider: SizedBox(width: 2),
          children: [
            Text(
              '$index. ',
              style: TextStyle(fontSize: 12, color: _colorB, fontWeight: FontWeight.bold),
            ),
            Text(
              paraphrase.interpret,
              style: TextStyle(fontSize: 12, color: _colorB,),
            ),
            paraphrase.sentenceSet.isNotEmpty ? InkWell(
              child: Icon(_offstage[index] ? Icons.arrow_right : Icons.arrow_drop_down, color: Color.fromRGBO(34, 154, 172, 1.0),),
              onTap: () => setState(() => _offstage[index] = !_offstage[index]),
            ) : null,
          ],
        ),
        paraphrase.sentenceSet.isNotEmpty ? Offstage(
          offstage: _offstage[index],
          child: Container(
            padding: EdgeInsets.only(left: 10),
            child: ColumnSpace(
              crossAxisAlignment: CrossAxisAlignment.start,
              divider: _offstage[index] ? null : SizedBox(height: 8),
              children: paraphrase.sentenceSet.map( (e) => 
                _sentenceShow(e)
              ).toList(),
            ),
          ),
        ) : null,
      ],
    );

  Widget get _paraphraseSetShow => _word.paraphraseSet.isNotEmpty ?
    ContainerOutline(
      decoration: InputDecoration(
        prefixText: '释义: ',
        prefixStyle: TextStyle(fontSize: 12, color: _colorA,),
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: InputBorder.none, //去掉下划线
      ),
      child: ColumnSpace(
        crossAxisAlignment: CrossAxisAlignment.start,
        divider: SizedBox(height: 10),
          children: sortParaphraseSet(_word.paraphraseSet).map( (e) =>
            ColumnSpace(
              crossAxisAlignment: CrossAxisAlignment.start,
              divider: SizedBox(height: 10),
              children: <Widget>[
                Text(
                  e.keys.first,
                  style: TextStyle(fontSize: 12, color: _colorB,),
                )]
                + e.values.first.asMap().map( (i, e) =>
                MapEntry<int, Widget>(i, _paraphraseShow(i + 1, e))
              ).values.toList(),
            )
          ).toList(),
        ),
    ) : null;

  Widget get _sentencePatternSetShow => _word.sentencePatternSet.isNotEmpty ?
    ContainerOutline(
      decoration: InputDecoration(
        prefixText: '常用句型: ',
        prefixStyle: TextStyle(fontSize: 12, color: _colorA,),
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: InputBorder.none, //去掉下划线
      ),
      child: ColumnSpace(
        crossAxisAlignment: CrossAxisAlignment.start,
        divider: SizedBox(height: 10),
          children: _word.sentencePatternSet.map( (e) =>
            ColumnSpace(
              crossAxisAlignment: CrossAxisAlignment.start,
              divider: SizedBox(height: 10),
              children: <Widget>[
                Text(
                  e.content,
                  style: TextStyle(fontSize: 12, color: _colorB,),
                )]
                
              ),
            ).toList(),
        ),
    ) : null;

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
            _tagShow,
          ],
        ),
        _etymaShow,
        _morphShow,
        _originShow,
        _shorthandShow,
        _paraphraseSetShow,
      ],
    ) : null;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: _wordShow,
                  ),
                ],
              ),
            ),
      );
  }
}
