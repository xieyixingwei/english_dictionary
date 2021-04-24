import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/Tag.dart';
import 'package:flutter_prj/widgets/column_space.dart';
import 'package:flutter_prj/widgets/pop_dialog.dart';
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
  static const List<String> _morphOptions = ['选择', '过去分词', '现在分词', '名词', '形容词', '动词', '副词', '比较级', '最高级'];
  String _morphSelect = _morphOptions.first;
  String _morphInput = '';

  Widget _textFiledForm({
    String text,
    String labelText,
    Widget suffixIcon,
    Function(String) onChanged,
    Function(String) validator
  }) =>
    TextFormField(
      controller: TextEditingController(text: text),
      maxLines: 1,
      style: _textStyle,
      decoration: InputDecoration(
        //isDense: true,
        //contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
        labelText: labelText,
        border: OutlineInputBorder(),
        suffixIcon: suffixIcon,
      ),
      onChanged: (v) => onChanged != null ? onChanged(v.trim()) : null,
      validator: (v) => validator != null ? validator(v.trim()) : null,
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    _textFiledForm(
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
                    _textFiledForm(
                      text: widget.word.voiceUs,
                      labelText: '音标(美)',
                      onChanged: (v) => widget.word.voiceUs = v,
                    ),
                    _textFiledForm(
                      text: widget.word.voiceUk,
                      labelText: '音标(英)',
                      onChanged: (v) => widget.word.voiceUk = v,
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
                      keyboardType: TextInputType.number, // 键盘回车键的样式
                      textInputAction: TextInputAction.next,
                      controller: TextEditingController(text: widget.word.origin),
                      maxLines: null,
                      style: _textStyle,
                      decoration: InputDecoration(
                        labelText: "词源",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (v) => widget.word.origin = v.trim(),
                      //validator: (v) => v.trim().isNotEmpty ? null : "不能为空",
                    ),
                    TextFormField(
                      autofocus: false,
                      keyboardType: TextInputType.number, // 键盘回车键的样式
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
                          onDeleted: () => setState(() => widget.word.synonym.remove(e)),
                        )).toList(),
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
                          onDeleted: () => setState(() => widget.word.antonym.remove(e)),
                        )).toList(),
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
                      labelText: '释义',
                      children: widget.word.paraphraseSet.map<Widget>((e) =>
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
                                p = (await Navigator.pushNamed(context, '/edit_paraphrase', arguments: {'title':'编辑${widget.word.name}的释义', 'paraphrase': ParaphraseSerializer().from(p)})) as ParaphraseSerializer;
                                if(p != null) {
                                  await e.from(p).save();
                                }
                              }
                              setState((){});
                            },
                          ),
                          onDeleted: () => setState(() => widget.word.antonym.remove(e)),
                        )).toList(),
                      suffix: TextButton(
                        child: Text('添加'),
                        onPressed: () async {
                          var p = (await Navigator.pushNamed(context, '/edit_paraphrase', arguments: {'title':'给${widget.word.name}添加释义'})) as ParaphraseSerializer;
                          if(p != null) {
                            bool ret = await p.save();
                            if(ret) {
                              setState(() => widget.word.paraphraseSet.add(p));
                            }
                          }
                        },
                      ),
                    ),
                    WrapOutline(
                      labelText: '常用句型',
                      children: widget.word.sentencePatternSet.map<Widget>((e) =>
                        Tag(
                          label: InkWell(
                            child: Text('${e.content}', style: TextStyle(color: Colors.amberAccent)),
                            onTap: () async {
                              var s = SentencePatternSerializer()..id = e.id;
                              bool ret = await s.retrieve();
                              if(ret) {
                                s = (await Navigator.pushNamed(context, '/edit_sentence_pattern', arguments: {'title':'编辑${widget.word.name}的常用句型', 'sentence_pattern': SentencePatternSerializer().from(s)})) as SentencePatternSerializer;
                                if(s != null) {
                                  await e.from(s).save();
                                }
                              }
                              setState((){});
                            },
                          ),
                          onDeleted: () => setState(() => widget.word.sentencePatternSet.remove(e)),
                        )).toList(),
                      suffix: TextButton(
                            child: Text('添加',),
                            onPressed: () async {
                              var s = (await Navigator.pushNamed(context, '/edit_sentence_pattern', arguments: {'title':'给${widget.word.name}添加常用句型'})) as SentencePatternSerializer;
                              if(s != null) {
                                bool ret = await s.save();
                                if(ret) {
                                  setState(() => widget.word.sentencePatternSet.add(s));
                                }
                              }
                            },
                          ),
                    ),
                    WrapOutline(
                      labelText: '相关语法',
                      children: widget.word.grammarSet.map<Widget>((e) =>
                        Tag(
                          label: InkWell(
                            child: Text('${e.id}', style: TextStyle(color: Colors.amberAccent)),
                            onTap: () async {
                              var g = GrammarSerializer()..id = e.id;
                              bool ret = await g.retrieve();
                              if(ret) {
                                g = (await Navigator.pushNamed(context, '/edit_grammar', arguments: {'title':'编辑${widget.word.name}的相关语法', 'grammar': GrammarSerializer().from(g)})) as GrammarSerializer;
                                if(g != null) {
                                  await e.from(g).save();
                                }
                              }
                              setState((){widget.word.grammarSet.add(g);});
                            },
                          ),
                          onDeleted: () => setState(() => widget.word.grammarSet.remove(e)),
                        )).toList(),
                      suffix: TextButton(
                        child: Text('添加',),
                        onPressed: () async {
                          var g = (await Navigator.pushNamed(context, '/edit_grammar', arguments: {'title':'给${widget.word.name}添加相关语法'})) as GrammarSerializer;
                          if(g != null) {
                            bool ret = await g.save();
                            if(ret) {
                              setState(() => widget.word.grammarSet.add(g));
                            }
                          }
                        },
                      ),
                    ),
                    WrapOutline(
                      labelText: '词义辨析',
                      children: widget.word.distinguishSet.map<Widget>((e) =>
                        Tag(
                          label: InkWell(
                            child: Text('${e.id}', style: TextStyle(color: Colors.amberAccent)),
                            onTap: () async {
                              var d = DistinguishSerializer()..id = e.id;
                              bool ret = await d.retrieve();
                              if(ret) {
                                d = (await Navigator.pushNamed(context, '/edit_distinguish', arguments: {'title':'编辑${widget.word.name}的词义辨析', 'distinguish': DistinguishSerializer().from(d)})) as DistinguishSerializer;
                                if(d != null) {
                                  await e.from(d).save();
                                }
                              }
                              setState((){});
                            },
                          ),
                          onDeleted: () => setState(() => widget.word.distinguishSet.remove(e)),
                        )).toList(),
                      suffix: TextButton(
                        child: Text('添加',),
                        onPressed: () async {
                          var d = (await Navigator.pushNamed(context, '/edit_distinguish', arguments: {'title':'给${widget.word.name}添加词义辨析'})) as DistinguishSerializer;
                          if(d != null) {
                            bool ret = await d.save();
                            if(ret) {
                              setState(() => widget.word.distinguishSet.add(d));
                            }
                          }
                        },
                      ),
                    ),
                    WrapOutline(
                      labelText: '相关图片',
                      children: [
                        Text(widget.word.image.url ?? ''),
                        //_testImagePath != null ? Image.network(_testImagePath) : Text(''),
                        //_testImage != null ? Image.file(_testImage) : Text(''),
                      ],
                      suffix: TextButton(
                        child: Text('添加',),
                        onPressed: () async {
                          var result = await FilePicker.platform.pickFiles(
                            type: FileType.image,
                            allowMultiple: true,
                            withReadStream: true, // this will return PlatformFile object with read stream
                          );
                          if (result == null) return;
                          //var objFile = result.files.single;
                          for(var f in result.files)
                            print('--- ${f.path} ${f.name} ${f.size}');
                          // 注意: 需要使用 'package::dio/dio.dart';中的 MultipartFile
                          //widget.word.imageMpFile = MultipartFile(objFile.readStream, objFile.size, filename: objFile.name);
                          //print('--- ${widget.word.imageMpFile.filename}');
                          //widget.word.image = objFile.name;
                          setState(() {});
                        },
                      ),
                    ),
                    WrapOutline(
                      labelText: '相关视频',
                      children: [
                        Text(widget.word.vedio.url ?? ''),
                        //_testImagePath != null ? Image.network(_testImagePath) : Text(''),
                        //_testImage != null ? Image.file(_testImage) : Text(''),
                      ],
                      suffix: TextButton(
                        child: Text('添加',),
                        onPressed: () async {
                          var result = await FilePicker.platform.pickFiles(
                            type: FileType.video,
                            withReadStream: true, // this will return PlatformFile object with read stream
                          );
                          if (result == null) return;
                          var objFile = result.files.first;
                          for(var f in result.files)
                            print('--- ${f.path} ${f.name} ${f.size}');

                          // 注意: 需要使用 'package::dio/dio.dart';中的 MultipartFile
                          //widget.word.vedioMpFile = MultipartFile(objFile.readStream, objFile.size, filename: objFile.name);
                          //print('--- ${widget.word.vedioMpFile.filename}');
                          //widget.word.vedio = objFile.name;
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
              contentPadding: EdgeInsets.fromLTRB(10,10,10,10),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DropdownButton(
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
