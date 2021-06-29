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

StudyGrammarSerializer getStudyGrammar(num id) {
  if(Global.localStore.user.studyGrammarSet.isEmpty)
    return null;
  return Global.localStore.user.studyGrammarSet.singleWhere((e) => e.grammar==id, orElse: () => null);
}

bool isFavoriteDistinguish(num id) {
  return Global.localStore.user.studyPlan == null ? false : Global.localStore.user.studyPlan.distinguishes.contains(id);
}


Future<String> popSelectWordCategoryDialog(BuildContext context, List<String> categories) async {
  var ctrl = TextEditingController();
  var res = await showDialog(
    context: context,
    builder: (context) =>
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          List<Widget> options = Global.localStore.user.studyPlan.wordCategories.map<Widget>((e) =>
            Container(
              margin: EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(width: 20,),
                  Expanded(
                    child: InkWell(
                    child: Text('${categories.contains(e) ? "* " : "  "}$e'),
                    onTap: () => Navigator.pop(context, e),
                  )),
                  InkWell(
                    child: Icon(Icons.clear, color: Colors.black54, size: 18,),
                    onDoubleTap: () async {
                      Global.localStore.user.studyPlan.wordCategories.remove(e);
                      Global.localStore.user.studyPlan.save();
                      Global.saveLocalStore();
                      var studyWord = StudyWordSerializer();
                      studyWord.filter.foreignUser = Global.localStore.user.id;
                      studyWord.filter.categories__icontains = e;
                      var swes = await studyWord.list();
                      swes.forEach((w) => w.delete());
                      setState(() {});
                    },
                  ),
                  SizedBox(width: 20,),
                ]
              ),
            )
          ).toList();
          return SimpleDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('选择单词收藏夹'),
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
                          Global.localStore.user.studyPlan.wordCategories.add(ctrl.text.trim());
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

Future<String> popSelectSentenceCategoryDialog(BuildContext context, List<String> categories) async {
  var ctrl = TextEditingController();
  var res = await showDialog(
    context: context,
    builder: (context) =>
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          List<Widget> options = Global.localStore.user.studyPlan.sentenceCategories.map<Widget>((e) =>
            Container(
              margin: EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(width: 20,),
                  Expanded(
                    child: InkWell(
                    child: Text('${categories.contains(e) ? "* " : "  "}$e'),
                    onTap: () => Navigator.pop(context, e),
                  )),
                  InkWell(
                    child: Icon(Icons.clear, color: Colors.black54, size: 18,),
                    onDoubleTap: () async {
                      Global.localStore.user.studyPlan.sentenceCategories.remove(e);
                      Global.localStore.user.studyPlan.save();
                      Global.saveLocalStore();
                      var studySentence = StudySentenceSerializer();
                      studySentence.filter.foreignUser = Global.localStore.user.id;
                      studySentence.filter.categories__icontains = e;
                      var swes = await studySentence.list();
                      swes.forEach((w) => w.delete());
                      setState(() => {});
                    }
                  ),
                  SizedBox(width: 20,),
                ]
              ),
            )
          ).toList();
          return SimpleDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('选择句子收藏夹'),
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
                          Global.localStore.user.studyPlan.sentenceCategories.add(ctrl.text.trim());
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


Future<String> popSelectSentencePatternCategoryDialog(BuildContext context, List<String> categories) async {
  var ctrl = TextEditingController();
  var res = await showDialog(
    context: context,
    builder: (context) =>
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          List<Widget> options = Global.localStore.user.studyPlan.sentencePatternCategories.map<Widget>((e) =>
            Container(
              margin: EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(width: 20,),
                  Expanded(
                    child: InkWell(
                    child: Text('${categories.contains(e) ? "* " : "  "}$e'),
                    onTap: () => Navigator.pop(context, e),
                  )),
                  InkWell(
                    child: Icon(Icons.clear, color: Colors.black54, size: 18,),
                    onDoubleTap: () async {
                      Global.localStore.user.studyPlan.sentencePatternCategories.remove(e);
                      Global.localStore.user.studyPlan.save();
                      Global.saveLocalStore();
                      var studySentencePattern = StudySentencePatternSerializer();
                      studySentencePattern.filter.foreignUser = Global.localStore.user.id;
                      studySentencePattern.filter.categories__icontains = e;
                      var ssps = await studySentencePattern.list();
                      ssps.forEach((e) => e.delete());
                      setState(() => {});
                    }
                  ),
                  SizedBox(width: 20,),
                ]
              ),
            )
          ).toList();
          return SimpleDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('选择固定搭配收藏夹'),
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
                          Global.localStore.user.studyPlan.sentencePatternCategories.add(ctrl.text.trim());
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
          List<Widget> options = Global.localStore.user.studyPlan.grammarCategories.map<Widget>((e) =>
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
                    Global.localStore.user.studyPlan.grammarCategories.remove(e);
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
                Text('选择语法收藏夹'),
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
                          Global.localStore.user.studyPlan.grammarCategories.add(ctrl.text.trim());
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

String date2str(bool isReview, [String date]) {
  var today = DateTime.now().toLocal().toString().substring(0, 10);
  var tag = isReview ? '-rv' : '-v';
  return date == null ? '$today$tag' : '$date$tag';
}

List<String> reviewDates() {
  var today = DateTime.now();
  var dates = <DateTime>[];
  for(var i = 1; i < 5; i++) {
    dates.add(today.add(Duration(days: -i)));
  }

  return dates.map((e) => date2str(false, e.toLocal().toString().substring(0, 10))).toList();
}


