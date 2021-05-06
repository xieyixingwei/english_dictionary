// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'dart:convert';
import 'package:flutter_prj/common/http.dart';


class StudySentenceSerializer {
  StudySentenceSerializer();

  num _id;
  num id = 0;
  num foreignUser;
  num sentence;
  String category = '';
  num familiarity = 0;
  List<String> learnRecord = [];
  bool inplan = false;
  bool isFavorite = false;
  String comments = '';
  num repeats = 0;
  List<String> newWords = [];

  Future<bool> create({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/study/sentence/', data:data ?? toJson(), queries:queries, cache:cache);
    if(res != null) fromJson(res.data);
    return res != null;
  }

  Future<bool> retrieve({Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/study/sentence/$id/', queries:queries, cache:cache);
    if(res != null) fromJson(res.data);
    return res != null;
  }

  Future<bool> delete({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    if(_id == null) return true;
    var res = await Http().request(HttpType.DELETE, '/study/sentence/$id/', data:data ?? toJson(), queries:queries, cache:cache);
    /*
    
    */
    return res != null ? res.statusCode == 204 : false;
  }

  Future<bool> update({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.PUT, '/study/sentence/$id/', data:data ?? toJson(), queries:queries, cache:cache);
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

  StudySentenceSerializer fromJson(Map<String, dynamic> json) {
    id = json['id'] == null ? null : json['id'] as num;
    foreignUser = json['foreignUser'] == null ? null : json['foreignUser'] as num;
    sentence = json['sentence'] == null ? null : json['sentence'] as num;
    category = json['category'] == null ? null : json['category'] as String;
    familiarity = json['familiarity'] == null ? null : json['familiarity'] as num;
    learnRecord = json['learnRecord'] == null
                ? []
                : json['learnRecord'].map<String>((e) => e as String).toList();
    inplan = json['inplan'] == null ? null : json['inplan'] as bool;
    isFavorite = json['isFavorite'] == null ? null : json['isFavorite'] as bool;
    comments = json['comments'] == null ? null : json['comments'] as String;
    repeats = json['repeats'] == null ? null : json['repeats'] as num;
    newWords = json['newWords'] == null
                ? []
                : json['newWords'].map<String>((e) => e as String).toList();
    _id = id;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'foreignUser': foreignUser,
    'sentence': sentence,
    'category': category,
    'familiarity': familiarity,
    'learnRecord': learnRecord == null ? null : learnRecord.map((e) => e).toList(),
    'inplan': inplan,
    'isFavorite': isFavorite,
    'comments': comments,
    'repeats': repeats,
    'newWords': newWords == null ? null : newWords.map((e) => e).toList(),
  };

  StudySentenceSerializer from(StudySentenceSerializer instance) {
    if(instance == null) return this;
    id = instance.id;
    foreignUser = instance.foreignUser;
    sentence = instance.sentence;
    category = instance.category;
    familiarity = instance.familiarity;
    learnRecord = List.from(instance.learnRecord);
    inplan = instance.inplan;
    isFavorite = instance.isFavorite;
    comments = instance.comments;
    repeats = instance.repeats;
    newWords = List.from(instance.newWords);
    _id = instance._id;
    return this;
  }
}


