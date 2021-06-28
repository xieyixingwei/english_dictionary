// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'sentence.dart';
import 'package:flutter_prj/common/http.dart';

class ParaphraseSerializer {
  ParaphraseSerializer();

  num _id;
  num id;
  String interpret = '';
  String partOfSpeech = '';
  String wordForeign;
  num sentencePatternForeign;
  List<SentenceSerializer> sentenceSet = [];

  Future<bool> create({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/api/dictionary/paraphrase/', data:data ?? toJson(), queries:queries, cache:cache);
    fromJson(res?.data, slave:false); // Don't update slave forign members in create to avoid erasing newly added associated data
    return res != null;
  }

  Future<bool> update({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.PUT, '/api/dictionary/paraphrase/$id/', data:data ?? toJson(), queries:queries, cache:cache);
    fromJson(res?.data, slave:false); // Don't update slave forign members in update to avoid erasing newly added associated data
    return res != null;
  }

  Future<bool> retrieve({Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/api/dictionary/paraphrase/$id/', queries:queries, cache:cache);
    fromJson(res?.data);
    return res != null;
  }

  Future<bool> delete({num pk}) async {
    if(_id == null && pk == null) return true;
    if(pk != null) id = pk;
    var res = await Http().request(HttpType.DELETE, '/api/dictionary/paraphrase/$id/');
    /*
    if(sentenceSet != null){sentenceSet.forEach((e){e.delete();});}
    */
    return res != null ? res.statusCode == 204 : false;
  }

  Future<bool> save({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    bool res = _id == null ?
      await create(data:data, queries:queries, cache:cache) :
      await update(data:data, queries:queries, cache:cache);
    if(res) {
      await Future.forEach(sentenceSet, (e) async {e.paraphraseForeign = id; await e.save();});
    }
    return res;
  }

  ParaphraseSerializer fromJson(Map<String, dynamic> json, {bool slave = true}) {
    if(json == null) return this;
    id = json['id'] == null ? id : json['id'] as num;
    interpret = json['interpret'] == null ? interpret : json['interpret'] as String;
    partOfSpeech = json['partOfSpeech'] == null ? partOfSpeech : json['partOfSpeech'] as String;
    wordForeign = json['wordForeign'] == null ? wordForeign : json['wordForeign'] as String;
    sentencePatternForeign = json['sentencePatternForeign'] == null ? sentencePatternForeign : json['sentencePatternForeign'] as num;
    _id = id;
    if(!slave) return this;
    sentenceSet = json['sentenceSet'] == null
                ? sentenceSet
                : json['sentenceSet'].map<SentenceSerializer>((e) => SentenceSerializer().fromJson(e as Map<String, dynamic>)).toList();
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'interpret': interpret,
    'partOfSpeech': partOfSpeech,
    'wordForeign': wordForeign,
    'sentencePatternForeign': sentencePatternForeign,
  }..removeWhere((k, v) => v==null);


  ParaphraseSerializer from(ParaphraseSerializer instance) {
    if(instance == null) return this;
    id = instance.id;
    interpret = instance.interpret;
    partOfSpeech = instance.partOfSpeech;
    wordForeign = instance.wordForeign;
    sentencePatternForeign = instance.sentencePatternForeign;
    sentenceSet = List.from(instance.sentenceSet.map((e) => SentenceSerializer().from(e)).toList());
    _id = instance._id;
    return this;
  }
}

