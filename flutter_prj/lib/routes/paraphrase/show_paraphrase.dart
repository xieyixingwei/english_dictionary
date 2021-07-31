import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/routes/common/common.dart';
import 'package:flutter_prj/routes/sentence/show_sentences.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/column_space.dart';
import 'package:flutter_prj/widgets/row_space.dart';


Widget paraphraseListShow(BuildContext context, List<ParaphraseSerializer> paraphraseSet, Function update) =>
  ColumnSpace(
    divider: SizedBox(height: 14,),
    children: sortParaphraseSet(paraphraseSet).map((e) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            e.keys.first,
            style: TextStyle(fontSize: 14, color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(12, 8, 0, 0),
            child: ColumnSpace(
              divider: SizedBox(height: 8,),
              children: e.values.first.asMap().map((i, v) =>
                MapEntry(i, _paraphraseShow(context, i+1, v, update))
              ).values.toList(),
            )
          ),
        ]
      )
    ).toList(),
  );

Widget _paraphraseShow(BuildContext context, int index, ParaphraseSerializer paraphrase, Function update) =>
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      RowSpace(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SelectableText(
            '$index. ',
            style: TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.bold, height: 1),
          ),
          SelectableText(
            paraphrase.interpret,
            style: TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.bold, height: 1),
          ),
          SizedBox(width: 8,),
          Global.localStore.user.uname == 'root' ?
          InkWell(
            child: Text('修改', style: TextStyle(fontSize: 12, color: Colors.blueAccent),),
            onTap: () async {
             var p = (await Navigator.pushNamed(
                                  context, '/edit_paraphrase',
                                  arguments: {
                                    'title':'编辑释义',
                                    'paraphrase': ParaphraseSerializer().from(paraphrase)})
                      ) as ParaphraseSerializer;
              if(p != null) {
                await paraphrase.from(p).save();
              }
              if(update != null) update();
            },
          ) : null,
        ],
      ),
      paraphrase.sentenceSet.isNotEmpty ? 
      Container(
        padding: EdgeInsets.only(left: 16, top: 8),
        child: sentenceSetShow(context, paraphrase.sentenceSet, update),
      ) : null,
    ].where((e) => e != null).toList(),
  );
