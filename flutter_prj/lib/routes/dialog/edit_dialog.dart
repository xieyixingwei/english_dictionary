import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/Tag.dart';
import 'package:flutter_prj/widgets/column_space.dart';
import 'package:flutter_prj/widgets/pop_dialog.dart';
import 'package:flutter_prj/widgets/wrap_custom.dart';


class EditDialog extends StatefulWidget {
  EditDialog({Key key, this.title, this.dialog}) : super(key:key);

  final String title;
  final DialogSerializer dialog;

  @override
  _EditDialogState createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
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
                      Navigator.pop(context, widget.dialog);
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
                      initialValue: widget.dialog.id.toString(),
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
                            bool ret = await widget.dialog.retrieve();
                            if(ret) setState((){});
                          },
                        ),
                      ),
                      onChanged: (v) => widget.dialog.id = num.parse(v.trim()),
                      //validator: (v) => v.trim().isNotEmpty ? null : "不能为空",
                    ),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      controller: TextEditingController(text: widget.dialog.title),
                      minLines: 1,
                      maxLines: null,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        labelText: "标题",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (v) => widget.dialog.title = v.trim(),
                      validator: (v) => v.trim().isNotEmpty ? null : "不能为空",
                    ),
                    WrapOutlineTag(
                      data: widget.dialog.tag,
                      labelText: 'Tag',
                      suffix: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            child: Text('添加',),
                            onPressed: () => popSelectDialog(
                              context: context,
                              title: Text('选择Tag'),
                              options: Global.dialogTagOptions,
                              close: (v) => setState(() => widget.dialog.tag.add(v)),
                            ),
                          ),
                          TextButton(
                            child: Text('编辑'),
                            onPressed: () => Navigator.pushNamed(context, '/edit_dialog_tag'),
                          ),
                        ]
                      )
                    ),
                    ListOutline(
                    labelText: '例句',
                    children: widget.dialog.sentenceSet.asMap().map((i, e) => MapEntry(i,
                      Tag(
                        label: InkWell(
                          child: ConstrainedBox(
                            child: Text('${e.id}: ${e.en}', overflow: TextOverflow.ellipsis, style: TextStyle(color: i % 2 == 0 ? Colors.blueAccent : Colors.blueGrey)),
                            constraints: BoxConstraints(maxWidth: 230.0),
                          ),
                          onTap: () async {
                            var s = (await Navigator.pushNamed(context,
                                                              '/edit_sentence',
                                                              arguments: {'title':'编辑释义的例句',
                                                              'sentence': SentenceSerializer().from(e)})
                                    ) as SentenceSerializer;
                            if(s != null) {
                              e.from(s);
                              setState(() {});
                            }
                          },
                        ),
                        onDeleted: () {
                          e.delete();
                          widget.dialog.sentenceSet.remove(e);
                          setState(() {});
                        }
                      ))
                      ).values.toList(),
                      suffix: TextButton(
                        child: Text('添加',),
                        onPressed: () async {
                          var s = (await Navigator.pushNamed(context,
                                                             '/edit_sentence',
                                                             arguments: {'title':'添加例句'})
                                  ) as SentenceSerializer;
                          if(s != null) {
                            var ret = await s.save();
                            if(ret)
                              widget.dialog.sentenceSet.add(s);
                            setState(() {});
                          }
                        },
                      ),
                    ),
                    ListOutline(
                    labelText: '对话例句',
                    children: widget.dialog.dialogSentences.asMap().map((i, e) {
                      var sentence = widget.dialog.sentenceSet.singleWhere((s) => s.id == e);
                      return MapEntry(i,
                      Tag(
                        label: InkWell(
                          child: ConstrainedBox(
                            child: Text('${sentence.en}', overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.blueAccent)),
                            constraints: BoxConstraints(maxWidth: 230.0),
                          ),
                          onTap: () async {
                            var s = (await Navigator.pushNamed(context,
                                                              '/edit_sentence',
                                                              arguments: {'title':'编辑释义的例句',
                                                              'sentence': SentenceSerializer().from(sentence)})
                                    ) as SentenceSerializer;
                            if(s != null) {
                              sentence.from(s);
                              setState(() {});
                            }
                          },
                        ),
                        onDeleted: () {
                          widget.dialog.dialogSentences.remove(e);
                          setState(() {});
                        }
                      ));
                      }).values.toList(),
                      suffix: TextButton(
                        child: Text('添加',),
                        onPressed: () async {
                          var s = (await Navigator.pushNamed(context,
                                                             '/edit_sentence',
                                                             arguments: {'title':'添加例句'})
                                  ) as SentenceSerializer;
                          if(s != null) {
                            widget.dialog.dialogSentences.add(s.id);
                            setState(() {});
                          }
                        },
                      ),
                    ),
                    WrapOutline(
                      labelText: '相关视频',
                      children: [
                        SelectableText(widget.dialog.vedio.mptFile?.filename ?? (widget.dialog.vedio.url)),
                      ],
                      suffix: TextButton(
                        child: Text('添加',),
                        onPressed: () async {
                          await widget.dialog.vedio.pick();
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
