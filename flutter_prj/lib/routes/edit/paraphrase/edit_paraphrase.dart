import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/Tag.dart';
import 'package:flutter_prj/widgets/wrap_custom.dart';


class EditParaphrase extends StatefulWidget {
  final String _title;
  final ParaphraseSerializer _paraphrase;

  EditParaphrase({Key key, String title, ParaphraseSerializer paraphrase})
    : _title = title,
      _paraphrase = paraphrase ?? ParaphraseSerializer(),
      super(key: key);

  @override
  _EditParaphraseState createState() => _EditParaphraseState();
}

class _EditParaphraseState extends State<EditParaphrase> {
  final GlobalKey _formKey =  GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if(widget._paraphrase.partOfSpeech.isEmpty)
      widget._paraphrase.partOfSpeech = Global.partOfSpeechOptions.first;
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(fontSize: 14,);
    return Scaffold(
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
                    Navigator.pop(context, widget._paraphrase);
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: Form(
              key: _formKey, //设置globalKey，用于后面获取FormState
              autovalidateMode: AutovalidateMode.always, //开启自动校验
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField(
                    autofocus: false,
                    value: widget._paraphrase.partOfSpeech,
                    items: Global.partOfSpeechOptions.map((e)=>DropdownMenuItem(child: Text(e), value: e,)).toList(),
                    decoration: InputDecoration(
                      prefixText: '词性:  ',
                      prefixStyle: TextStyle(fontSize: 14, color: Color.fromRGBO(132,132,132,1.0)),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (v) => setState(() => widget._paraphrase.partOfSpeech = v),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    autofocus: false,
                    keyboardType: TextInputType.number, // 键盘回车键的样式
                    textInputAction: TextInputAction.next,
                    controller: TextEditingController(text:widget._paraphrase.interpret),
                    maxLines: null,
                    style: textStyle,
                    decoration: InputDecoration(
                      labelText: "释义",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (v) => widget._paraphrase.interpret = v.trim(),
                    validator: (v) => v.trim().isNotEmpty ? null : "不能为空",
                  ),
                  SizedBox(height: 20,),
                  WrapOutline(
                    labelText: '例句',
                    children: widget._paraphrase.sentenceSet.map<Widget>((e) =>
                      Tag(
                        label: InkWell(
                          child: Text('${e.id}', style: TextStyle(color: Colors.black87)),
                          onTap: () async {
                            var sentence = (await Navigator.pushNamed(context, '/edit_sentence', arguments: {'title':'编辑释义的例句', 'sentence': SentenceSerializer().from(e)})) as SentenceSerializer;
                            if(sentence != null) {
                              e.from(sentence);
                            }
                            setState((){});
                          },
                        ),
                        onDeleted: () => setState(() => widget._paraphrase.sentenceSet.remove(e)),
                      )).toList(),
                      suffix: TextButton(
                        child: Text('添加',),
                        onPressed: () async {
                          var sentence = (await Navigator.pushNamed(context, '/edit_sentence', arguments: {'title':'添加例句'})) as SentenceSerializer;
                          if(sentence != null) {
                              setState(() => widget._paraphrase.sentenceSet.add(sentence));
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
