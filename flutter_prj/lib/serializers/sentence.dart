// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'grammar.dart';
import 'package:flutter_prj/common/http.dart';


class SentenceSerializer {
  SentenceSerializer();

  num s_id;
  String s_en = '';
  String s_ch = '';
  num s_type = 0;
  List<String> s_tags = [];
  List<String> s_tense = [];
  List<String> s_form = [];
  List<num> s_synonym = [];
  List<num> s_antonym = [];
  List<GrammarSerializer> sentence_grammar = [];
  

  Future<SentenceSerializer> create({dynamic data, Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/dictionary/sentence/create/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : SentenceSerializer().fromJson(res.data);
  }

  Future<SentenceSerializer> update({dynamic data, Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    var res = await Http().request(HttpType.PUT, '/dictionary/sentence/update/$s_id/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : SentenceSerializer().fromJson(res.data);
  }

  Future<SentenceSerializer> retrieve({Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/dictionary/sentence/$s_id/', queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : SentenceSerializer().fromJson(res.data);
  }

  Future<bool> delete({dynamic data, Map<String, dynamic> queryParameters, bool cache=false}) async {
    if(s_id == null) return false;
    var res = await Http().request(HttpType.DELETE, '/dictionary/sentence/delete/$s_id/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    /*
    if(sentence_grammar != null){sentence_grammar.forEach((e){e.delete();});}
    */
    return res != null ? res.statusCode == 204 : false;
  }

  Future<SentenceSerializer> save({dynamic data, Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    SentenceSerializer res = s_id == null
                               ? await this.create(data:data, queryParameters:queryParameters, update:update, cache:cache)
                               : await this.update(data:data, queryParameters:queryParameters, update:update, cache:cache);
    if(sentence_grammar != null){sentence_grammar.forEach((e){ e.save();});}
    return res;
  }

  SentenceSerializer fromJson(Map<String, dynamic> json) {
    s_id = json['s_id'] == null ? null : json['s_id'] as num;
    s_en = json['s_en'] == null ? null : json['s_en'] as String;
    s_ch = json['s_ch'] == null ? null : json['s_ch'] as String;
    s_type = json['s_type'] == null ? null : json['s_type'] as num;
    s_tags = json['s_tags'] == null
                ? []
                : json['s_tags'].map<String>((e) => e as String).toList();
    s_tense = json['s_tense'] == null
                ? []
                : json['s_tense'].map<String>((e) => e as String).toList();
    s_form = json['s_form'] == null
                ? []
                : json['s_form'].map<String>((e) => e as String).toList();
    s_synonym = json['s_synonym'] == null
                ? []
                : json['s_synonym'].map<num>((e) => e as num).toList();
    s_antonym = json['s_antonym'] == null
                ? []
                : json['s_antonym'].map<num>((e) => e as num).toList();
    sentence_grammar = json['sentence_grammar'] == null
                ? []
                : json['sentence_grammar'].map<GrammarSerializer>((e) => GrammarSerializer().fromJson(e as Map<String, dynamic>)).toList();
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    's_id': s_id,
    's_en': s_en,
    's_ch': s_ch,
    's_type': s_type,
    's_tags': s_tags == null ? null : s_tags.map((e) => e).toList(),
    's_tense': s_tense == null ? null : s_tense.map((e) => e).toList(),
    's_form': s_form == null ? null : s_form.map((e) => e).toList(),
    's_synonym': s_synonym == null ? null : s_synonym.map((e) => e).toList(),
    's_antonym': s_antonym == null ? null : s_antonym.map((e) => e).toList(),
    'sentence_grammar': sentence_grammar == null ? null : sentence_grammar.map((e) => e.toJson()).toList(),
  };
}


