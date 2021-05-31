import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/routes/common/text_form_field.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/Tag.dart';
import 'package:flutter_prj/widgets/column_space.dart';
import 'package:flutter_prj/widgets/pop_dialog.dart';
import 'package:flutter_prj/widgets/row_space.dart';
import 'package:flutter_prj/widgets/wrap_custom.dart';


class EditWord extends StatefulWidget {

  EditWord({Key key, this.title, WordSerializer word})
  : this.word = word != null ? word : WordSerializer(), super(key: key);

  final String title;
  final WordSerializer word;

  @override
  _EditWordState createState() => _EditWordState();
}

class _EditWordState extends State<EditWord> {
  final GlobalKey _formKey =  GlobalKey<FormState>();
  final _textStyle = const TextStyle(fontSize: 14,);
  static const List<String> _morphOptions = ['选择', '现在分词', '过去式', '过去分词', '第三人称单数', '名词', '复数', '形容词', '动词', '副词', '比较级', '最高级'];
  String _morphSelect = _morphOptions.first;
  String _morphInput = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: Text(widget.title),
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
                    Navigator.pop(context, widget.word);
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
                    RowSpace(
                      divider: SizedBox(width: 8,),
                      children: [
                        Expanded(
                          flex: 3,
                          child: textFiledForm(
                            text: widget.word.name,
                            labelText: '单词',
                            suffixIcon: IconButton(
                              splashRadius: 1.0,
                              icon: Icon(Icons.search),
                              tooltip: '搜索',
                              onPressed: () async {
                                bool ret = await widget.word.retrieve();
                                if(ret) setState((){});
                              },
                            ),
                            onChanged: (v) => widget.word.name = v,
                            validator: (v) => v.isNotEmpty ? null : "不能为空",
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: textFiledForm(
                            text: widget.word.voiceUs,
                            labelText: '音标(美)',
                            onChanged: (v) => widget.word.voiceUs = v,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: textFiledForm(
                            text: widget.word.voiceUk,
                            labelText: '音标(英)',
                            onChanged: (v) => widget.word.voiceUk = v,
                          ),
                        )
                      ]
                    ),
                    ListOutline(
                      labelText: '释义',
                      children: widget.word.paraphraseSet.map<Widget>((e) =>
                        Tag(
                          label: InkWell(
                            child: ConstrainedBox(
                              child: Text('${e.partOfSpeech} ${e.interpret}', overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, color: Colors.blueAccent)),
                              constraints: BoxConstraints(maxWidth: 230.0),
                            ),
                            onTap: () async {
                              var p = (await Navigator.pushNamed(context,
                                                                '/edit_paraphrase',
                                                                arguments: {'title':'编辑${widget.word.name}的释义',
                                                                            'paraphrase': ParaphraseSerializer().from(e)})
                                      ) as ParaphraseSerializer;
                              if(p != null) {
                                e.from(p);
                                setState((){});
                              }
                            },
                          ),
                          onDeleted: () {
                            e.delete();
                            widget.word.paraphraseSet.remove(e);
                            setState(() {});
                          }
                        )
                      ).toList(),
                      suffix: TextButton(
                        child: Text('添加'),
                        onPressed: () async {
                          var p = (await Navigator.pushNamed(context,
                                                             '/edit_paraphrase',
                                                             arguments: {'title':'给${widget.word.name}添加释义'})
                                  ) as ParaphraseSerializer;
                          if(p != null) {
                            widget.word.paraphraseSet.add(p);
                            setState(() {});
                          }
                        },
                      ),
                    ),
                    WrapOutlineTag(
                      data: widget.word.morph,
                      labelText: '单词变形',
                      suffix: TextButton(
                        child: Text('添加',),
                        onPressed: () => _editMorph(context),
                      ),
                    ),
                    WrapOutlineTag(
                      data: widget.word.etyma,
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
                              close: (v) => setState(() => widget.word.etyma.add(v)),
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
                      data: widget.word.tag,
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
                              close: (v) => setState(() => widget.word.tag.add(v)),
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
                      keyboardType: TextInputType.multiline, // 键盘回车键的样式
                      textInputAction: TextInputAction.next,
                      controller: TextEditingController(text: widget.word.origin),
                      maxLines: null,
                      style: _textStyle,
                      decoration: InputDecoration(
                        labelText: "词源(markdown)",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (v) => widget.word.origin = v.trim(),
                      //validator: (v) => v.trim().isNotEmpty ? null : "不能为空",
                    ),
                    ListOutline(
                      labelText: '常用句型',
                      children: widget.word.sentencePatternSet.map<Widget>((e) =>
                        Tag(
                          label: InkWell(
                            child: Text('${e.content}', style: TextStyle(fontSize: 14, color: Colors.blueAccent)),
                            onTap: () async {
                                var s = (await Navigator.pushNamed(context,
                                                                  '/edit_sentence_pattern',
                                                                  arguments: {'title':'编辑${widget.word.name}的常用句型',
                                                                              'sentence_pattern': SentencePatternSerializer().from(e)})
                                        ) as SentencePatternSerializer;
                                if(s != null) {
                                  e.from(s);
                                  setState(() {});
                                }
                            },
                          ),
                          onDeleted: () {
                            e.delete();
                            widget.word.sentencePatternSet.remove(e);
                            setState(() {});
                          }
                        )
                      ).toList(),
                      suffix: TextButton(
                        child: Text('添加',),
                        onPressed: () async {
                          var s = (await Navigator.pushNamed(context,
                                                             '/edit_sentence_pattern',
                                                             arguments: {'title': '给${widget.word.name}添加常用句型'})
                                  ) as SentencePatternSerializer;
                          if(s != null) {
                            widget.word.sentencePatternSet.add(s);
                            setState(() {});
                          }
                        },
                      ),
                    ),
                    ListOutline(
                      labelText: '相关语法',
                      children: widget.word.grammarSet.map<Widget>((e) =>
                        Tag(
                          label: InkWell(
                            child: Text('${e.title}', style: TextStyle(fontSize: 14, color: Colors.blueAccent)),
                            onTap: () async {
                              var g = (await Navigator.pushNamed(context,
                                                                 '/edit_grammar',
                                                                 arguments: {'title':'编辑${widget.word.name}的相关语法',
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
                            widget.word.grammarSet.remove(e);
                            setState(() {});
                          },
                        )
                      ).toList(),
                      suffix: TextButton(
                        child: Text('添加',),
                        onPressed: () async {
                          var g = (await Navigator.pushNamed(context,
                                                             '/edit_grammar',
                                                             arguments: {'title': '给${widget.word.name}添加相关语法'})
                                  ) as GrammarSerializer;
                          if(g != null) {
                            widget.word.grammarSet.add(g);
                            setState(() {});
                          }
                        },
                      ),
                    ),
                    ListOutline(
                      labelText: '词义辨析',
                      children: widget.word.distinguishSet.map<Widget>((e) =>
                        Tag(
                          label: InkWell(
                            child: Text('${e.wordsForeign.join(", ") + e.sentencePatternForeignSet.map((e) => e.content).join(", ")}', style: TextStyle(fontSize: 14, color: Colors.blueAccent)),
                            onTap: () async {
                              var d = (await Navigator.pushNamed(context,
                                                                  '/edit_distinguish',
                                                                  arguments: {'title': '编辑${widget.word.name}的词义辨析',
                                                                  'distinguish': DistinguishSerializer().from(e)})
                                      ) as DistinguishSerializer;
                              if(d != null) {
                                e.from(d);
                                setState(() {});
                              }
                            },
                          ),
                          onDeleted: () {
                            e.delete();
                            widget.word.distinguishSet.remove(e);
                            setState(() {});
                          }
                        )).toList(),
                      suffix: TextButton(
                        child: Text('添加',),
                        onPressed: () async {
                          var d = (await Navigator.pushNamed(context,
                                                             '/edit_distinguish',
                                                             arguments: {'title':'给${widget.word.name}添加词义辨析'})
                                  ) as DistinguishSerializer;
                          if(d != null) {
                            widget.word.distinguishSet.add(d);
                            setState(() {});
                          }
                        },
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.multiline, // 键盘回车键的样式
                      textInputAction: TextInputAction.next,
                      controller: TextEditingController(text: widget.word.shorthand),
                      maxLines: null,
                      style: _textStyle,
                      decoration: InputDecoration(
                        labelText: "速记",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (v) => widget.word.shorthand = v.trim(),
                      //validator: (v) => v.trim().isNotEmpty ? null : "不能为空",
                    ),
                    WrapOutline(
                      labelText: '近义词',
                      children: widget.word.synonym.map<Widget>((e) =>
                        Tag(
                          label: InkWell(
                            child: Text(e, style: TextStyle(fontSize: 14, color: Colors.blueAccent)),
                            onTap: () async {
                              var word = WordSerializer()..name = e;
                              bool ret = await word.retrieve();
                              if(ret) {
                                word = (await Navigator.pushNamed(context, '/edit_word', arguments: {'title':'编辑近义词', 'word': WordSerializer().from(word)})) as WordSerializer;
                                if(word != null) {
                                  await word.save();
                                  setState(() {});
                                }
                              }
                            },
                          ),
                          onDeleted: () => setState(() => widget.word.synonym.remove(e)),
                        )
                      ).toList(),
                      suffix: TextButton(
                        child: Text('添加',),
                        onPressed: () async {
                          var word = (await Navigator.pushNamed(context, '/edit_word', arguments: {'title':'添加近义词'})) as WordSerializer;
                          if(word != null) {
                            bool ret = await word.save();
                            if(ret) {
                              setState(() => widget.word.synonym.add(word.name));
                            }
                          }
                        },
                      ),
                    ),
                    WrapOutline(
                      labelText: '反义词',
                      children: widget.word.antonym.map<Widget>((e) =>
                        Tag(
                          label: InkWell(
                            child: Text(e, style: TextStyle(fontSize: 14, color: Colors.blueAccent)),
                            onTap: () async {
                              var word = WordSerializer()..name = e;
                              bool ret = await word.retrieve();
                              if(ret) {
                                word = (await Navigator.pushNamed(context, '/edit_word', arguments: {'title':'编辑反义词', 'word': WordSerializer().from(word)})) as WordSerializer;
                                if(word != null) {
                                  await word.save();
                                  setState(() {});
                                }
                              }
                            },
                          ),
                          onDeleted: () => setState(() => widget.word.antonym.remove(e)),
                        )
                      ).toList(),
                      suffix: TextButton(
                        child: Text('添加',),
                        onPressed: () async {
                          var word = (await Navigator.pushNamed(context, '/edit_word', arguments: {'title':'添加反义词'})) as WordSerializer;
                          if(word != null) {
                            bool ret = await word.save();
                            if(ret) {
                              setState(() => widget.word.antonym.add(word.name));
                            }
                          }
                        },
                      ),
                    ),
                    WrapOutline(
                      labelText: '相关图片',
                      children: [
                        SelectableText(widget.word.image.mptFile?.filename ?? (widget.word.image.url)),
                        //_testImagePath != null ? Image.network(_testImagePath) : Text(''),
                        //_testImage != null ? Image.file(_testImage) : Text(''),
                      ],
                      suffix: TextButton(
                        child: Text('添加',),
                        onPressed: () async {
                          /*
                          var result = await FilePicker.platform.pickFiles(
                            type: FileType.image,
                            allowMultiple: true,
                            withReadStream: true, // this will return PlatformFile object with read stream
                          );
                          if (result == null) return;
                          for(var f in result.files)
                            print('--- ${f.path} ${f.name} ${f.size}');
                          */
                          await widget.word.image.pick();
                          setState(() {});
                        },
                      ),
                    ),
                    WrapOutline(
                      labelText: '相关视频',
                      children: [
                        SelectableText(widget.word.vedio.mptFile?.filename ?? (widget.word.vedio.url)),
                      ],
                      suffix: TextButton(
                        child: Text('添加',),
                        onPressed: () async {
                          await widget.word.vedio.pick();
                          setState(() {});
                        },
                      ),
                    ),
                  ]
                ),
              ),
            ),
    );
  }

  _editMorph(BuildContext context) async {
    _morphInput = '';
    await showDialog(
      context: context,
      builder: (context) =>
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) =>
            SimpleDialog(
              title: Text('编辑变形单词'),
              contentPadding: EdgeInsets.fromLTRB(10,10,10,30),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    DropdownButton(
                      isDense: true,
                      value: _morphSelect,
                      items: _morphOptions.map((e)=>DropdownMenuItem(child: Text(e), value: e,)).toList(),
                      onChanged: (v) {setState(() => _morphSelect = v);},
                      underline: Divider(height: 1,),
                    ),
                    Container(
                      width: 100,
                      child: TextField(
                        maxLines: 1,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 8)
                        ),
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
    setState(() => widget.word.morph.add(_morphInput));
  }
}
