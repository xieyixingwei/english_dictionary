import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/widgets/popup_memu_button.dart';
import 'package:flutter_prj/routes/edit/edit_sentence/sentence_details.dart';
import 'package:flutter_prj/routes/edit_grammar/show_grammar.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/SelectDialog.dart';
import 'dart:math' as math;


class EditSentence extends StatefulWidget {
  final String _title;
  final SentenceSerializer _sentence;

  EditSentence({Key key, String title, SentenceSerializer sentence})
    : _title = title,
      _sentence = sentence != null ? sentence : SentenceSerializer(),
      super(key:key);

  @override
  _EditSentenceState createState() => _EditSentenceState();
}

class _EditSentenceState extends State<EditSentence> {
  static const List<String> _options = ['设置类型', '添加Tag', '选择时态', '选择句型', '设置同义句', '设置反义句', '编辑Tags'];
  static const List<String> _types = ['句子', '短语'];
  final TextStyle _textStyle = const TextStyle(fontSize: 14,);

  _onSelected(String value) async {
    if(value == '设置类型') {
      popSelectDialog(
        context: context,
        title: value,
        options: _types,
        close: (String val) => setState(() => widget._sentence.s_type = _types.indexOf(val)),
      );
    } else if(value == '添加Tag') {
      popSelectDialog(
        context: context,
        title: value,
        options: Global.sentenceTagOptions,
        close: (String val) => setState(() => widget._sentence.s_tags.add(val)),
      );
    } else if(value == '选择时态') {
      popSelectDialog(
        context: context,
        title: value,
        options: Global.tenseOptions,
        close: (String val) => setState(() => widget._sentence.s_tense.add(val)),
      );
    } else if(value == '选择句型') {
      popSelectDialog(
        context: context,
        title: value,
        options: Global.sentenceFormOptions,
        close: (String val) => setState(() => widget._sentence.s_form.add(val)),
      );
    }
    else if(value == '设置同义句') {
      var sentence = (await Navigator.pushNamed(context, '/edit_sentence', arguments: {'title':'设置同义句'})) as SentenceSerializer;
      sentence.save();
      //setState(() => widget._sentence.s_synonym.add();
    }
    else if(value == '设置反义句') {
      var sentence = (await Navigator.pushNamed(context, '/edit_sentence', arguments: {'title':'设置反义句'})) as SentenceSerializer;
      sentence.save();
      //setState(() => widget._sentence.s_synonym.add();
    }
    else if(value == '编辑Tags') {
      Navigator.pushNamed(context, '/edit_sentence_tags');
    }
  }

  _buildEnglishSentence(BuildContext context) => 
    TextField(
      maxLines: null, // 当一行写满时,会自动扩展
      controller: TextEditingController(text:widget._sentence.s_en),
      style: _textStyle,
      decoration: InputDecoration(
        hintText: '英文例句',
        suffixIcon: popupMenuButton(context:context, options:_options, onSelected:_onSelected),
      ),
      onChanged: (String value){
        widget._sentence.s_en = value;
      }
  );

  _buildChineseSentence(BuildContext context) =>
    TextField(
        maxLines: null,
        controller: TextEditingController(text:widget._sentence.s_ch),
        style: _textStyle,
        decoration: InputDecoration(
          hintText: '中文例句',
        ),
        onChanged: (String value){
          widget._sentence.s_ch = value;
        }
    );

  _buildSentencePattern(BuildContext context) =>
    Row(
      children: [
        Transform.rotate(
          angle: math.pi/2, // 旋转90度
          child: Icon(Icons.link, color: Theme.of(context).primaryColor,),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildEnglishSentence(context),
              SentenceDetails(sentence: widget._sentence, editable: true,),
              _buildChineseSentence(context),
            ],
          ),
        ),
      ],
    );

  _buildGrammer(BuildContext context) {
    print(widget._sentence.sentence_grammar.length);
    List<Widget> children = widget._sentence.sentence_grammar.map<Widget>(
      (e) => ShowGrammar(
        grammar: e,
        delete: () {
          e.delete();
          setState(() => widget._sentence.sentence_grammar.remove(e));
        },
      ),
    ).toList();

    children.add(
      Row(
        children: [
          Expanded(
            child: RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text('添加相关语法'),
              onPressed: () async {
                GrammarSerializer grammar = GrammarSerializer();
                var g = (await Navigator.pushNamed(context, '/edit_grammar', arguments:{'title':'添加句子相关语法','grammar':grammar})) as GrammarSerializer;
                if(g != null) {
                  g.g_sentence = widget._sentence.s_id;
                  print(g.toJson());
                  widget._sentence.sentence_grammar.add(g);
                  g.save();
                }
                setState((){});
              },
            ),
          )
        ]
      )
    );
    return Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              children: children,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              title: Text(widget._title),
              automaticallyImplyLeading: false, // 取消返回按钮
            ),
            body: Container(
              padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSentencePattern(context),
                  SizedBox(height: 20,),
                  _buildGrammer(context),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        splashRadius: 1.0,
                        icon: Icon(Icons.done, color: Colors.green,),
                        tooltip: '确定',
                        onPressed: () => Navigator.pop(context, widget._sentence),
                      ),
                      SizedBox(width: 10,),
                      IconButton(
                        splashRadius: 1.0,
                        icon: Icon(Icons.clear, color: Colors.grey,),
                        tooltip: '取消',
                        onPressed: () => Navigator.pop(context),
                      ),
                    ]
                  ),
                ],
              ),
            ),
          );
  }
}
