import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/common/http.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/SelectDialog.dart';
import 'package:flutter_prj/widgets/popup_memu_button.dart';
import 'dart:math' as math;
import 'package:flutter_prj/widgets/sentence_details.dart';


class SentencePatternEdit extends StatefulWidget {
  final SentenceSerializer _sentence;

  SentencePatternEdit({
      Key key,
      SentenceSerializer sentence,
      Function(Object) delete,
      List<Function(String)> onChanged})
    : _sentence = sentence,
      super(key:key);

  @override
  _SentencePatternEditState createState() => _SentencePatternEditState();
}

class _SentencePatternEditState extends State<SentencePatternEdit> {
  static const List<String> _options = ["删除", "设置类型", "添加Tag", "选择时态", "选择句型", "添加相关语法", "设置同义句", "设置反义句", "编辑Tags"];
  static const List<String> _types = ["句子", "短语"];
  final TextStyle _textStyle = const TextStyle(fontSize: 14,);

  _onSelected(String value) {
    if(value == "删除") {
      widget._sentence.delete();
    } else if(value == "设置类型") {
      popSelectDialog(
        context: context,
        title: value,
        options: _types,
        close: (String val) => setState(() => widget._sentence.s_type = _types.indexOf(val)),
      );
    } else if(value == "添加Tag") {
      popSelectDialog(
        context: context,
        title: value,
        options: Global.sentenceTagOptions,
        close: (String val) => setState(() => widget._sentence.s_tags.add(val)),
      );
    } else if(value == "选择时态") {
      popSelectDialog(
        context: context,
        title: value,
        options: Global.tenseOptions,
        close: (String val) => setState(() => widget._sentence.s_tense.add(val)),
      );
    } else if(value == "选择句型") {
      popSelectDialog(
        context: context,
        title: value,
        options: Global.sentenceFormOptions,
        close: (String val) => setState(() => widget._sentence.s_form.add(val)),
      );
    }
    else if(value == "添加相关语法") {
      widget._sentence.sentence_grammar.add(GrammarSerializer());
      Navigator.pushNamed(context, "/edit_grammar", arguments:widget._sentence.sentence_grammar.last);
    }
    else if(value == "编辑Tags") {
      Navigator.pushNamed(context, "/edit_sentence_tags");
    }
  }

  _buildEnglishSentence(BuildContext context) => 
    TextField(
      maxLines: null, // 当一行写满时,会自动扩展
      controller: TextEditingController(text:widget._sentence.s_en),
      style: _textStyle,
      decoration: InputDecoration(
        hintText: "英文例句",
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
          hintText: "中文例句",
          suffixIcon: InkWell(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('保存', style: TextStyle(color: Theme.of(context).primaryColor)),
              ],
            ),
            onTap: () {
              widget._sentence.save();
            }
          ),
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


/*

import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/common/http.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/SelectDialog.dart';
import 'dart:math' as math;
import 'package:flutter_prj/widgets/sentence_details.dart';


class SentencePatternEdit extends StatefulWidget {
  final SentenceSerializer _data;
  final TextEditingController _controllerA = new TextEditingController();
  final TextEditingController _controllerB = new TextEditingController();

  SentencePatternEdit({
      Key key,
      SentenceSerializer data,
      Function(Object) delete,
      List<Function(String)> onChanged})
    : _data = data,
      super(key:key) {
        _controllerA.text = _data.s_en;
        _controllerB.text = _data.s_ch;
      }

  @override
  _SentencePatternEditState createState() => _SentencePatternEditState();
}

class _SentencePatternEditState extends State<SentencePatternEdit> {
  bool status = true;
  final List<String> options = ["删除", "设置类型", "添加tag", "选择时态", "选择句型", "设置同义句", "设置反义句"];
  final List<String> _types = ["句子", "短语"];
  final TextStyle _textStyle = const TextStyle(fontSize: 14,);

  _onSelected(String value) {
    print(value);
    if(value == "删除") {
      if(widget._data.s_id != -1) {
        Http().deleteSentence(widget._data.s_id);
      }
    } else if(value == "设置类型") {
      popSelectDialog(
        context: context,
        title: value,
        options: _types,
        close: (String val) => setState(() => widget._data.s_type = _types.indexOf(val)),
      );
    } else if(value == "添加tag") {
      popSelectDialog(
        context: context,
        title: value,
        options: Global.sentenceTagOptions,
        close: (String val) => setState(() => widget._data.s_tags.add(val)),
      );
    } else if(value == "选择时态") {
      popSelectDialog(
        context: context,
        title: value,
        options: Global.tenseOptions,
        close: (String val) => setState(() => widget._data.s_tense.add(val)),
      );
    } else if(value == "选择句型") {
      popSelectDialog(
        context: context,
        title: value,
        options: Global.sentenceFormOptions,
        close: (String val) => setState(() => widget._data.s_form.add(val)),
      );
    }
  }

  _buildPopupMenuButton(BuildContext context) =>
    PopupMenuButton<String> (
      elevation: 5,               // 设置立体效果的阴影
      padding: EdgeInsets.all(5), // 菜单项的内边距
      offset: Offset(0, 0),       // 控制菜单弹出的位置()
      itemBuilder: (context) =>
        options.map((String e) =>
          PopupMenuItem<String>(
            value: e,
            textStyle: const TextStyle(fontWeight: FontWeight.w600), // 文本样式
            child: Text(e, style: const TextStyle(color: Colors.blue) ),    // 子控件
          )
        ).toList(),
      onCanceled: () => print("---- cancel"), // 没有选择任何值的回调函数
      onSelected: _onSelected,              // 选中某个值退出的回调函数,
    );

  _buildEnglishSentence(BuildContext context) => MouseRegion(
      onEnter: (e) => setState((){ status = !status;}),
      onExit: (e)=> setState((){ status = !status;}),
      child: TextField(
        maxLines: null, // 当一行写满时,会自动扩展
        controller: widget._controllerA,
        style: _textStyle,
        decoration: InputDecoration(
          hintText: "英文例句",
          suffixIcon: Offstage(
            offstage: status,
            child: _buildPopupMenuButton(context),
          ),
        ),
        onChanged: (String value){
          widget._data.s_en = value;
        }
    )
  );

  _buildChineseSentence(BuildContext context) =>
    TextField(
        maxLines: null,
        controller: widget._controllerB,
        style: _textStyle,
        decoration: InputDecoration(
          hintText: "中文例句",
          suffix: InkWell(
            child: Text('保存', style: TextStyle(color: Theme.of(context).primaryColor)),
            onTap: () {
              if(widget._data.s_id == -1) Http().createSentence(widget._data);
              else Http().updateSentence(widget._data);
            } 
          ),
        ),
        onChanged: (String value){
          widget._data.s_ch = value;
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
              SentenceDetails(sentence: widget._data),
              _buildChineseSentence(context),
            ],
          ),
        ),
      ],
    );
  }
}
*/
