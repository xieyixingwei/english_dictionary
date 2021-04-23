import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/serializers/grammar.dart';
import 'package:flutter_prj/widgets/pop_dialog.dart';
import 'package:flutter_prj/widgets/wrap_custom.dart';


class EditGrammar extends StatefulWidget {
  final String _title;
  final GrammarSerializer _grammar;

  EditGrammar({Key key, String title, GrammarSerializer grammar})
    : _title = title,
      _grammar = grammar ?? GrammarSerializer(),
      super(key:key);

  @override
  _EditGrammarState createState() => _EditGrammarState();
}

class _EditGrammarState extends State<EditGrammar> {
  final GlobalKey _formKey =  GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final idctrl = TextEditingController(text: widget._grammar.id.toString());
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
                      Navigator.pop(context, widget._grammar);
                  },
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
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
                      controller: idctrl,
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
                            var g = GrammarSerializer()..id = num.parse(idctrl.text.trim());
                            bool ret = await g.retrieve();
                            if(ret) setState(() => widget._grammar.from(g));
                          },
                        ),
                      ),
                      //onChanged: (v) => null,
                      //validator: (v) => v.trim().isNotEmpty ? null : "不能为空",
                    ),
                    SizedBox(height: 20,),
                    WrapOutlineTag(
                      data: widget._grammar.type,
                      labelText: '类型',
                      suffix: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            child: Text('添加',),
                            onPressed: () => popSelectDialog(
                              context: context,
                              title: Text('选择词根词缀'),
                              options: Global.grammarTypeOptions,
                              close: (v) => setState(() => widget._grammar.type.add(v)),
                            ),
                          ),
                          TextButton(
                            child: Text('编辑'),
                            onPressed: () => Navigator.pushNamed(context, '/edit_grammar_type'),
                          ),
                        ]
                      ),
                    ),
                    SizedBox(height: 20,),
                    WrapOutlineTag(
                      data: widget._grammar.tag,
                      labelText: 'Tag',
                      suffix: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            child: Text('添加',),
                            onPressed: () => popSelectDialog(
                              context: context,
                              title: Text('选择Tag'),
                              options: Global.grammarTagOptions,
                              close: (v) => setState(() => widget._grammar.tag.add(v)),
                            ),
                          ),
                          TextButton(
                            child: Text('编辑'),
                            onPressed: () => Navigator.pushNamed(context, '/edit_grammar_tag'),
                          ),
                        ]
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      autofocus: false,
                      keyboardType: TextInputType.number, // 键盘回车键的样式
                      textInputAction: TextInputAction.next,
                      controller: TextEditingController(text: widget._grammar.content),
                      minLines: 1,
                      maxLines: null,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        labelText: "语法",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (v) => widget._grammar.content = v.trim(),
                      validator: (v) => v.trim().isNotEmpty ? null : "不能为空",
                    ),
                  ]
              ),
          ),
        ),
      );
  }
}
