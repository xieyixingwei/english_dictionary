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
    var res = await Http().request(HttpType.POST, '/dictionary/paraphrase/', data:data ?? toJson(), queries:queries, cache:cache);
    if(res != null) fromJson(res.data);
    return res != null;
  }

  Future<bool> update({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.PUT, '/dictionary/paraphrase/$id/', data:data ?? toJson(), queries:queries, cache:cache);
    return res != null;
  }

  Future<bool> retrieve({Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/dictionary/paraphrase/$id/', queries:queries, cache:cache);
    if(res != null) fromJson(res.data);
    return res != null;
  }

  Future<bool> delete({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    if(_id == null) return true;
    var res = await Http().request(HttpType.DELETE, '/dictionary/paraphrase/$id/', data:data ?? toJson(), queries:queries, cache:cache);
    /*
    if(sentenceSet != null){sentenceSet.forEach((e){e.delete();});}
    */
    return res != null ? res.statusCode == 204 : false;
  }

  Future<bool> save({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    bool res = false;
    if(_id == null) {
      var clone = ParaphraseSerializer().from(this); // create will update self, maybe refresh the member of self.
      res = await clone.create(data:data, queries:queries, cache:cache);
      if(res == false) return false;
      id = clone.id;
      if(sentenceSet != null){await Future.forEach(sentenceSet, (e) async {e.paraphraseForeign = id; await e.save();});}
      res = await retrieve();
    } else {
      res = await update(data:data, queries:queries, cache:cache);
      if(sentenceSet != null){await Future.forEach(sentenceSet, (e) async {e.paraphraseForeign = id; await e.save();});}
    }
    return res;
  }

  ParaphraseSerializer fromJson(Map<String, dynamic> json) {
    id = json['id'] == null ? null : json['id'] as num;
    interpret = json['interpret'] == null ? null : json['interpret'] as String;
    partOfSpeech = json['partOfSpeech'] == null ? null : json['partOfSpeech'] as String;
    wordForeign = json['wordForeign'] == null ? null : json['wordForeign'] as String;
    sentencePatternForeign = json['sentencePatternForeign'] == null ? null : json['sentencePatternForeign'] as num;
    sentenceSet = json['sentenceSet'] == null
                ? []
                : json['sentenceSet'].map<SentenceSerializer>((e) => SentenceSerializer().fromJson(e as Map<String, dynamic>)).toList();
    _id = id;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'interpret': interpret,
    'partOfSpeech': partOfSpeech,
    'wordForeign': wordForeign,
    'sentencePatternForeign': sentencePatternForeign,
  };

  ParaphraseSerializer from(ParaphraseSerializer instance) {
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


