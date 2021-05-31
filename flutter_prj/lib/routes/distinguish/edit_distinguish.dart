import 'package:flutter/material.dart';
import 'package:flutter_prj/serializers/distinguish.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/Tag.dart';
import 'package:flutter_prj/widgets/column_space.dart';
import 'package:flutter_prj/widgets/wrap_custom.dart';


class EditDistinguish extends StatefulWidget {
  final String _title;
  final DistinguishSerializer _distinguish;

  EditDistinguish({Key key, String title, DistinguishSerializer distinguish})
    : _title = title,
      _distinguish = distinguish ?? DistinguishSerializer(),
      super(key:key);

  @override
  _EditDistinguishState createState() => _EditDistinguishState();
}

class _EditDistinguishState extends State<EditDistinguish> {
  final GlobalKey _formKey =  GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      Navigator.pop(context, widget._distinguish);
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
              child: Form(
                key: _formKey, //设置globalKey，用于后面获取FormState
                autovalidateMode: AutovalidateMode.always, //开启自动校验
                child: ColumnSpace(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  divider: SizedBox(height: 20,),
                  children: [
                    TextFormField(
                      autofocus: false,
                      initialValue: widget._distinguish.id.toString(),
                      keyboardType: TextInputType.number, // 键盘回车键的样式
                      textInputAction: TextInputAction.next,
                      maxLines: 1,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        labelText: "id",
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          splashRadius: 1.0,
                          icon: Icon(Icons.search),
                          tooltip: '搜索',
                          onPressed: () async {
                            bool ret = await widget._distinguish.retrieve();
                            if(ret) setState((){});
                          },
                        ),
                      ),
                      onChanged: (v) => widget._distinguish.id = num.parse(v.trim()),
                      //validator: (v) => v.trim().isNotEmpty ? null : "不能为空",
                    ),
                    WrapOutline(
                      children: widget._distinguish.wordsForeign.map((e) =>
                        Tag(
                          label: InkWell(
                            child: Text('$e', style: TextStyle(fontSize: 14, color: Colors.blueAccent)),
                            onTap: () async {
                              var w = WordSerializer()..name = e;
                              await w.retrieve();
                              var word = (await Navigator.pushNamed(context,
                                                                    '/edit_word',
                                                                    arguments: {'title': '编辑单词',
                                                                                'word': WordSerializer().from(w)})
                                          ) as WordSerializer;
                              if(word != null) await word.save();
                            },
                          ),
                          onDeleted: () {
                            widget._distinguish.wordsForeign.remove(e);
                            setState(() {});
                          },
                        )
                      ).toList(),
                      labelText: '辨析单词',
                      suffix: TextButton(
                        child: Text('添加',),
                        onPressed: () async {
                          var word = (await Navigator.pushNamed(context,
                                                                '/edit_word',
                                                                arguments: {'title': '添加辨析单词'})
                                     ) as WordSerializer;
                          if(word != null && word.name.isNotEmpty) {
                            var ret = await word.save();
                            if(ret) widget._distinguish.wordsForeign.add(word.name);
                              setState(() {});
                          }
                        }
                      ),
                    ),
                    ListOutline(
                      labelText: '辨析句子',
                      children: widget._distinguish.sentencePatternForeignSet.map((e) =>
                        Tag(
                          label: InkWell(
                            child: Text('${e.content}', style: TextStyle(fontSize: 14, color: Colors.blueAccent)),
                            onTap: () async {
                              var sp = (await Navigator.pushNamed(context,
                                                   '/edit_sentence_pattern',
                                                    arguments: {'title':'编辑常用句型',
                                                    'sentence_pattern': SentencePatternSerializer().from(e)})
                                        ) as SentencePatternSerializer;
                              if(sp != null) {
                                e.from(sp);
                                setState(() {});
                              }
                            },
                          ),
                          onDeleted: () {
                            widget._distinguish.sentencePatternForeign.remove(e.id);
                            widget._distinguish.sentencePatternForeignSet.remove(e);
                            setState(() {});
                          },
                        )
                      ).toList(),
                      suffix: TextButton(
                        child: Text('添加',),
                        onPressed: () async {
                          var sp = (await Navigator.pushNamed(context,
                                                              '/edit_sentence_pattern',
                                                              arguments:{'title':'添加常用句型'})
                                   ) as SentencePatternSerializer;
                          if(sp != null) {
                            await sp.save();
                            widget._distinguish.sentencePatternForeign.add(sp.id);
                            widget._distinguish.sentencePatternForeignSet.add(sp);
                            setState(() {});
                          }
                        }
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      controller: TextEditingController(text: widget._distinguish.content),
                      minLines: 1,
                      maxLines: null,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        labelText: "内容(markdown)",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (v) => widget._distinguish.content = v.trim(),
                      //validator: (v) => v.trim().isNotEmpty ? null : "不能为空",
                    ),
                    WrapOutline(
                      labelText: '相关图片',
                      children: [
                        SelectableText(widget._distinguish.image.mptFile?.filename ?? (widget._distinguish.image.url)),
                      ],
                      suffix: TextButton(
                        child: Text('添加',),
                        onPressed: () async {
                          await widget._distinguish.image.pick();
                          setState(() {});
                        },
                      ),
                    ),
                    WrapOutline(
                      labelText: '相关视频',
                      children: [
                        SelectableText(widget._distinguish.vedio.mptFile?.filename ?? (widget._distinguish.vedio.url)),
                      ],
                      suffix: TextButton(
                        child: Text('添加',),
                        onPressed: () async {
                          await widget._distinguish.vedio.pick();
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
}
