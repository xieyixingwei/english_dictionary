
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/serializers/index.dart';


StudyWordSerializer getStudyWord(String word) {
  if(Global.localStore.user.studyWordSet.isEmpty)
    return null;
  return Global.localStore.user.studyWordSet.singleWhere((e) => e.word==word, orElse: () => null);
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
  return Global.localStore.user.studyPlan.distinguishes.contains(id);
}
