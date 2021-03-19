import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/Tag.dart';
import 'package:flutter_prj/widgets/column_space.dart';
import 'package:flutter_prj/widgets/ok_cancel.dart';
import 'package:flutter_prj/widgets/pop_dialog.dart';
import 'package:flutter_prj/widgets/row_space.dart';
import 'package:flutter_prj/widgets/wrap_custom.dart';


class EditWord extends StatefulWidget {
  final String _title;
  final WordSerializer _word;

  EditWord({Key key, String title, WordSerializer word})
    : _title = title,
      _word = word != null ? word : WordSerializer(),
      super(key:key);

  @override
  _EditWordState createState() => _EditWordState();
}

class _EditWordState extends State<EditWord> {
  final GlobalKey _formKey =  GlobalKey<FormState>();
  final _textStyle = const TextStyle(fontSize: 14,);
  static const List<String> _morphOptions = ['选择', '过去分词', '现在分词', '名词', '形容词', '动词', '副词', '比较级', '最高级'];
  String _morphSelect = _morphOptions.first;
  String _morphInput = '';

  _editMorph(BuildContext context) async {
    _morphInput = '';
    await showDialog(
      context: context,
      builder: (context) =>
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) =>
            SimpleDialog(
              title: Text('编辑变形单词'),
              contentPadding: EdgeInsets.fromLTRB(10,10,10,10),
              children: [
                RowSpace(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  divider: SizedBox(width: 8.0,),
                  children: [
                    DropdownButton(
                      value: _morphSelect,
                      items: _morphOptions.map((e)=>DropdownMenuItem(child: Text(e), value: e,)).toList(),
                      onChanged: (v) {setState(() => _morphSelect = v);},
                    ),
                    Container(
                      width: 100,
                      child: TextField(
                        maxLines: null,
                        onChanged: (val) {
                          if(_morphSelect != _morphOptions.first && val.trim().isNotEmpty)
                            _morphInput = '$_morphSelect: ${val.trim()}';
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
        ),
    );

  if(_morphInput.isNotEmpty)
    setState(() => widget._word.morph.add(_morphInput));
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
          appBar: AppBar(
            title: Text(widget._title),
            automaticallyImplyLeading: false, // 取消返回按钮
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
                      autofocus: false,
                      keyboardType: TextInputType.number, // 键盘回车键的样式
                      textInputAction: TextInputAction.next,
                      controller: TextEditingController(text: widget._word.name),
                      maxLines: 1,
                      style: _textStyle,
                      decoration: InputDecoration(
                        labelText: "单词",
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          splashRadius: 1.0,
                          icon: Icon(Icons.search),
                          tooltip: '搜索',
                          onPressed: () async {
                            bool ret = await widget._word.retrieve();
                            if(ret) setState((){});
                          },
                        ),
                      ),
                      onChanged: (v) => widget._word.name = v.trim(),
                      validator: (v) => v.trim().isNotEmpty ? null : "不能为空",
                    ),
                    TextFormField(
                      autofocus: false,
                      keyboardType: TextInputType.number, // 键盘回车键的样式
                      textInputAction: TextInputAction.next,
                      controller: TextEditingController(text: widget._word.voiceUs),
                      maxLines: 1,
                      style: _textStyle,
                      decoration: InputDecoration(
                        labelText: "音标(美)",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (v) => widget._word.voiceUs = v.trim(),
                      //validator: (v) => v.trim().isNotEmpty ? null : "不能为空",
                    ),
                    TextFormField(
                      autofocus: false,
                      keyboardType: TextInputType.number, // 键盘回车键的样式
                      textInputAction: TextInputAction.next,
                      controller: TextEditingController(text: widget._word.voiceUk),
                      maxLines: 1,
                      style: _textStyle,
                      decoration: InputDecoration(
                        labelText: "音标(英)",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (v) => widget._word.voiceUk = v.trim(),
                      //validator: (v) => v.trim().isNotEmpty ? null : "不能为空",
                    ),
                    WrapOutlineTag(
                      data: widget._word.morph,
                      labelText: '单词变形',
                      suffix: TextButton(
                        child: Text('添加',),
                        onPressed: () => _editMorph(context),
                      ),
                    ),
                    WrapOutlineTag(
                      data: widget._word.etyma,
                      labelText: '词根词缀',
                      suffix: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            child: Text('添加',),
                            onPressed: () => popSelectDialog(
                              context: context,
                              title: Text('选择词根词缀'),
                              options: Global.etymaOptions,
                              close: (v) => setState(() => widget._word.etyma.add(v)),
                            ),
                          ),
                          TextButton(
                            child: Text('编辑'),
                            onPressed: () => Navigator.pushNamed(context, '/edit_etymas'),
                          ),
                        ]
                      )
                    ),
                    WrapOutlineTag(
                      data: widget._word.tag,
                      labelText: 'Tag',
                      suffix: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            child: Text('添加',),
                            onPressed: () => popSelectDialog(
                              context: context,
                              title: Text('选择Tag'),
                              options: Global.wordTagOptions,
                              close: (v) => setState(() => widget._word.tag.add(v)),
                            ),
                          ),
                          TextButton(
                            child: Text('编辑'),
                            onPressed: () => Navigator.pushNamed(context, '/edit_word_tag'),
                          ),
                        ]
                      )
                    ),
                    TextFormField(
                      autofocus: false,
                      keyboardType: TextInputType.number, // 键盘回车键的样式
                      textInputAction: TextInputAction.next,
                      controller: TextEditingController(text: widget._word.origin),
                      maxLines: null,
                      style: _textStyle,
                      decoration: InputDecoration(
                        labelText: "词源",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (v) => widget._word.origin = v.trim(),
                      //validator: (v) => v.trim().isNotEmpty ? null : "不能为空",
                    ),
                    TextFormField(
                      autofocus: false,
                      keyboardType: TextInputType.number, // 键盘回车键的样式
                      textInputAction: TextInputAction.next,
                      controller: TextEditingController(text: widget._word.shorthand),
                      maxLines: null,
                      style: _textStyle,
                      decoration: InputDecoration(
                        labelText: "速记",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (v) => widget._word.shorthand = v.trim(),
                      //validator: (v) => v.trim().isNotEmpty ? null : "不能为空",
                    ),
                    WrapOutline(
                      labelText: '近义词',
                      children: widget._word.synonym.map<Widget>((e) =>
                        Tag(
                          label: InkWell(
                            child: Text(e, style: TextStyle(color: Colors.amberAccent)),
                            onTap: () async {
                              var word = WordSerializer()..name = e;
                              bool ret = await word.retrieve();
                              if(ret) {
                                word = (await Navigator.pushNamed(context, '/edit_word', arguments: {'title':'编辑近义词', 'word': WordSerializer().from(word)})) as WordSerializer;
                                if(word != null) {
                                  await word.save();
                                }
                              }
                              setState((){});
                            },
                          ),
                          onDeleted: () => setState(() => widget._word.synonym.remove(e)),
                        )).toList(),
                      suffix: TextButton(
                        child: Text('添加',),
                        onPressed: () async {
                          var word = (await Navigator.pushNamed(context, '/edit_word', arguments: {'title':'添加近义词'})) as WordSerializer;
                          if(word != null) {
                            bool ret = await word.save();
                            if(ret) {
                              setState(() => widget._word.synonym.add(word.name));
                            }
                          }
                        },
                      ),
                    ),
                    WrapOutline(
                      labelText: '反义词',
                      children: widget._word.antonym.map<Widget>((e) =>
                        Tag(
                          label: InkWell(
                            child: Text(e, style: TextStyle(color: Colors.amberAccent)),
                            onTap: () async {
                              var word = WordSerializer()..name = e;
                              bool ret = await word.retrieve();
                              if(ret) {
                                word = (await Navigator.pushNamed(context, '/edit_word', arguments: {'title':'编辑反义词', 'word': WordSerializer().from(word)})) as WordSerializer;
                                if(word != null) {
                                  await word.save();
                                }
                              }
                              setState((){});
                            },
                          ),
                          onDeleted: () => setState(() => widget._word.antonym.remove(e)),
                        )).toList(),
                      suffix: TextButton(
                        child: Text('添加',),
                        onPressed: () async {
                          var word = (await Navigator.pushNamed(context, '/edit_word', arguments: {'title':'添加反义词'})) as WordSerializer;
                          if(word != null) {
                            bool ret = await word.save();
                            if(ret) {
                              setState(() => widget._word.antonym.add(word.name));
                            }
                          }
                        },
                      ),
                    ),
                    WrapOutline(
                      labelText: '释义',
                      children: widget._word.paraphraseSet.map<Widget>((e) =>
                        Tag(
                          label: InkWell(
                            child: ConstrainedBox(
                              child: Text('${e.partOfSpeech} ${e.interpret}', overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.amberAccent)),
                              constraints: BoxConstraints(maxWidth:80.0),
                            ),
                            onTap: () async {
                              var p = ParaphraseSerializer()..id = e.id;
                              bool ret = await p.retrieve();
                              if(ret) {
                                p = (await Navigator.pushNamed(context, '/edit_paraphrase', arguments: {'title':'编辑${widget._word.name}的释义', 'paraphrase': ParaphraseSerializer().from(p)})) as ParaphraseSerializer;
                                if(p != null) {
                                  await e.from(p).save();
                                }
                              }
                              setState((){});
                            },
                          ),
                          onDeleted: () => setState(() => widget._word.antonym.remove(e)),
                        )).toList(),
                      suffix: TextButton(
                        child: Text('添加'),
                        onPressed: () async {
                          var p = (await Navigator.pushNamed(context, '/edit_paraphrase', arguments: {'title':'给${widget._word.name}添加释义'})) as ParaphraseSerializer;
                          if(p != null) {
                            bool ret = await p.save();
                            if(ret) {
                              setState(() => widget._word.paraphraseSet.add(p));
                            }
                          }
                        },
                      ),
                    ),
                    WrapOutline(
                      labelText: '常用句型',
                      children: widget._word.sentencePatternSet.map<Widget>((e) =>
                        Tag(
                          label: InkWell(
                            child: Text('${e.content}', style: TextStyle(color: Colors.amberAccent)),
                            onTap: () async {
                              var s = SentencePatternSerializer()..id = e.id;
                              bool ret = await s.retrieve();
                              if(ret) {
                                s = (await Navigator.pushNamed(context, '/edit_sentence_pattern', arguments: {'title':'编辑${widget._word.name}的常用句型', 'sentence_pattern': SentencePatternSerializer().from(s)})) as SentencePatternSerializer;
                                if(s != null) {
                                  await e.from(s).save();
                                }
                              }
                              setState((){});
                            },
                          ),
                          onDeleted: () => setState(() => widget._word.sentencePatternSet.remove(e)),
                        )).toList(),
                      suffix: TextButton(
                            child: Text('添加',),
                            onPressed: () async {
                              var s = (await Navigator.pushNamed(context, '/edit_sentence_pattern', arguments: {'title':'给${widget._word.name}添加常用句型'})) as SentencePatternSerializer;
                              if(s != null) {
                                bool ret = await s.save();
                                if(ret) {
                                  setState(() => widget._word.sentencePatternSet.add(s));
                                }
                              }
                            },
                          ),
                    ),
                    WrapOutline(
                      labelText: '相关语法',
                      children: widget._word.grammarSet.map<Widget>((e) =>
                        Tag(
                          label: InkWell(
                            child: Text('${e.id}', style: TextStyle(color: Colors.amberAccent)),
                            onTap: () async {
                              var g = GrammarSerializer()..id = e.id;
                              bool ret = await g.retrieve();
                              if(ret) {
                                g = (await Navigator.pushNamed(context, '/edit_grammar', arguments: {'title':'编辑${widget._word.name}的相关语法', 'grammar': GrammarSerializer().from(g)})) as GrammarSerializer;
                                if(g != null) {
                                  await e.from(g).save();
                                }
                              }
                              setState((){widget._word.grammarSet.add(g);});
                            },
                          ),
                          onDeleted: () => setState(() => widget._word.grammarSet.remove(e)),
                        )).toList(),
                      suffix: TextButton(
                        child: Text('添加',),
                        onPressed: () async {
                          var g = (await Navigator.pushNamed(context, '/edit_grammar', arguments: {'title':'给${widget._word.name}添加相关语法'})) as GrammarSerializer;
                          if(g != null) {
                            bool ret = await g.save();
                            if(ret) {
                              setState(() => widget._word.grammarSet.add(g));
                            }
                          }
                        },
                      ),
                    ),
                    WrapOutline(
                      labelText: '词义辨析',
                      children: widget._word.distinguishSet.map<Widget>((e) =>
                        Tag(
                          label: InkWell(
                            child: Text('${e.id}', style: TextStyle(color: Colors.amberAccent)),
                            onTap: () async {
                              var d = DistinguishSerializer()..id = e.id;
                              bool ret = await d.retrieve();
                              if(ret) {
                                d = (await Navigator.pushNamed(context, '/edit_distinguish', arguments: {'title':'编辑${widget._word.name}的词义辨析', 'distinguish': DistinguishSerializer().from(d)})) as DistinguishSerializer;
                                if(d != null) {
                                  await e.from(d).save();
                                }
                              }
                              setState((){});
                            },
                          ),
                          onDeleted: () => setState(() => widget._word.distinguishSet.remove(e)),
                        )).toList(),
                      suffix: TextButton(
                        child: Text('添加',),
                        onPressed: () async {
                          var d = (await Navigator.pushNamed(context, '/edit_distinguish', arguments: {'title':'给${widget._word.name}添加词义辨析'})) as DistinguishSerializer;
                          if(d != null) {
                            bool ret = await d.save();
                            if(ret) {
                              setState(() => widget._word.distinguishSet.add(d));
                            }
                          }
                        },
                      ),
                    ),
                    OkCancel(ok: () {
                      if((_formKey.currentState as FormState).validate()) // 验证各个表单字段是否合法
                        Navigator.pop(context, widget._word);
                    }),
                  ]
                ),
              ),
            ),
    );
  }
}
