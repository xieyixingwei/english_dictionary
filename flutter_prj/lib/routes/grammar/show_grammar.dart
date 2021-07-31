import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/markdown/markdown.dart';
import 'package:flutter_prj/routes/common/common.dart';
import 'package:flutter_prj/serializers/grammar.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/column_space.dart';
import 'package:flutter_prj/widgets/row_space.dart';
import 'package:flutter_prj/widgets/vedio_player.dart';


class ShowGrammarPage extends StatelessWidget {
  ShowGrammarPage({Key key, this.title, this.grammar}) : super(key: key);

  final String title;
  final GrammarSerializer grammar;

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
        child: grammarShow(context, null, grammar, null),
      ),
    );
}

Widget grammarShow(BuildContext context, num index, GrammarSerializer grammar, Function update) =>
  ColumnSpace(
    crossAxisAlignment: CrossAxisAlignment.start,
    divider: SizedBox(height: 8,),
    children: [
      RowSpace(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          index != null ? SelectableText(
            '$index. ',
            style: TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.bold, height: 1),
          ) : null,
          SizedBox(width: 2,),
          SelectableText(
            grammar.title,
            style: TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.bold, height: 1),
          ),
          SizedBox(width: 8,),
          SelectableText(
            grammar.type.join('/'),
            style: TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.bold, height: 1),
          ),
          SizedBox(width: 8,),
          SelectableText(
            grammar.tag.join('/'),
            style: TextStyle(fontSize: 10, color: Colors.black54, height: 1),
          ),
          SizedBox(width: 8,),
          update != null ?
          InkWell(
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Icon(Icons.star, color: getStudyGrammar(grammar.id) == null ? Colors.black54 : Colors.redAccent, size: 14),
            onTap: () async {
              var sg = getStudyGrammar(grammar.id);
              if(sg == null) {
                var category = await popSelectGrammarCategoryDialog(context);
                if(category == null) return;
                var newSg = StudyGrammarSerializer()..grammar = grammar.id
                                                ..foreignUser = Global.localStore.user.id
                                                ..category = category;
                Global.localStore.user.studyGrammarSet.add(newSg);
                await newSg.save();
              } else {
                await sg.delete();
                Global.localStore.user.studyGrammarSet.remove(sg);
              }
              Global.saveLocalStore();
              update();
            },
          ) : null,
        ],
      ),
      grammar.content.isNotEmpty ?
      Padding(
        padding: EdgeInsets.only(left: 14),
        child: MarkDown(text: grammar.content).render(),
      ) : null,
      grammar.vedio.url.isNotEmpty ?
      Align(
        alignment: Alignment.center,
        child: VedioPlayerWeb(url: grammar.vedio.url),
      ) : null,
    ],
  );

Widget grammarItem({BuildContext context, GrammarSerializer grammar, Widget trailing}) {
  Widget title = Text.rich(
    TextSpan(
        children: [
          TextSpan(text: '${grammar.title}', style: TextStyle(fontSize: 14, color: Colors.black87)),
          grammar.type.isNotEmpty ? TextSpan(text: '    ${grammar.type.join('/')}', style: TextStyle(fontSize: 10, color: Colors.black45)) : null,
          TextSpan(text: '    ${grammar.tag.join('/')}', style: TextStyle(fontSize: 10, color: Colors.black45)),
        ].where((e) => e != null).toList()
      )
  );

  return ListTile(
    dense: true,
    horizontalTitleGap: 0,
    minVerticalPadding: 0,
    minLeadingWidth: 30,
    contentPadding: EdgeInsets.only(left: 14, right: 14, top: 0, bottom: 0),
    leading: Text('${grammar.id}', style: TextStyle(fontSize: 14, color: Colors.black54),),
    title: title,
    trailing: trailing,
    onTap: () => Navigator.pushNamed(context, '/show_grammar', arguments: {'title': '语法', 'grammar': grammar}),
  );
}
