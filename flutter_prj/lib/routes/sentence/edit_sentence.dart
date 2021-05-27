import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/widgets/Tag.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/column_space.dart';
import 'package:flutter_prj/widgets/pop_dialog.dart';
import 'package:flutter_prj/widgets/wrap_custom.dart';


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
  final GlobalKey _formKey =  GlobalKey<FormState>();
  static const List<String> _types = ['句子', '名词短语', '介词短语', '形容/副词短语', '动词短语', '固定搭配'];
  String _typeSelected;
  String _tenseSelected;
  final List<String> _tenseOptions = ['选择时态'] + Global.tenseOptions;

  @override
  void initState() { 
    super.initState();
    _tenseSelected = widget._sentence.tense == null || widget._sentence.tense.isEmpty ? '选择时态' : widget._sentence.tense;
    _typeSelected = _types[widget._sentence.type];
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(fontSize: 14,);
    final idctrl = TextEditingController(text: widget._sentence.id.toString());
    return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: Text(widget._title),
              centerTitle: true,
              //automaticallyImplyLeading: false, // 取消返回按钮
              leading: TextButton(
                child: Text('取消', style: TextStyle(color: Colors.white),),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                TextButton(
                  child: Text('确定', style: TextStyle(color: Colors.white),),
                  onPressed: () {
                    if((_formKey.currentState as FormState).validate()) // 验证各个表单字段是否合法
                      Navigator.pop(context, widget._sentence);
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
              child: Form(
                key: _formKey, //设置globalKey，用于后面获取FormState
                //autovalidateMode: AutovalidateMode.always, //开启自动校验
                child: ColumnSpace(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  divider: SizedBox(height: 20,),
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.number, // 键盘回车键的样式
                      textInputAction: TextInputAction.next,
                      controller: idctrl,
                      maxLines: 1,
                      style: textStyle,
                      decoration: InputDecoration(
                        labelText: "id",
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          splashRadius: 1.0,
                          icon: Icon(Icons.search),
                          tooltip: '搜索',
                          onPressed: () async {
                            var s = SentenceSerializer()..id = num.parse(idctrl.text.trim());
                            bool ret = await s.retrieve();
                            if(ret) setState(() => widget._sentence.from(s));
                          },
                        ),
                      ),
                      //onChanged: (v) => null,
                      //validator: (v) => v.trim().isNotEmpty ? null : "不能为空",
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text, // 键盘回车键的样式
                      textInputAction: TextInputAction.next,
                      controller: TextEditingController(text:widget._sentence.en),
                      maxLines: null,
                      style: textStyle,
                      decoration: InputDecoration(
                        labelText: "英文例句",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (v) => widget._sentence.en = v.trim(),
                      validator: (v) => v.trim().isNotEmpty ? null : "不能为空",
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text, // 键盘回车键的样式
                      textInputAction: TextInputAction.next,
                      controller: TextEditingController(text:widget._sentence.cn),
                      maxLines: null,
                      style: textStyle,
                      decoration: InputDecoration(
                        labelText: "中文例句",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (v) => widget._sentence.cn = v.trim(),
                      validator: (v) => v.trim().isNotEmpty ? null : "不能为空",
                    ),
                    DropdownButtonFormField(
                      value: _typeSelected,
                      items: _types.map((e)=>DropdownMenuItem(child: Text(e, style: textStyle,), value: e,)).toList(),
                      decoration: InputDecoration(
                        prefixText: '类型:  ',
                        prefixStyle: TextStyle(fontSize: 14, color: Color.fromRGBO(132,132,132,1.0)),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (v) {
                        widget._sentence.type = _types.indexOf(v);
                        setState(() => _typeSelected = v);
                      },
                    ),
                    WrapOutlineTag(
                      data: widget._sentence.tag,
                      labelText: 'Tag',
                      suffix: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            child: Text('添加',),
                            onPressed: () => popSelectDialog(
                              context: context,
                              title: Text('选择Tag'),
                              options: Global.sentenceTagOptions,
                              close: (v) => setState(() => widget._sentence.tag.add(v)),
                            ),
                          ),
                          TextButton(
                            child: Text('编辑'),
                            onPressed: () => Navigator.pushNamed(context, '/edit_sentence_tag'),
                          ),
                        ]
                      )
                    ),
                    DropdownButtonFormField(
                      value: _tenseSelected,
                      items: _tenseOptions.map((e)=>DropdownMenuItem(child: Text(e, style: textStyle,), value: e,)).toList(),
                      decoration: InputDecoration(
                        prefixText: '时态:  ',
                        prefixStyle: TextStyle(fontSize: 14, color: Color.fromRGBO(132,132,132,1.0)),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (v) {
                        widget._sentence.tense = v == _tenseOptions.first ? '' : v;
                        setState(() => _tenseSelected = v);
                      },
                    ),
                    WrapOutlineTag(
                      data: widget._sentence.pattern,
                      labelText: '句型',
                      suffix: TextButton(
                        child: Text('添加',),
                        onPressed: () => popSelectDialog(
                          context: context,
                          title: Text('选择句型'),
                          options: Global.sentenceFormOptions,
                          close: (v) => setState(() => widget._sentence.pattern.add(v)),
                        ),
                      ),
                    ),
                    WrapOutline(
                      labelText: '同义句',
                      children: widget._sentence.synonym.map<Widget>((e) =>
                        Tag(
                          label: InkWell(
                            child: Text('$e', style: TextStyle(fontSize: 14, color: Colors.blueAccent)),
                            onTap: () async {
                              var sentence = SentenceSerializer()..id = e;
                              bool ret = await sentence.retrieve();
                              if(ret) {
                                sentence = (await Navigator.pushNamed(
                                  context, '/edit_sentence',
                                  arguments: {'title':'编辑同义句', 'word': SentenceSerializer().from(sentence)})
                                ) as SentenceSerializer;
                                if(sentence != null) {
                                  await sentence.save();
                                }
                              }
                              setState((){});
                            },
                          ),
                          onDeleted: () => setState(() => widget._sentence.synonym.remove(e)),
                        )).toList(),
                      suffix: TextButton(
                        child: Text('添加',),
                        onPressed: () async {
                          var sentence = (await Navigator.pushNamed(context, '/edit_sentence', arguments: {'title':'添加同义句'})) as SentenceSerializer;
                          if(sentence != null) {
                            bool ret = await sentence.save();
                            if(ret) {
                              setState(() => widget._sentence.synonym.add(sentence.id));
                            }
                          }
                        },
                      ),
                    ),
                    WrapOutline(
                      labelText: '反义句',
                      children: widget._sentence.antonym.map<Widget>((e) =>
                        Tag(
                          label: InkWell(
                            child: Text('$e', style: TextStyle(fontSize: 14, color: Colors.blueAccent)),
                            onTap: () async {
                              var sentence = SentenceSerializer()..id = e;
                              bool ret = await sentence.retrieve();
                              if(ret) {
                                sentence = (await Navigator.pushNamed(context, '/edit_sentence', arguments: {'title':'编辑反义句', 'word': SentenceSerializer().from(sentence)})) as SentenceSerializer;
                                if(sentence != null) {
                                  await sentence.save();
                                }
                              }
                              setState((){});
                            },
                          ),
                          onDeleted: () => setState(() => widget._sentence.antonym.remove(e)),
                        )).toList(),
                      suffix: TextButton(
                        child: Text('添加',),
                        onPressed: () async {
                          var sentence = (await Navigator.pushNamed(context, '/edit_sentence', arguments: {'title':'添加反义句'})) as SentenceSerializer;
                          if(sentence != null) {
                            bool ret = await sentence.save();
                            if(ret) {
                              setState(() => widget._sentence.antonym.add(sentence.id));
                            }
                          }
                        },
                      ),
                    ),
                    ListOutline(
                      labelText: '相关语法',
                      children: widget._sentence.grammarSet.map<Widget>((e) =>
                        Tag(
                          label: InkWell(
                            child: Text('${e.title}', style: TextStyle(fontSize: 14, color: Colors.blueAccent)),
                            onTap: () async {
                              var g = (await Navigator.pushNamed(context,
                                                                 '/edit_grammar',
                                                                 arguments: {'title':'编辑句子的语法',
                                                                             'grammar': GrammarSerializer().from(e)})
                                      ) as GrammarSerializer;
                              if(g != null) {
                                e.from(g);
                                setState(() {});
                              }
                            },
                          ),
                          onDeleted: () {
                            e.delete();
                            widget._sentence.grammarSet.remove(e);
                             setState(() {});
                          },
                        )
                      ).toList(),
                      suffix: TextButton(
                        child: Text('添加',),
                        onPressed: () async {
                          var g = (await Navigator.pushNamed(context, '/edit_grammar', arguments: {'title': '给句子添加语法'})) as GrammarSerializer;
                          if(g != null) {
                            widget._sentence.grammarSet.add(g);
                            setState(() {});
                          }
                        },
                      ),
                    ),
                  ]
                ),
              ),
            ),
      );
  }
}
