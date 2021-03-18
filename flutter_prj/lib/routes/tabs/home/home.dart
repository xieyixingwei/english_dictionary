import 'package:flutter/material.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/RatingStar.dart';
import 'package:flutter_prj/widgets/container_outline.dart';


class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final WordSerializer _word = WordSerializer();

  Widget _buildHeader(BuildContext context) {
    return Column(
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
  }

  Widget _buildSearch(BuildContext context) {
    return TextField(
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
  }

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
      style: TextStyle(
        fontSize: 12,
        color: Color.fromRGBO(132,132,132,1.0),
      ),
    ) : null;

  Widget get _voiceUkShow => _word.voiceUk.isNotEmpty ?
    Text(
      '英 ${_word.voiceUk}',
      style: TextStyle(
        fontSize: 12,
        color: Color.fromRGBO(132,132,132,1.0),
      ),
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
      style: TextStyle(
        fontSize: 12,
        color: Color.fromRGBO(132,132,132,1.0),
      ),
    ) : null;

  Widget get _originShow => _word.origin.isNotEmpty ?
    ContainerOutline(
      decoration: InputDecoration(
        prefixText: '词源',
      ),
      child: Text(
        _word.origin,
        style: TextStyle(
          fontSize: 12,
          color: Color.fromRGBO(132,132,132,1.0),
        ),
      ),
    ) : null;

  Widget get _shorthandShow => _word.shorthand.isNotEmpty ?
    ContainerOutline(
                decoration: InputDecoration(
                  prefixText: '速记',
                ),
                child: Text(
                  _word.shorthand,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color.fromRGBO(132,132,132,1.0),
                  ),
                ),
              ) : null;

  Widget get _wordShow => _word.name.isNotEmpty ?
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _wordNameShow,
        SizedBox(height: 10,),
        Row(
          children: [
            _voiceUsShow,
            SizedBox(width: 20,),
            _voiceUkShow,
            SizedBox(width: 20,),
            _tagShow,
          ].where((e) => e != null).toList(),
        ),
        SizedBox(height: 20,),
        _etymaShow,
        SizedBox(height: 20,),
        _morphShow,
        SizedBox(height: 20,),
        _originShow,
        SizedBox(height: 20,),
        _shorthandShow,
      ].where((e) => e != null).toList(),
    ) : null;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 120,
                ),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children:[
                      _buildHeader(context),
                      SizedBox(height: 20,),
                      Padding(
                        padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
                        child: _buildSearch(context),
                      ),
                      SizedBox(height: 20,),
                      _wordShow,
                    ].where((e) => e != null).toList(),
                  ),
                ),
              ),
            ),
      );
  }
}
