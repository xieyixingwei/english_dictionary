// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'paraphrase.dart';
import 'package:flutter_prj/common/http.dart';


class SentencePatternSerializer {
  SentencePatternSerializer();

  num _id;
  num id;
  String content = '';
  String wordForeign;
  List<ParaphraseSerializer> paraphraseSet = [];

  Future<bool> create({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/api/dictionary/sentence_pattern/', data:data ?? toJson(), queries:queries, cache:cache);
    fromJson(res?.data, slave:false); // Don't update slave forign members in create to avoid erasing newly added associated data
    return res != null;
  }

  Future<bool> update({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.PUT, '/api/dictionary/sentence_pattern/$id/', data:data ?? toJson(), queries:queries, cache:cache);
    fromJson(res?.data, slave:false); // Don't update slave forign members in update to avoid erasing newly added associated data
    return res != null;
  }

  Future<bool> retrieve({Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/api/dictionary/sentence_pattern/$id/', queries:queries, cache:cache);
    fromJson(res?.data);
    return res != null;
  }

  Future<bool> delete({num pk}) async {
    if(_id == null && pk == null) return true;
    if(pk != null) id = pk;
    var res = await Http().request(HttpType.DELETE, '/api/dictionary/sentence_pattern/$id/');
    /*
    if(paraphraseSet != null){paraphraseSet.forEach((e){e.delete();});}
    */
    return res != null ? res.statusCode == 204 : false;
  }

  Future<bool> save({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    bool res = _id == null ?
      await create(data:data, queries:queries, cache:cache) :
      await update(data:data, queries:queries, cache:cache);

    if(res) {
      await Future.forEach(paraphraseSet, (e) async {e.sentencePatternForeign = id; await e.save();});
    }
    
    return res;
  }

  SentencePatternSerializer fromJson(Map<String, dynamic> json, {bool slave = true}) {
    if(json == null) return this;
    id = json['id'] == null ? id : json['id'] as num;
    content = json['content'] == null ? content : json['content'] as String;
    wordForeign = json['wordForeign'] == null ? wordForeign : json['wordForeign'] as String;
    _id = id;
    if(!slave) return this;
    paraphraseSet = json['paraphraseSet'] == null
                ? paraphraseSet
                : json['paraphraseSet'].map<ParaphraseSerializer>((e) => ParaphraseSerializer().fromJson(e as Map<String, dynamic>)).toList();
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'content': content,
    'wordForeign': wordForeign,
  }..removeWhere((k, v) => v==null);


  SentencePatternSerializer from(SentencePatternSerializer instance) {
    if(instance == null) return this;
    id = instance.id;
    content = instance.content;
    wordForeign = instance.wordForeign;
    paraphraseSet = List.from(instance.paraphraseSet.map((e) => ParaphraseSerializer().from(e)).toList());
    _id = instance._id;
    return this;
  }
}



