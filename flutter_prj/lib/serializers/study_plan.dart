// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'package:flutter_prj/common/http.dart';


class StudyPlanSerializer {
  StudyPlanSerializer();

  num _id;
  num id;
  num foreignUser;
  num onceWords = 0;
  num onceSentences = 0;
  num onceGrammers = 0;
  List<String> wordCategories = [];
  List<String> sentenceCategories = [];
  List<String> sentencePatternCategories = [];
  List<String> grammarCategories = [];
  List<String> distinguishCategories = [];
  List<num> distinguishes = [];

  Future<bool> create({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/api/study/plan/', data:data ?? toJson(), queries:queries, cache:cache);
    fromJson(res?.data, slave:false); // Don't update slave forign members in create to avoid erasing newly added associated data
    return res != null;
  }

  Future<bool> retrieve({Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/api/study/plan/$id/', queries:queries, cache:cache);
    fromJson(res?.data);
    return res != null;
  }

  Future<bool> delete({num pk}) async {
    if(_id == null && pk == null) return true;
    if(pk != null) id = pk;
    var res = await Http().request(HttpType.DELETE, '/api/study/plan/$id/');
    /*
    
    */
    return res != null ? res.statusCode == 204 : false;
  }

  Future<bool> update({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.PUT, '/api/study/plan/$id/', data:data ?? toJson(), queries:queries, cache:cache);
    fromJson(res?.data, slave:false); // Don't update slave forign members in update to avoid erasing newly added associated data
    return res != null;
  }

  Future<bool> save({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    bool res = _id == null ?
      await create(data:data, queries:queries, cache:cache) :
      await update(data:data, queries:queries, cache:cache);

    
    return res;
  }

  StudyPlanSerializer fromJson(Map<String, dynamic> json, {bool slave = true}) {
    if(json == null) return this;
    id = json['id'] == null ? id : json['id'] as num;
    foreignUser = json['foreignUser'] == null ? foreignUser : json['foreignUser'] as num;
    onceWords = json['onceWords'] == null ? onceWords : json['onceWords'] as num;
    onceSentences = json['onceSentences'] == null ? onceSentences : json['onceSentences'] as num;
    onceGrammers = json['onceGrammers'] == null ? onceGrammers : json['onceGrammers'] as num;
    wordCategories = json['wordCategories'] == null
                ? wordCategories
                : json['wordCategories'].map<String>((e) => e as String).toList();
    sentenceCategories = json['sentenceCategories'] == null
                ? sentenceCategories
                : json['sentenceCategories'].map<String>((e) => e as String).toList();
    sentencePatternCategories = json['sentencePatternCategories'] == null
                ? sentencePatternCategories
                : json['sentencePatternCategories'].map<String>((e) => e as String).toList();
    grammarCategories = json['grammarCategories'] == null
                ? grammarCategories
                : json['grammarCategories'].map<String>((e) => e as String).toList();
    distinguishCategories = json['distinguishCategories'] == null
                ? distinguishCategories
                : json['distinguishCategories'].map<String>((e) => e as String).toList();
    distinguishes = json['distinguishes'] == null
                ? distinguishes
                : json['distinguishes'].map<num>((e) => e as num).toList();
    _id = id;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'foreignUser': foreignUser,
    'onceWords': onceWords,
    'onceSentences': onceSentences,
    'onceGrammers': onceGrammers,
    'wordCategories': wordCategories == null ? null : wordCategories.map((e) => e).toList(),
    'sentenceCategories': sentenceCategories == null ? null : sentenceCategories.map((e) => e).toList(),
    'sentencePatternCategories': sentencePatternCategories == null ? null : sentencePatternCategories.map((e) => e).toList(),
    'grammarCategories': grammarCategories == null ? null : grammarCategories.map((e) => e).toList(),
    'distinguishCategories': distinguishCategories == null ? null : distinguishCategories.map((e) => e).toList(),
    'distinguishes': distinguishes == null ? null : distinguishes.map((e) => e).toList(),
  }..removeWhere((k, v) => v==null);


  StudyPlanSerializer from(StudyPlanSerializer instance) {
    if(instance == null) return this;
    id = instance.id;
    foreignUser = instance.foreignUser;
    onceWords = instance.onceWords;
    onceSentences = instance.onceSentences;
    onceGrammers = instance.onceGrammers;
    wordCategories = List.from(instance.wordCategories);
    sentenceCategories = List.from(instance.sentenceCategories);
    sentencePatternCategories = List.from(instance.sentencePatternCategories);
    grammarCategories = List.from(instance.grammarCategories);
    distinguishCategories = List.from(instance.distinguishCategories);
    distinguishes = List.from(instance.distinguishes);
    _id = instance._id;
    return this;
  }
}



