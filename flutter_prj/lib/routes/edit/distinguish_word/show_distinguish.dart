import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/markdown/markdown.dart';
import 'package:flutter_prj/routes/edit/common/utils.dart';
import 'package:flutter_prj/serializers/distinguish.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/column_space.dart';
import 'package:flutter_prj/widgets/row_space.dart';
import 'package:flutter_prj/widgets/vedio_player.dart';


class ShowDistinguishPage extends StatelessWidget {
  ShowDistinguishPage({Key key, this.title, this.distinguish}) : super(key: key);

  final String title;
  final DistinguishSerializer distinguish;

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
        child: distinguishShow(context, null, distinguish, null),
      ),
    );
}

Widget distinguishShow(BuildContext context, num index, DistinguishSerializer ds, Function update) =>
  ColumnSpace(
    crossAxisAlignment: CrossAxisAlignment.start,
    divider: SizedBox(height: 8,),
    children: [
      RowSpace(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          index != null ?
          SelectableText(
            '$index. ',
            style: TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.bold, height: 1),
          ) : null,
          RowSpace(
            divider: Text(', '),
            children: ds.wordsForeign.map((e) => 
              InkWell(
                child: Text(e, style: TextStyle(fontSize: 12, color: Colors.blueAccent, fontWeight: FontWeight.bold)),
                onTap: () async {
                  var w = WordSerializer()..name = e;
                  bool ret = await w.retrieve();
                  if(ret) {
                    Navigator.pushNamed(context, '/show_word', arguments: {'title': '$e', 'word': w});
                  }
                },
              )
            ).toList() + ds.sentencesForeign.map((e) =>
              InkWell(
                child: Text(e.en, style: TextStyle(fontSize: 12, color: Colors.blueAccent, fontWeight: FontWeight.bold)),
                onTap: () async {
                  },
              )
            ).toList(),
          ),
          SizedBox(width: 8.0,),
          update != null ?
          InkWell(
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Icon(Icons.star, color: isFavoriteDistinguish(ds.id) == false ? Colors.black54 : Colors.redAccent, size: 14),
            onTap: () async {
              if(!isFavoriteDistinguish(ds.id)) {
                Global.localStore.user.studyPlan.distinguishes.add(ds.id);
              } else {
                Global.localStore.user.studyPlan.distinguishes.remove(ds.id);
              }
              await Global.localStore.user.studyPlan.save();
              Global.saveLocalStore();
              update();
            }
          ) : null,
        ],
      ),
      ds.content != null ?
      Padding(
        padding: EdgeInsets.only(left: 14),
        child: MarkDown(text:ds.content).render()
      ) : null,
      ds.vedio.url != null ?
      Align(
        alignment: Alignment.center,
        child: VedioPlayerWeb(url: ds.vedio.url),
      ) : null,
    ],
  );


Widget distinguishItem({BuildContext context, DistinguishSerializer distinguish, Widget trailing}) {
  String title = distinguish.wordsForeign.join(', ') + '  ' + distinguish.sentencesForeign.map((e) => e.en).join(',');
  return ListTile(
    dense: true,
    horizontalTitleGap: 0,
    minVerticalPadding: 0,
    minLeadingWidth: 30,
    contentPadding: EdgeInsets.only(left: 14, right: 14, top: 0, bottom: 0),
    leading: Text('${distinguish.id}', style: TextStyle(fontSize: 14, color: Colors.black54),),
    title: Text(title, style: TextStyle(fontSize: 14, color: Colors.black87)),
    trailing: trailing,
    onTap: () => Navigator.pushNamed(context, '/show_distinguish', arguments: {'title': '词义辨析', 'distinguish': distinguish}),
  );
}
