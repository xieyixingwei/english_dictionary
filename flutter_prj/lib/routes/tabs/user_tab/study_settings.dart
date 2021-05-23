import 'package:flutter/material.dart';
import 'package:flutter_prj/routes/common/appbar.dart';
import 'package:flutter_prj/routes/common/text_form_field.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/column_space.dart';


class StudySettings extends StatefulWidget {
  StudySettings({Key key, StudyPlanSerializer plan})
    : this.plan = plan??StudyPlanSerializer(), super(key:key);

  final StudyPlanSerializer plan;

  @override
  _StudySettingsState createState() => _StudySettingsState();
}

class _StudySettingsState extends State<StudySettings> {
  final GlobalKey _formKey =  GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: appBarOfSet(
        context: context,
        title: Text('设置学习计划'),
        ok: () async {
          if((_formKey.currentState as FormState).validate()) // 验证各个表单字段是否合法
              Navigator.pop(context, widget.plan);
          },
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
              textFiledForm(
                text: '${widget.plan.onceWords}',
                labelText: '每次学习的单词数量',
                keyboardType: TextInputType.number,
                onChanged: (v) => widget.plan.onceWords = num.parse(v),
                validator: (v) => v.isNotEmpty ? null : "不能为空",
              ),
              textFiledForm(
                text: '${widget.plan.onceSentences}',
                labelText: '每次学习的句子数量',
                onChanged: (v) => widget.plan.onceSentences = num.parse(v),
              ),
              textFiledForm(
                text: '${widget.plan.onceGrammers}',
                labelText: '每次学习的语法数量',
                onChanged: (v) => widget.plan.onceGrammers = num.parse(v),
              ),
            ],
        ),
        ),
      ),
    );
}
