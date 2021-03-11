// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'grammar.dart';
import 'package:flutter_prj/common/http.dart';


class SentenceSerializer {
  SentenceSerializer();

  num id;
  String en = '';
  String cn = '';
  num type = 0;
  List<String> tag = [];
  List<String> tense = [];
  List<String> pattern = [];
  List<num> synonym = [];
  List<num> antonym = [];
  num paraphraseForeign;
  List<GrammarSerializer> grammarSet = [];
  

  Future<SentenceSerializer> create({dynamic data, Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/dictionary/sentence/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : SentenceSerializer().fromJson(res.data);
  }

  Future<SentenceSerializer> update({dynamic data, Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    var res = await Http().request(HttpType.PUT, '/dictionary/sentence/$id/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : SentenceSerializer().fromJson(res.data);
  }

  Future<SentenceSerializer> retrieve({Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/dictionary/sentence/$id/', queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : SentenceSerializer().fromJson(res.data);
  }

  Future<bool> delete({dynamic data, Map<String, dynamic> queryParameters, bool cache=false}) async {
    if(id == null) return false;
    var res = await Http().request(HttpType.DELETE, '/dictionary/sentence/$id/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    /*
    if(grammarSet != null){grammarSet.forEach((e){e.delete();});}
    */
    return res != null ? res.statusCode == 204 : false;
  }

  Future<SentenceSerializer> save({dynamic data, Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    SentenceSerializer res = id == null
                               ? await this.create(data:data, queryParameters:queryParameters, update:update, cache:cache)
                               : await this.update(data:data, queryParameters:queryParameters, update:update, cache:cache);
    if(grammarSet != null){grammarSet.forEach((e){ e.save();});}
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
    tense = json['tense'] == null
                ? []
                : json['tense'].map<String>((e) => e as String).toList();
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
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'en': en,
    'cn': cn,
    'type': type,
    'tag': tag == null ? null : tag.map((e) => e).toList(),
    'tense': tense == null ? null : tense.map((e) => e).toList(),
    'pattern': pattern == null ? null : pattern.map((e) => e).toList(),
    'synonym': synonym == null ? null : synonym.map((e) => e).toList(),
    'antonym': antonym == null ? null : antonym.map((e) => e).toList(),
    'paraphraseForeign': paraphraseForeign,
  };
}


