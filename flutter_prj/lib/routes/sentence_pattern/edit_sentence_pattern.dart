import 'package:flutter/material.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/Tag.dart';
import 'package:flutter_prj/widgets/column_space.dart';
import 'package:flutter_prj/widgets/wrap_custom.dart';


class EditSentencePattern extends StatefulWidget {
  final String _title;
  final SentencePatternSerializer _sentencePattern;

  EditSentencePattern({Key key, String title, SentencePatternSerializer sentencePattern})
    : _title = title,
      _sentencePattern = sentencePattern ?? SentencePatternSerializer(),
      super(key: key);

  @override
  _EditSentencePatternState createState() => _EditSentencePatternState();
}

class _EditSentencePatternState extends State<EditSentencePattern> {
  final GlobalKey _formKey =  GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(fontSize: 14,);
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
                    Navigator.pop(context, widget._sentencePattern);
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: Form(
              key: _formKey, //设置globalKey，用于后面获取FormState
              autovalidateMode: AutovalidateMode.always, //开启自动校验
              child: ColumnSpace(
                crossAxisAlignment: CrossAxisAlignment.start,
                divider: SizedBox(height: 20,),
                children: [
                  TextFormField(
                    autofocus: false,
                    keyboardType: TextInputType.number, // 键盘回车键的样式
                    textInputAction: TextInputAction.next,
                    controller: TextEditingController(text: widget._sentencePattern.id.toString()),
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
                          bool ret = await widget._sentencePattern.retrieve();
                          if(ret) setState((){});
                        },
                      ),
                    ),
                    onChanged: (v) => widget._sentencePattern.id = num.parse(v.trim()),
                    validator: (v) => v.trim().isNotEmpty ? null : "不能为空",
                  ),
                  TextFormField(
                    autofocus: false,
                    keyboardType: TextInputType.text, // 键盘回车键的样式
                    textInputAction: TextInputAction.next,
                    controller: TextEditingController(text:widget._sentencePattern.content),
                    maxLines: 1,
                    style: textStyle,
                    decoration: InputDecoration(
                      labelText: "固定表达",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (v) => widget._sentencePattern.content = v.trim(),
                    validator: (v) => v.trim().isNotEmpty ? null : "不能为空",
                  ),
                  ListOutline(
                    labelText: '释义(markdown)',
                    children: widget._sentencePattern.paraphraseSet.map<Widget>((e) =>
                      Tag(
                        label: InkWell(
                          child: Text('${e.partOfSpeech} ${e.interpret}', style: TextStyle(fontSize: 14, color: Colors.blueAccent)),
                          onTap: () async {
                            var p = (await Navigator.pushNamed(context,
                                                                        '/edit_paraphrase',
                                                                        arguments: {'title': '编辑固定表达的释义',
                                                                        'paraphrase': ParaphraseSerializer().from(e)})
                                              ) as ParaphraseSerializer;
                            if(p != null) {
                              e.from(p);
                              setState(() {});
                            }
                          },
                        ),
                        onDeleted: () {
                          e.delete();
                          widget._sentencePattern.paraphraseSet.remove(e);
                          setState(() {});
                        },
                      )).toList(),
                    suffix: TextButton(
                      child: Text('添加',),
                      onPressed: () async {
                        var p = (await Navigator.pushNamed(context,
                                                          '/edit_paraphrase',
                                                          arguments: {'title':'给固定表达添加释义'})
                                ) as ParaphraseSerializer;
                        if(p != null) {
                          widget._sentencePattern.paraphraseSet.add(p);
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
