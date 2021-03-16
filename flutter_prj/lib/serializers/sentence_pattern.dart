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
    var res = await Http().request(HttpType.POST, '/dictionary/sentence_pattern/', data:data ?? this.toJson(), queries:queries, cache:cache);
    if(res != null) this.fromJson(res.data);
    return res != null;
  }

  Future<bool> update({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.PUT, '/dictionary/sentence_pattern/$id/', data:data ?? this.toJson(), queries:queries, cache:cache);
    return res != null;
  }

  Future<bool> retrieve({Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/dictionary/sentence_pattern/$id/', queries:queries, cache:cache);
    if(res != null) this.fromJson(res.data);
    return res != null;
  }

  Future<bool> delete({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    if(_id == null) return false;
    var res = await Http().request(HttpType.DELETE, '/dictionary/sentence_pattern/$id/', data:data ?? this.toJson(), queries:queries, cache:cache);
    /*
    if(paraphraseSet != null){paraphraseSet.forEach((e){e.delete();});}
    */
    return res != null ? res.statusCode == 204 : false;
  }

  Future<bool> save({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    bool res = false;
    if(_id == null) {
      var clone = SentencePatternSerializer().from(this); // create will update self, maybe refresh the member of self.
      res = await clone.create(data:data, queries:queries, cache:cache);
      if(res == false) return false;
      id = clone.id;
      if(paraphraseSet != null){await Future.forEach(paraphraseSet, (e) async {e.sentencePatternForeign = id; await e.save();});}
      res = await this.retrieve();
    } else {
      res = await this.update(data:data, queries:queries, cache:cache);
      if(paraphraseSet != null){await Future.forEach(paraphraseSet, (e) async {e.sentencePatternForeign = id; await e.save();});}
    }
    return res;
  }

  SentencePatternSerializer fromJson(Map<String, dynamic> json) {
    id = json['id'] == null ? null : json['id'] as num;
    content = json['content'] == null ? null : json['content'] as String;
    wordForeign = json['wordForeign'] == null ? null : json['wordForeign'] as String;
    paraphraseSet = json['paraphraseSet'] == null
                ? []
                : json['paraphraseSet'].map<ParaphraseSerializer>((e) => ParaphraseSerializer().fromJson(e as Map<String, dynamic>)).toList();
    _id = id;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'content': content,
    'wordForeign': wordForeign,
  };

  SentencePatternSerializer from(SentencePatternSerializer instance) {
    id = instance.id;
    content = instance.content;
    wordForeign = instance.wordForeign;
    paraphraseSet = List.from(instance.paraphraseSet.map((e) => ParaphraseSerializer().from(e)).toList());
    _id = instance._id;
    return this;
  }
}


