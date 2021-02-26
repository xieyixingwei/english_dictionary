// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************
import 'relative_sentence.dart';
import 'grammar.dart';
import 'package:flutter_prj/common/http.dart';


class SentenceSerializer {
  SentenceSerializer();

  num s_id;
  String s_en = '';
  String s_ch = '';
  num s_type = 0;
  List<String> s_tags = [];
  List<String> s_tense;
  List<String> s_form = [''];
  List<RelativeSentenceSerializer> s_synonym = [];
  List<RelativeSentenceSerializer> s_antonym = [];
  List<GrammarSerializer> sentence_grammar = [];

  Future<SentenceSerializer> create({dynamic data, Map<String, dynamic> queryParameters, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/dictionary/sentence/create/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    return this.fromJson(res.data);
  }

  Future<SentenceSerializer> update({dynamic data, Map<String, dynamic> queryParameters, bool cache=false}) async {
    var res = await Http().request(HttpType.PUT, '/dictionary/sentence/update/$s_id/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    return this.fromJson(res.data);
  }

  Future<SentenceSerializer> retrieve({Map<String, dynamic> queryParameters, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/dictionary/sentence/$s_id/', queryParameters:queryParameters, cache:cache);
    return this.fromJson(res.data);
  }

  Future<bool> delete({dynamic data, Map<String, dynamic> queryParameters, bool cache=false}) async {
    var res = await Http().request(HttpType.DELETE, '/dictionary/sentence/delete/$s_id/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    return res.statusCode == 204;
  }

  Future<SentenceSerializer> save({dynamic data, Map<String, dynamic> queryParameters, bool cache=false}) async {
    SentenceSerializer res = s_id == null
                               ? await this.create(data:data, queryParameters:queryParameters, cache:cache)
                               : await this.update(data:data, queryParameters:queryParameters, cache:cache);
    return res;
  }

  SentenceSerializer fromJson(Map<String, dynamic> json) {
    s_id = json['s_id'] as num;
    s_en = json['s_en'] as String;
    s_ch = json['s_ch'] as String;
    s_type = json['s_type'] as num;
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
        : json['s_synonym'].map<RelativeSentenceSerializer>((e) => RelativeSentenceSerializer().fromJson(e as Map<String, dynamic>)).toList();
    s_antonym = json['s_antonym'] == null
        ? []
        : json['s_antonym'].map<RelativeSentenceSerializer>((e) => RelativeSentenceSerializer().fromJson(e as Map<String, dynamic>)).toList();
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
    's_tags': s_tags,
    's_tense': s_tense,
    's_form': s_form,
  };

}
