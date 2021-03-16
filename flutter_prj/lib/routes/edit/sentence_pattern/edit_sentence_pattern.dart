import 'package:flutter/material.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/Tag.dart';
import 'package:flutter_prj/widgets/ok_cancel.dart';


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
          appBar: AppBar(
            title: Text(widget._title),
            automaticallyImplyLeading: false, // 取消返回按钮
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: Form(
              key: _formKey, //设置globalKey，用于后面获取FormState
              autovalidateMode: AutovalidateMode.always, //开启自动校验
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    autofocus: false,
                    keyboardType: TextInputType.number, // 键盘回车键的样式
                    textInputAction: TextInputAction.next,
                    controller: TextEditingController(text:widget._sentencePattern.content),
                    maxLines: 1,
                    style: textStyle,
                    decoration: InputDecoration(
                      labelText: "常用句型",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (v) => widget._sentencePattern.content = v.trim(),
                    validator: (v) => v.trim().isNotEmpty ? null : "不能为空",
                  ),
                  SizedBox(height: 20,),
                  Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: (<Widget>[Text('释义: ')] +
                        widget._sentencePattern.paraphraseSet.map<Widget>((e) =>
                          Tag(
                            label: InkWell(
                              child: Text('${e.interpret}', style: TextStyle(color: Colors.amberAccent)),
                              onTap: () async {
                                var paraphrase = (await Navigator.pushNamed(context, '/edit_paraphrase', arguments: {'title':'编辑常用句型的释义', 'paraphrase': ParaphraseSerializer().from(e)})) as ParaphraseSerializer;
                                if(paraphrase != null) {
                                  e.from(paraphrase);
                                }
                                setState((){});
                              },
                            ),
                            onDeleted: () {
                              e.delete();
                              setState(() => widget._sentencePattern.paraphraseSet.remove(e));
                            },
                          )).toList() + 
                          [TextButton(
                            child: Text('添加',style: TextStyle(color: Colors.blueAccent)),
                            onPressed: () async {
                              var paraphrase = (await Navigator.pushNamed(context, '/edit_paraphrase', arguments: {'title':'添加常用句型的释义'})) as ParaphraseSerializer;
                              if(paraphrase != null) {
                                  setState(() => widget._sentencePattern.paraphraseSet.add(paraphrase));
                              }
                            },
                          )]).where((e) => e != null).toList(),
                    ),
                  SizedBox(height: 20,),
                  OkCancel(ok: () {
                    if((_formKey.currentState as FormState).validate()) // 验证各个表单字段是否合法
                      Navigator.pop(context, widget._sentencePattern);
                  }),
                ]
            ),
          ),
        ),
    );
  }
}
