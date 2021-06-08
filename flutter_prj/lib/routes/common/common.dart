import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/serializers/index.dart';


List<Map<String, List<ParaphraseSerializer>>> sortParaphraseSet(List<ParaphraseSerializer> paraphrases) {
  List<Map<String, List<ParaphraseSerializer>>> ret = [];
  paraphrases.forEach( (e) {
    var find = ret.singleWhere((ele) => ele.keys.first == e.partOfSpeech, orElse: () => null);
    find == null
          ? ret.add({e.partOfSpeech: [e]})
          : find.values.first.add(e);
  });
  return ret;
}

StudySentenceSerializer getStudySentence(num id) {
  if(Global.localStore.user.studySentenceSet.isEmpty)
    return null;
  return Global.localStore.user.studySentenceSet.singleWhere((e) => e.sentence==id, orElse: () => null);
}

StudyGrammarSerializer getStudyGrammar(num id) {
  if(Global.localStore.user.studyGrammarSet.isEmpty)
    return null;
  return Global.localStore.user.studyGrammarSet.singleWhere((e) => e.grammar==id, orElse: () => null);
}

bool isFavoriteDistinguish(num id) {
  return Global.localStore.user.studyPlan == null ? false : Global.localStore.user.studyPlan.distinguishes.contains(id);
}


Future<String> popSelectWordCategoryDialog(BuildContext context) async {
  var ctrl = TextEditingController();
  var res = await showDialog(
    context: context,
    builder: (context) =>
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          List<Widget> options = Global.localStore.user.studyPlan.wordCategory.map<Widget>((e) =>
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(width: 20,),
                Expanded(
                  child: InkWell(
                  child: Text(e),
                  onTap: () => Navigator.pop(context, e),
                )),
                IconButton(
                  icon: Icon(Icons.clear, color: Colors.black54, size: 18,),
                  tooltip: '删除',
                  splashRadius: 1.0,
                  onPressed: () async {
                    Global.localStore.user.studyPlan.wordCategory.remove(e);
                    Global.localStore.user.studyPlan.save();
                    Global.saveLocalStore();
                    var studyWord = StudyWordSerializer();
                    studyWord.filter.foreignUser = Global.localStore.user.id;
                    studyWord.filter.category = e;
                    var swes = await StudyWordSerializer().list();
                    swes.forEach((w) => w.delete());
                    setState(() {});
                  },
                ),
              ]
            ),
          ).toList();
          return SimpleDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('选择单词本'),
                TextButton(
                  child: Text('返回'),
                  onPressed: () => Navigator.pop(context),
                ),
              ]
            ),
            children: options + [
              Row(
                children: [
                  SizedBox(width: 20,),
                  Expanded(
                    child: TextField(
                      controller: ctrl,
                      decoration: InputDecoration(
                        isDense: true,
                      ),
                    ),
                  ),
                  TextButton(
                    child: Text('添加'),
                    onPressed: () {
                      if(ctrl.text.trim().isNotEmpty)
                        setState(() {
                          if(Global.localStore.user.studyPlan != null) Global.localStore.user.studyPlan.wordCategory.add(ctrl.text.trim());
                          if(Global.localStore.user.studyPlan != null) Global.localStore.user.studyPlan.save();
                          Global.saveLocalStore();
                        });
                      ctrl.text = '';
                    },
                  ),
                  SizedBox(width: 20,),
                ]
              )
            ],
          );
        },
    ),
  );

  return res;
}

Future<String> popSelectSentenceCategoryDialog(BuildContext context) async {
  var ctrl = TextEditingController();
  var res = await showDialog(
    context: context,
    builder: (context) =>
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          List<Widget> options = Global.localStore.user.studyPlan.sentenceCategory.map<Widget>((e) =>
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(width: 20,),
                Expanded(
                  child: InkWell(
                  child: Text(e),
                  onTap: () => Navigator.pop(context, e),
                )),
                IconButton(
                  icon: Icon(Icons.clear, color: Colors.black54, size: 18,),
                  tooltip: '删除',
                  splashRadius: 1.0,
                  onPressed: () => setState(() {
                    Global.localStore.user.studySentenceSet.where((w) => w.category == e).forEach((w) => w.delete());
                    Global.localStore.user.studySentenceSet.removeWhere((w) => w.category == e);
                    Global.localStore.user.studyPlan.sentenceCategory.remove(e);
                    Global.localStore.user.studyPlan.save();
                    Global.saveLocalStore();
                  }),
                ),
              ]
            ),
          ).toList();
          return SimpleDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('选择句子本'),
                TextButton(
                  child: Text('返回'),
                  onPressed: () => Navigator.pop(context),
                ),
              ]
            ),
            children: options + [
              Row(
                children: [
                  SizedBox(width: 20,),
                  Expanded(
                    child: TextField(
                      controller: ctrl,
                      decoration: InputDecoration(
                        isDense: true,
                      ),
                    ),
                  ),
                  TextButton(
                    child: Text('添加'),
                    onPressed: () {
                      if(ctrl.text.trim().isNotEmpty)
                        setState(() {
                          Global.localStore.user.studyPlan.sentenceCategory.add(ctrl.text.trim());
                          Global.localStore.user.studyPlan.save();
                          Global.saveLocalStore();
                        });
                      ctrl.text = '';
                    },
                  ),
                  SizedBox(width: 20,),
                ]
              )
            ],
          );
        },
    ),
  );
  return res;
}


Future<String> popSelectGrammarCategoryDialog(BuildContext context) async {
  var ctrl = TextEditingController();
  var res = await showDialog(
    context: context,
    builder: (context) =>
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          List<Widget> options = Global.localStore.user.studyPlan.grammarCategory.map<Widget>((e) =>
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(width: 20,),
                Expanded(
                  child: InkWell(
                  child: Text(e),
                  onTap: () => Navigator.pop(context, e),
                )),
                IconButton(
                  icon: Icon(Icons.clear, color: Colors.black54, size: 18,),
                  tooltip: '删除',
                  splashRadius: 1.0,
                  onPressed: () => setState(() {
                    Global.localStore.user.studyGrammarSet.where((w) => w.category == e).forEach((w) => w.delete());
                    Global.localStore.user.studyGrammarSet.removeWhere((w) => w.category == e);
                    Global.localStore.user.studyPlan.grammarCategory.remove(e);
                    Global.localStore.user.studyPlan.save();
                    Global.saveLocalStore();
                  }),
                ),
              ]
            ),
          ).toList();
          return SimpleDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('选择语法本'),
                TextButton(
                  child: Text('返回'),
                  onPressed: () => Navigator.pop(context),
                ),
              ]
            ),
            children: options + [
              Row(
                children: [
                  SizedBox(width: 20,),
                  Expanded(
                    child: TextField(
                      controller: ctrl,
                      decoration: InputDecoration(
                        isDense: true,
                      ),
                    ),
                  ),
                  TextButton(
                    child: Text('添加'),
                    onPressed: () {
                      if(ctrl.text.trim().isNotEmpty)
                        setState(() {
                          Global.localStore.user.studyPlan.grammarCategory.add(ctrl.text.trim());
                          Global.localStore.user.studyPlan.save();
                          Global.saveLocalStore();
                        });
                      ctrl.text = '';
                    },
                  ),
                  SizedBox(width: 20,),
                ]
              )
            ],
          );
        },
    ),
  );
  return res;
}
