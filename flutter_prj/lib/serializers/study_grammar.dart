// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'package:flutter_prj/common/http.dart';


class StudyGrammarSerializer {
  StudyGrammarSerializer();

  num _id;
  num id = 0;
  num foreignUser;
  num grammar;
  String category = '';
  num familiarity = 0;
  List<String> learnRecord = [];
  bool inplan = false;
  bool isFavorite = false;
  num repeats = 0;

  Future<bool> create({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/api/study/grammar/', data:data ?? toJson(), queries:queries, cache:cache);
    fromJson(res?.data, slave:false); // Don't update slave forign members in create to avoid erasing newly added associated data
    return res != null;
  }

  Future<bool> retrieve({Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/api/study/grammar/$id/', queries:queries, cache:cache);
    fromJson(res?.data);
    return res != null;
  }

  Future<bool> delete({num pk}) async {
    if(_id == null && pk == null) return true;
    if(pk != null) id = pk;
    var res = await Http().request(HttpType.DELETE, '/api/study/grammar/$id/');
    /*
    
    */
    return res != null ? res.statusCode == 204 : false;
  }

  Future<bool> update({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.PUT, '/api/study/grammar/$id/', data:data ?? toJson(), queries:queries, cache:cache);
    fromJson(res?.data, slave:false); // Don't update slave forign members in update to avoid erasing newly added associated data
    return res != null;
  }

  Future<bool> save({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    bool res = _id == null ?
      await create(data:data, queries:queries, cache:cache) :
      await update(data:data, queries:queries, cache:cache);

    
    return res;
  }

  StudyGrammarSerializer fromJson(Map<String, dynamic> json, {bool slave = true}) {
    if(json == null) return this;
    id = json['id'] == null ? id : json['id'] as num;
    foreignUser = json['foreignUser'] == null ? foreignUser : json['foreignUser'] as num;
    grammar = json['grammar'] == null ? grammar : json['grammar'] as num;
    category = json['category'] == null ? category : json['category'] as String;
    familiarity = json['familiarity'] == null ? familiarity : json['familiarity'] as num;
    learnRecord = json['learnRecord'] == null
                ? learnRecord
                : json['learnRecord'].map<String>((e) => e as String).toList();
    inplan = json['inplan'] == null ? inplan : json['inplan'] as bool;
    isFavorite = json['isFavorite'] == null ? isFavorite : json['isFavorite'] as bool;
    repeats = json['repeats'] == null ? repeats : json['repeats'] as num;
    _id = id;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'foreignUser': foreignUser,
    'grammar': grammar,
    'category': category,
    'familiarity': familiarity,
    'learnRecord': learnRecord == null ? null : learnRecord.map((e) => e).toList(),
    'inplan': inplan,
    'isFavorite': isFavorite,
    'repeats': repeats,
  }..removeWhere((k, v) => v==null);


  StudyGrammarSerializer from(StudyGrammarSerializer instance) {
    if(instance == null) return this;
    id = instance.id;
    foreignUser = instance.foreignUser;
    grammar = instance.grammar;
    category = instance.category;
    familiarity = instance.familiarity;
    learnRecord = List.from(instance.learnRecord);
    inplan = instance.inplan;
    isFavorite = instance.isFavorite;
    repeats = instance.repeats;
    _id = instance._id;
    return this;
  }
}



