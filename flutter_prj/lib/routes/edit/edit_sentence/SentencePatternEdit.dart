import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/routes/edit/edit_sentence/sentence_details.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/SelectDialog.dart';
import 'package:flutter_prj/widgets/popup_memu_button.dart';
import 'dart:math' as math;


class SentencePatternEdit extends StatefulWidget {
  final SentenceSerializer _sentence;

  SentencePatternEdit({Key key, SentenceSerializer sentence, Function(Object) delete, List<Function(String)> onChanged})
    : _sentence = sentence,
      super(key:key);

  @override
  _SentencePatternEditState createState() => _SentencePatternEditState();
}

class _SentencePatternEditState extends State<SentencePatternEdit> {
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
      SentenceSerializer sentence = await Navigator.pushNamed(context, '/edit_sentence', arguments: {'title':'设置同义句','sentence':SentenceSerializer()});
      //sentence.save(update:true);
      //setState(() => widget._sentence.s_synonym.add();
    }
    else if(value == '设置反义句') {
      SentenceSerializer sentence = await Navigator.pushNamed(context, '/edit_sentence', arguments: {'title':'设置反义句','sentence':SentenceSerializer()});
      //sentence.save(update:true);
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

  @override
  Widget build(BuildContext context) {
    return Row(
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
  }
}
