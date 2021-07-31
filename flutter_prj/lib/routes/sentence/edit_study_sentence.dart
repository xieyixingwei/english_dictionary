import 'package:flutter/material.dart';
import 'package:flutter_prj/widgets/Tag.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/column_space.dart';
import 'package:flutter_prj/widgets/wrap_custom.dart';


class EditStudySentencePage extends StatefulWidget {

  EditStudySentencePage({Key key, this.title, this.studySentence}): super(key:key);
  final String title;
  final StudySentenceSerializer studySentence;

  @override
  _EditStudySentencePageState createState() => _EditStudySentencePageState();
}

class _EditStudySentencePageState extends State<EditStudySentencePage> {
  final GlobalKey _formKey =  GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        leading: TextButton(
          child: Text('取消', style: TextStyle(color: Colors.white),),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            child: Text('确定', style: TextStyle(color: Colors.white),),
            onPressed: () {
              if((_formKey.currentState as FormState).validate()) // 验证各个表单字段是否合法
                Navigator.pop(context, widget.studySentence);
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
              Text(
                widget.studySentence.sentence.en,
                style: TextStyle(fontSize: 14, color: Colors.black87)
              ),
              WrapOutline(
                labelText: '生词',
                children: widget.studySentence.newWords.map<Widget>((e) =>
                  Tag(
                    label: InkWell(
                      child: Text(e.name, style: TextStyle(fontSize: 14, color: Colors.blueAccent)),
                      onTap: () async {
                        var w = (await Navigator.pushNamed(context,
                                                          '/edit_word',
                                                          arguments: {
                                                            'title': '编辑近义词',
                                                            'word': WordSerializer().from(e)})
                                ) as WordSerializer;
                        if(w != null) {
                          await e.from(w).save();
                          setState(() {});
                        }
                      },
                    ),
                    onDeleted: () => setState(() => widget.studySentence.newWords.remove(e)),
                  )
                ).toList(),
                suffix: TextButton(
                  child: Text('添加',),
                  onPressed: () async {
                    var w = (await Navigator.pushNamed(context,
                                                      '/edit_word',
                                                      arguments: {'title': '添加近义词'})
                              ) as WordSerializer;
                    if(w != null) {
                      var ret = await w.save();
                      if(ret) widget.studySentence.newWords.add(w);
                      setState(() {});
                    }
                  },
                ),
              ),
              ListOutline(
                labelText: '固定表达',
                children: widget.studySentence.newSentencePatterns.map<Widget>((e) =>
                  Tag(
                    label: InkWell(
                      child: Text('${e.content}', style: TextStyle(fontSize: 14, color: Colors.blueAccent)),
                      onTap: () async {
                          var s = (await Navigator.pushNamed(context,
                                                            '/edit_sentence_pattern',
                                                            arguments: {'title':'编辑固定表达',
                                                                        'sentence_pattern': SentencePatternSerializer().from(e)})
                                  ) as SentencePatternSerializer;
                          if(s != null) {
                            await e.from(s).save();
                            setState(() {});
                          }
                      },
                    ),
                    onDeleted: () async {
                      widget.studySentence.newSentencePatterns.remove(e);
                      await widget.studySentence.save();
                      setState(() {});
                    }
                  )
                ).toList(),
                suffix: TextButton(
                  child: Text('添加',),
                  onPressed: () async {
                    var sp = (await Navigator.pushNamed(context,
                                                        '/edit_sentence_pattern',
                                                        arguments: {'title': '添加固定表达'})
                            ) as SentencePatternSerializer;
                    if(sp != null) {
                      var ret = await sp.save();
                      if(ret) widget.studySentence.newSentencePatterns.add(sp);
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
