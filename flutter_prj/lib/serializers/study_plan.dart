// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'dart:convert';
import 'package:flutter_prj/common/http.dart';


class StudyPlanSerializer {
  StudyPlanSerializer();

  num _id;
  num id;
  num foreignUser;
  num onceWords = 0;
  num onceSentences = 0;
  num onceGrammers = 0;
  List<String> wordCategory = [];
  List<String> sentenceCategory = [];
  List<String> grammarCategory = [];
  List<String> distinguishCategory = [];
  List<num> distinguishes = [];

  Future<bool> create({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/study/plan/', data:data ?? toJson(), queries:queries, cache:cache);
    if(res != null) fromJson(res.data);
    return res != null;
  }

  Future<bool> retrieve({Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/study/plan/$id/', queries:queries, cache:cache);
    if(res != null) fromJson(res.data);
    return res != null;
  }

  Future<bool> delete({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    if(_id == null) return true;
    var res = await Http().request(HttpType.DELETE, '/study/plan/$id/', data:data ?? toJson(), queries:queries, cache:cache);
    /*
    
    */
    return res != null ? res.statusCode == 204 : false;
  }

  Future<bool> update({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.PUT, '/study/plan/$id/', data:data ?? toJson(), queries:queries, cache:cache);
    return res != null;
  }

  Future<bool> save({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    bool res = false;
    if(_id == null) {
      res = await create(data:data, queries:queries, cache:cache);
    } else {
      res = await update(data:data, queries:queries, cache:cache);
    }
    return res;
  }

  StudyPlanSerializer fromJson(Map<String, dynamic> json) {
    id = json['id'] == null ? null : json['id'] as num;
    foreignUser = json['foreignUser'] == null ? null : json['foreignUser'] as num;
    onceWords = json['onceWords'] == null ? null : json['onceWords'] as num;
    onceSentences = json['onceSentences'] == null ? null : json['onceSentences'] as num;
    onceGrammers = json['onceGrammers'] == null ? null : json['onceGrammers'] as num;
    wordCategory = json['wordCategory'] == null
                ? []
                : json['wordCategory'].map<String>((e) => e as String).toList();
    sentenceCategory = json['sentenceCategory'] == null
                ? []
                : json['sentenceCategory'].map<String>((e) => e as String).toList();
    grammarCategory = json['grammarCategory'] == null
                ? []
                : json['grammarCategory'].map<String>((e) => e as String).toList();
    distinguishCategory = json['distinguishCategory'] == null
                ? []
                : json['distinguishCategory'].map<String>((e) => e as String).toList();
    distinguishes = json['distinguishes'] == null
                ? []
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
    'wordCategory': wordCategory == null ? null : wordCategory.map((e) => e).toList(),
    'sentenceCategory': sentenceCategory == null ? null : sentenceCategory.map((e) => e).toList(),
    'grammarCategory': grammarCategory == null ? null : grammarCategory.map((e) => e).toList(),
    'distinguishCategory': distinguishCategory == null ? null : distinguishCategory.map((e) => e).toList(),
    'distinguishes': distinguishes == null ? null : distinguishes.map((e) => e).toList(),
  };

  StudyPlanSerializer from(StudyPlanSerializer instance) {
    if(instance == null) return this;
    id = instance.id;
    foreignUser = instance.foreignUser;
    onceWords = instance.onceWords;
    onceSentences = instance.onceSentences;
    onceGrammers = instance.onceGrammers;
    wordCategory = List.from(instance.wordCategory);
    sentenceCategory = List.from(instance.sentenceCategory);
    grammarCategory = List.from(instance.grammarCategory);
    distinguishCategory = List.from(instance.distinguishCategory);
    distinguishes = List.from(instance.distinguishes);
    _id = instance._id;
    return this;
  }
}


