// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'paraphrase.dart';
import 'sentence_pattern.dart';
import 'grammar.dart';
import 'distinguish.dart';
import 'package:flutter_prj/common/http.dart';


class WordSerializer {
  WordSerializer();

  String name = '';
  String voiceUs = '';
  String voiceUk = '';
  List<String> morph = [];
  List<String> tag = [];
  List<String> etyma = [];
  String origin = '';
  String shorthand = '';
  List<String> synonym = [];
  List<String> antonym = [];
  String image = '';
  String vedio = '';
  List<ParaphraseSerializer> paraphraseSet = [];
  List<SentencePatternSerializer> sentencePatternSet = [];
  List<GrammarSerializer> grammarSet = [];
  List<DistinguishSerializer> distinguishSet = [];
  

  Future<WordSerializer> create({dynamic data, Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/dictionary/word/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : WordSerializer().fromJson(res.data);
  }

  Future<WordSerializer> update({dynamic data, Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    var res = await Http().request(HttpType.PUT, '/dictionary/word/$name/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : WordSerializer().fromJson(res.data);
  }

  Future<WordSerializer> retrieve({Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/dictionary/word/$name/', queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : WordSerializer().fromJson(res.data);
  }

  Future<bool> delete({dynamic data, Map<String, dynamic> queryParameters, bool cache=false}) async {
    if(name == null) return false;
    var res = await Http().request(HttpType.DELETE, '/dictionary/word/$name/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    /*
    if(grammarSet != null){grammarSet.forEach((e){e.delete();});}
    */
    return res != null ? res.statusCode == 204 : false;
  }

  Future<WordSerializer> save({dynamic data, Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    WordSerializer res = name == null
                               ? await this.create(data:data, queryParameters:queryParameters, update:update, cache:cache)
                               : await this.update(data:data, queryParameters:queryParameters, update:update, cache:cache);
    if(grammarSet != null){grammarSet.forEach((e){ e.save();});}
    return res;
  }

  WordSerializer fromJson(Map<String, dynamic> json) {
    name = json['name'] == null ? null : json['name'] as String;
    voiceUs = json['voiceUs'] == null ? null : json['voiceUs'] as String;
    voiceUk = json['voiceUk'] == null ? null : json['voiceUk'] as String;
    morph = json['morph'] == null
                ? []
                : json['morph'].map<String>((e) => e as String).toList();
    tag = json['tag'] == null
                ? []
                : json['tag'].map<String>((e) => e as String).toList();
    etyma = json['etyma'] == null
                ? []
                : json['etyma'].map<String>((e) => e as String).toList();
    origin = json['origin'] == null ? null : json['origin'] as String;
    shorthand = json['shorthand'] == null ? null : json['shorthand'] as String;
    synonym = json['synonym'] == null
                ? []
                : json['synonym'].map<String>((e) => e as String).toList();
    antonym = json['antonym'] == null
                ? []
                : json['antonym'].map<String>((e) => e as String).toList();
    image = json['image'] == null ? null : json['image'] as String;
    vedio = json['vedio'] == null ? null : json['vedio'] as String;
    paraphraseSet = json['paraphraseSet'] == null
                ? []
                : json['paraphraseSet'].map<ParaphraseSerializer>((e) => ParaphraseSerializer().fromJson(e as Map<String, dynamic>)).toList();
    sentencePatternSet = json['sentencePatternSet'] == null
                ? []
                : json['sentencePatternSet'].map<SentencePatternSerializer>((e) => SentencePatternSerializer().fromJson(e as Map<String, dynamic>)).toList();
    grammarSet = json['grammarSet'] == null
                ? []
                : json['grammarSet'].map<GrammarSerializer>((e) => GrammarSerializer().fromJson(e as Map<String, dynamic>)).toList();
    distinguishSet = json['distinguishSet'] == null
                ? []
                : json['distinguishSet'].map<DistinguishSerializer>((e) => DistinguishSerializer().fromJson(e as Map<String, dynamic>)).toList();
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
    'voiceUs': voiceUs,
    'voiceUk': voiceUk,
    'morph': morph == null ? null : morph.map((e) => e).toList(),
    'tag': tag == null ? null : tag.map((e) => e).toList(),
    'etyma': etyma == null ? null : etyma.map((e) => e).toList(),
    'origin': origin,
    'shorthand': shorthand,
    'synonym': synonym == null ? null : synonym.map((e) => e).toList(),
    'antonym': antonym == null ? null : antonym.map((e) => e).toList(),
  };
}


