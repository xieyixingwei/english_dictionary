// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'word.dart';
import 'package:flutter_prj/common/http.dart';
import 'global_queryset.dart';

class StudyWordSerializer {
  StudyWordSerializer();

  num _id;
  num id = 0;
  num foreignUser;
  WordSerializer word;
  List<String> categories = [];
  num familiarity = 0;
  List<String> learnRecord = [];
  bool inplan = false;
  bool isFavorite = false;
  String comments = '';
  num repeats = 0;
  StudyWordFilter filter = StudyWordFilter();
  GlobalQuerySet queryset = GlobalQuerySet();

  Future<bool> create({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/api/study/word/', data:data ?? toJson(), queries:queries, cache:cache);
    fromJson(res?.data, slave:false); // Don't update slave forign members in create to avoid erasing newly added associated data
    return res != null;
  }

  Future<bool> retrieve({Map<String, dynamic> queries, bool cache=false}) async {
    if(queries == null) queries = <String, dynamic>{};
    queries.addAll(queryset.queries);
    queries.addAll(filter.queries);
    var res = await Http().request(HttpType.GET, '/api/study/word/$id/', queries:queries, cache:cache);
    fromJson(res?.data);
    return res != null;
  }

  Future<bool> delete({num pk}) async {
    if(_id == null && pk == null) return true;
    if(pk != null) id = pk;
    var res = await Http().request(HttpType.DELETE, '/api/study/word/$id/');
    /*
    
    */
    return res != null ? res.statusCode == 204 : false;
  }

  Future<bool> update({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.PUT, '/api/study/word/$id/', data:data ?? toJson(), queries:queries, cache:cache);
    fromJson(res?.data, slave:false); // Don't update slave forign members in update to avoid erasing newly added associated data
    return res != null;
  }

  Future<List<StudyWordSerializer>> list({Map<String, dynamic> queries, bool cache=false}) async {
    if(queries == null) queries = <String, dynamic>{};
    queries.addAll(queryset.queries);
    queries.addAll(filter.queries);
    var res = await Http().request(HttpType.GET, '/api/study/word/', queries:queries, cache:cache);
    return res != null ? res.data.map<StudyWordSerializer>((e) => StudyWordSerializer().fromJson(e)).toList() : [];
  }

  Future<bool> save({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    bool res = _id == null ?
      await create(data:data, queries:queries, cache:cache) :
      await update(data:data, queries:queries, cache:cache);

    return res;
  }

  StudyWordSerializer fromJson(Map<String, dynamic> json, {bool slave = true}) {
    if(json == null) return this;
    id = json['id'] == null ? id : json['id'] as num;
    foreignUser = json['foreignUser'] == null ? foreignUser : json['foreignUser'] as num;
    word = json['word'] == null
                ? word
                : WordSerializer().fromJson(json['word'] as Map<String, dynamic>);
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
    _id = id;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'foreignUser': foreignUser,
    'word': word == null ? null : word.name,
    'categories': categories == null ? null : categories.map((e) => e).toList(),
    'familiarity': familiarity,
    'learnRecord': learnRecord == null ? null : learnRecord.map((e) => e).toList(),
    'inplan': inplan,
    'isFavorite': isFavorite,
    'comments': comments,
    'repeats': repeats,
  }..removeWhere((k, v) => v==null);


  StudyWordSerializer from(StudyWordSerializer instance) {
    if(instance == null) return this;
    id = instance.id;
    foreignUser = instance.foreignUser;
    word = WordSerializer().from(instance.word);
    categories = List.from(instance.categories);
    familiarity = instance.familiarity;
    learnRecord = List.from(instance.learnRecord);
    inplan = instance.inplan;
    isFavorite = instance.isFavorite;
    comments = instance.comments;
    repeats = instance.repeats;
    _id = instance._id;
    return this;
  }
}

class StudyWordFilter {
  num foreignUser;
  String word;
  String categories__icontains;
  num familiarity__lte;
  num familiarity__gte;
  num repeats__lte;
  num repeats__gte;
  String learnRecord__icontains;
  bool inplan;

  Map<String, dynamic> get queries => <String, dynamic>{
    'foreignUser': foreignUser,
    'word': word,
    'categories__icontains': categories__icontains,
    'familiarity__lte': familiarity__lte,
    'familiarity__gte': familiarity__gte,
    'repeats__lte': repeats__lte,
    'repeats__gte': repeats__gte,
    'learnRecord__icontains': learnRecord__icontains,
    'inplan': inplan,
  }..removeWhere((String key, dynamic value) => value == null);

  void clear() {
    foreignUser = null;
    word = null;
    categories__icontains = null;
    familiarity__lte = null;
    familiarity__gte = null;
    repeats__lte = null;
    repeats__gte = null;
    learnRecord__icontains = null;
    inplan = null;
  }
}
