// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'sentence.dart';
import 'word.dart';
import 'sentence_pattern.dart';
import 'package:flutter_prj/common/http.dart';


class StudySentenceSerializer {
  StudySentenceSerializer();

  num _id;
  num id = 0;
  num foreignUser;
  SentenceSerializer sentence;
  List<String> categories = [];
  num familiarity = 0;
  List<String> learnRecord = [];
  bool inplan = false;
  bool isFavorite = false;
  String comments = '';
  num repeats = 0;
  List<WordSerializer> newWords = [];
  List<SentencePatternSerializer> newSentencePatterns = [];
  bool hideNewWords = true;
  StudySentenceSerializerFilter filter = StudySentenceSerializerFilter();

  Future<bool> create({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/api/study/sentence/', data:data ?? toJson(), queries:queries, cache:cache);
    fromJson(res?.data, slave:false); // Don't update slave forign members in create to avoid erasing newly added associated data
    return res != null;
  }

  Future<bool> retrieve({Map<String, dynamic> queries, bool cache=false}) async {
    if(queries == null) queries = <String, dynamic>{};
    queries.addAll(filter.queries);
    var res = await Http().request(HttpType.GET, '/api/study/sentence/$id/', queries:queries, cache:cache);
    fromJson(res?.data);
    return res != null;
  }

  Future<bool> delete({num pk}) async {
    if(_id == null && pk == null) return true;
    if(pk != null) id = pk;
    var res = await Http().request(HttpType.DELETE, '/api/study/sentence/$id/');
    /*
    
    */
    return res != null ? res.statusCode == 204 : false;
  }

  Future<bool> update({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.PUT, '/api/study/sentence/$id/', data:data ?? toJson(), queries:queries, cache:cache);
    fromJson(res?.data, slave:false); // Don't update slave forign members in update to avoid erasing newly added associated data
    return res != null;
  }

  Future<List<StudySentenceSerializer>> list({Map<String, dynamic> queries, bool cache=false}) async {
    if(queries == null) queries = <String, dynamic>{};
    queries.addAll(filter.queries);
    var res = await Http().request(HttpType.GET, '/api/study/sentence/', queries:queries, cache:cache);
    return res != null ? res.data.map<StudySentenceSerializer>((e) => StudySentenceSerializer().fromJson(e)).toList() : [];
  }

  Future<bool> save({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    bool res = _id == null ?
      await create(data:data, queries:queries, cache:cache) :
      await update(data:data, queries:queries, cache:cache);

    
    return res;
  }

  StudySentenceSerializer fromJson(Map<String, dynamic> json, {bool slave = true}) {
    if(json == null) return this;
    id = json['id'] == null ? id : json['id'] as num;
    foreignUser = json['foreignUser'] == null ? foreignUser : json['foreignUser'] as num;
    sentence = json['sentence'] == null
                ? sentence
                : SentenceSerializer().fromJson(json['sentence'] as Map<String, dynamic>);
    categories = json['categories'] == null
                ? categories
                : json['categories'].map<String>((e) => e as String).toList();
    familiarity = json['familiarity'] == null ? familiarity : json['familiarity'] as num;
    learnRecord = json['learnRecord'] == null
                ? learnRecord
                : json['learnRecord'].map<String>((e) => e as String).toList();
    inplan = json['inplan'] == null ? inplan : json['inplan'] as bool;
    isFavorite = json['isFavorite'] == null ? isFavorite : json['isFavorite'] as bool;
    comments = json['comments'] == null ? comments : json['comments'] as String;
    repeats = json['repeats'] == null ? repeats : json['repeats'] as num;
    newWords = json['newWords'] == null
                ? newWords
                : json['newWords'].map<WordSerializer>((e) => WordSerializer().fromJson(e as Map<String, dynamic>)).toList();
    newSentencePatterns = json['newSentencePatterns'] == null
                ? newSentencePatterns
                : json['newSentencePatterns'].map<SentencePatternSerializer>((e) => SentencePatternSerializer().fromJson(e as Map<String, dynamic>)).toList();
    _id = id;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'foreignUser': foreignUser,
    'sentence': sentence == null ? null : sentence.id,
    'categories': categories == null ? null : categories.map((e) => e).toList(),
    'familiarity': familiarity,
    'learnRecord': learnRecord == null ? null : learnRecord.map((e) => e).toList(),
    'inplan': inplan,
    'isFavorite': isFavorite,
    'comments': comments,
    'repeats': repeats,
    'newWords': newWords == null ? null : newWords.map((e) => e.name).toList(),
    'newSentencePatterns': newSentencePatterns == null ? null : newSentencePatterns.map((e) => e.id).toList(),
  }..removeWhere((k, v) => v==null);


  StudySentenceSerializer from(StudySentenceSerializer instance) {
    if(instance == null) return this;
    id = instance.id;
    foreignUser = instance.foreignUser;
    sentence = SentenceSerializer().from(instance.sentence);
    categories = List.from(instance.categories);
    familiarity = instance.familiarity;
    learnRecord = List.from(instance.learnRecord);
    inplan = instance.inplan;
    isFavorite = instance.isFavorite;
    comments = instance.comments;
    repeats = instance.repeats;
    newWords = List.from(instance.newWords.map((e) => WordSerializer().from(e)).toList());
    newSentencePatterns = List.from(instance.newSentencePatterns.map((e) => SentencePatternSerializer().from(e)).toList());
    hideNewWords = instance.hideNewWords;
    _id = instance._id;
    return this;
  }
}

class StudySentenceSerializerFilter {
  num foreignUser;
  num sentence;
  String categories__icontains;
  num familiarity__lte;
  num familiarity__gte;
  bool inplan;

  Map<String, dynamic> get queries => <String, dynamic>{
    'foreignUser': foreignUser,
    'sentence': sentence,
    'categories__icontains': categories__icontains,
    'familiarity__lte': familiarity__lte,
    'familiarity__gte': familiarity__gte,
    'inplan': inplan,
  }..removeWhere((String key, dynamic value) => value == null);

  void clear() {
    foreignUser = null;
    sentence = null;
    categories__icontains = null;
    familiarity__lte = null;
    familiarity__gte = null;
    inplan = null;
  }
}

