// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'grammar.dart';
import 'package:flutter_prj/common/http.dart';


class SentenceSerializer {
  SentenceSerializer();

  num _id;
  num id;
  String en = '';
  String cn = '';
  num type = 0;
  List<String> tag = [];
  String tense = '';
  List<String> pattern = [];
  List<num> synonym = [];
  List<num> antonym = [];
  num paraphraseForeign;
  List<GrammarSerializer> grammarSet = [];

  Future<bool> create({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    print('--- ${this.toJson()}');
    var res = await Http().request(HttpType.POST, '/dictionary/sentence/', data:data ?? this.toJson(), queries:queries, cache:cache);
    if(res != null) this.fromJson(res.data);
    return res != null;
  }

  Future<bool> update({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.PUT, '/dictionary/sentence/$id/', data:data ?? this.toJson(), queries:queries, cache:cache);
    return res != null;
  }

  Future<bool> retrieve({Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/dictionary/sentence/$id/', queries:queries, cache:cache);
    if(res != null) this.fromJson(res.data);
    return res != null;
  }

  Future<bool> delete({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    if(_id == null) return true;
    var res = await Http().request(HttpType.DELETE, '/dictionary/sentence/$id/', data:data ?? this.toJson(), queries:queries, cache:cache);
    /*
    if(grammarSet != null){grammarSet.forEach((e){e.delete();});}
    */
    return res != null ? res.statusCode == 204 : false;
  }

  Future<bool> save({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    bool res = false;
    if(_id == null) {
      print('--- create');
      var clone = SentenceSerializer().from(this); // create will update self, maybe refresh the member of self.
      res = await clone.create(data:data, queries:queries, cache:cache);
      if(res == false) return false;
      id = clone.id;
      if(grammarSet != null){await Future.forEach(grammarSet, (e) async {e.sentenceForeign = id; await e.save();});}
      res = await this.retrieve();
    } else {
      res = await this.update(data:data, queries:queries, cache:cache);
      if(grammarSet != null){await Future.forEach(grammarSet, (e) async {e.sentenceForeign = id; await e.save();});}
    }
    return res;
  }

  SentenceSerializer fromJson(Map<String, dynamic> json) {
    id = json['id'] == null ? null : json['id'] as num;
    en = json['en'] == null ? null : json['en'] as String;
    cn = json['cn'] == null ? null : json['cn'] as String;
    type = json['type'] == null ? null : json['type'] as num;
    tag = json['tag'] == null
                ? []
                : json['tag'].map<String>((e) => e as String).toList();
    tense = json['tense'] == null ? null : json['tense'] as String;
    pattern = json['pattern'] == null
                ? []
                : json['pattern'].map<String>((e) => e as String).toList();
    synonym = json['synonym'] == null
                ? []
                : json['synonym'].map<num>((e) => e as num).toList();
    antonym = json['antonym'] == null
                ? []
                : json['antonym'].map<num>((e) => e as num).toList();
    paraphraseForeign = json['paraphraseForeign'] == null ? null : json['paraphraseForeign'] as num;
    grammarSet = json['grammarSet'] == null
                ? []
                : json['grammarSet'].map<GrammarSerializer>((e) => GrammarSerializer().fromJson(e as Map<String, dynamic>)).toList();
    _id = id;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'en': en,
    'cn': cn,
    'type': type,
    'tag': tag == null ? null : tag.map((e) => e).toList(),
    'tense': tense,
    'pattern': pattern == null ? null : pattern.map((e) => e).toList(),
    'synonym': synonym == null ? null : synonym.map((e) => e).toList(),
    'antonym': antonym == null ? null : antonym.map((e) => e).toList(),
    'paraphraseForeign': paraphraseForeign,
  };

  SentenceSerializer from(SentenceSerializer instance) {
    id = instance.id;
    en = instance.en;
    cn = instance.cn;
    type = instance.type;
    tag = List.from(instance.tag);
    tense = instance.tense;
    pattern = List.from(instance.pattern);
    synonym = List.from(instance.synonym);
    antonym = List.from(instance.antonym);
    paraphraseForeign = instance.paraphraseForeign;
    grammarSet = List.from(instance.grammarSet.map((e) => GrammarSerializer().from(e)).toList());
    _id = instance._id;
    return this;
  }
}


