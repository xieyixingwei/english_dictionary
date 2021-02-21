import 'package:flutter/material.dart';
import 'package:flutter_prj/models/sentence.dart';
import 'package:flutter_prj/widgets/SelectDialog.dart';
import 'dart:math' as math;

import 'package:flutter_prj/widgets/Tag.dart';


class SentencePatternEdit extends StatefulWidget {
  final Sentence _data;
  final Function(Object) _delete;
  final List<Function(String)> _onChanged;
  final TextEditingController _controllerA = new TextEditingController();
  final TextEditingController _controllerB = new TextEditingController();

    SentencePatternEdit({
      Key key,
      Sentence data,
      Function(Object) delete,
      List<Function(String)> onChanged})
    : _data = data,
      _delete = delete,
      _onChanged = onChanged,
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
  final List<String> _types = ["句子","短语"];
  final TextStyle _textStyle = const TextStyle(fontSize: 14,);

  _onSelected(String value) {
    print(value);
    if(value == "删除" && widget._delete != null) {
      widget._delete(widget._data);
    } else if(value == "设置类型") {
      popSelectDialog(
        context: context,
        title: value,
        options: _types,
        close: (String val) => widget._data.s_type = _types.indexOf(val),
      );
    } else if(value == "添加tag") {
      popSelectDialog(
        context: context,
        title: value,
        options: ["日常","商务","问候"],
        close: (String val) => widget._data.s_tags.add(val),
      );
    } else if(value == "选择时态") {
      popSelectDialog(
        context: context,
        title: value,
        options: ["一般现在时","一般过去时","将来时"],
        close: (String val) => widget._data.s_tense.add(val),
      );
    } else if(value == "选择句型") {
      popSelectDialog(
        context: context,
        title: value,
        options: ["定语从句","主语从句","被动句"],
        close: (String val) => widget._data.s_form.add(val) ,
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

  Widget _buildType(BuildContext context) {
    final TextStyle style = TextStyle(fontSize: 12.0, color: Colors.green);
    return Text(_types[widget._data.s_type], style: style);
  }

  List<Widget> _buildTags(BuildContext context) {
    final TextStyle style = TextStyle(fontSize: 12.0, color: Theme.of(context).primaryColor);
    List<Widget> tags = [];
    if(widget._data.s_tags.length == 0) return tags;
    tags.add(Text("Tags:", style: style));
    tags.addAll(
      widget._data.s_tags.map((e) => 
        Tag(
          label: Text(e, style: style,),
          onDeleted: () => widget._data.s_tags.remove(e),
        )
      ).toList()
    );
    return tags;
  }

  List<Widget> _buildTense(BuildContext context) {
    final TextStyle style = TextStyle(fontSize: 12.0, color: Colors.blueGrey);
    List<Widget> tense = [];
    if(widget._data.s_tense.length == 0) return tense;
    tense.add(Text("时态:", style: style));
    tense.addAll(
      widget._data.s_tense.map((e) => 
        Tag(
          label: Text(e, style: style,),
          onDeleted: () => widget._data.s_tense.remove(e),
        )
      ).toList()
    );
    return tense;
  }

  List<Widget> _buildForm(BuildContext context) {
    final TextStyle style = TextStyle(fontSize: 12.0, color: Colors.orange);
    List<Widget> form = [];
    if(widget._data.s_form.length == 0) return form;
    form.add(Text("句型:", style: style));
    form.addAll(
      widget._data.s_form.map((e) => 
        Tag(
          label: Text(e, style: style,),
          onDeleted: () => widget._data.s_form.remove(e),
        )
      ).toList()
    );
    return form;
  }

  _buildDetail(BuildContext context) {
    List<Widget> children = [];
    children.add(_buildType(context));
    children.addAll(_buildTags(context));
    children.addAll(_buildTense(context));
    children.addAll(_buildForm(context));
    return Wrap(
            spacing: 8.0,
            runSpacing: 8.0, 
            children: children,
          );
  }

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
          if(widget._onChanged != null) widget._onChanged[0](value);
        }
    )
  );

  _buildChineseSentence(BuildContext context) => TextField(
        maxLines: null,
        controller: widget._controllerB,
        style: _textStyle,
        decoration: InputDecoration(
          hintText: "中文例句",
        ),
        onChanged: (String value){
          if(widget._onChanged != null) widget._onChanged[1](value);
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
              _buildDetail(context),
              _buildChineseSentence(context),
            ],
          ),
        ),
      ],
    );
  }
}

/*
class SentencePatternEdit extends StatelessWidget {
  final int _index;
  final int _indent;
  final Function(Object) _delete;
  final List<Function(String)> _onChanged;
  final TextEditingController _controllerA = new TextEditingController();
  final TextEditingController _controllerB = new TextEditingController();

  SentencePatternEdit({
    Key key,
    List<String> data=const ["", ""],
    int index=0,
    int indent=1,
    Function(Object) delete,
    List<Function(String)> onChanged})
    : _index = index,
      _indent = indent,
      _delete = delete,
      _onChanged = onChanged,
      super(key:key) {
        _controllerA.text = data[0];
        _controllerB.text = data[1];
      }

  @override
  Widget build(BuildContext context) {
    //print("----- PatternLineEdit build ${_hintText[0]}");

    return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    maxLines: 1,
                    controller: _controllerA,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      hintText: "英文例句",
                    ),
                    onChanged: (String value){
                      if(_onChanged != null) _onChanged[0](value);
                    }
                  ),
                  TextField(
                    maxLines: 1,
                    controller: _controllerB,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      hintText: "中文例句",
                    ),
                    onChanged: (String value){
                      if(_onChanged != null) _onChanged[1](value);
                    }
                  ),
              ],
        );
  }
}
*/
