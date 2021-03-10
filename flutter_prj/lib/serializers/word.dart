// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'part_of_speech.dart';
import 'sentence_pattern.dart';
import 'word_collocation.dart';
import 'distinguish.dart';
import 'grammar.dart';
import 'package:flutter_prj/common/http.dart';


class WordSerializer {
  WordSerializer();

  String w_name = '';
  String w_voice_us = '';
  String w_voice_uk = '';
  List<String> w_morph = [];
  List<String> w_tags = [];
  List<String> w_etyma = [];
  String w_origin = '';
  String w_shorthand = '';
  List<PartOfSpeechSerializer> w_partofspeech = [];
  List<SentencePatternSerializer> w_sentence_pattern = [];
  List<WordCollocationSerializer> w_word_collocation = [];
  List<String> w_synonym = [];
  List<String> w_antonym = [];
  List<DistinguishSerializer> distinguish = [];
  List<GrammarSerializer> word_grammar = [];
  

  Future<WordSerializer> create({dynamic data, Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/dictionary/word/create/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : WordSerializer().fromJson(res.data);
  }

  Future<WordSerializer> update({dynamic data, Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    var res = await Http().request(HttpType.PUT, '/dictionary/word/update/$w_name/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : WordSerializer().fromJson(res.data);
  }

  Future<WordSerializer> retrieve({Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/dictionary/word/$w_name/', queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : WordSerializer().fromJson(res.data);
  }

  Future<bool> delete({dynamic data, Map<String, dynamic> queryParameters, bool cache=false}) async {
    if(w_name == null) return false;
    var res = await Http().request(HttpType.DELETE, '/dictionary/word/delete/$w_name/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    /*
    if(word_grammar != null){word_grammar.forEach((e){e.delete();});}
    */
    return res != null ? res.statusCode == 204 : false;
  }

  Future<WordSerializer> save({dynamic data, Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    WordSerializer res = w_name == null
                               ? await this.create(data:data, queryParameters:queryParameters, update:update, cache:cache)
                               : await this.update(data:data, queryParameters:queryParameters, update:update, cache:cache);
    if(word_grammar != null){word_grammar.forEach((e){ e.save();});}
    return res;
  }

  WordSerializer fromJson(Map<String, dynamic> json) {
    w_name = json['w_name'] as String;
    w_voice_us = json['w_voice_us'] as String;
    w_voice_uk = json['w_voice_uk'] as String;
    w_morph = json['w_morph'] == null
                ? []
                : json['w_morph'].map<String>((e) => e as String).toList();
    w_tags = json['w_tags'] == null
                ? []
                : json['w_tags'].map<String>((e) => e as String).toList();
    w_etyma = json['w_etyma'] == null
                ? []
                : json['w_etyma'].map<String>((e) => e as String).toList();
    w_origin = json['w_origin'] as String;
    w_shorthand = json['w_shorthand'] as String;
    w_partofspeech = json['w_partofspeech'] == null
                ? []
                : json['w_partofspeech'].map<PartOfSpeechSerializer>((e) => PartOfSpeechSerializer().fromJson(e as Map<String, dynamic>)).toList();
    w_sentence_pattern = json['w_sentence_pattern'] == null
                ? []
                : json['w_sentence_pattern'].map<SentencePatternSerializer>((e) => SentencePatternSerializer().fromJson(e as Map<String, dynamic>)).toList();
    w_word_collocation = json['w_word_collocation'] == null
                ? []
                : json['w_word_collocation'].map<WordCollocationSerializer>((e) => WordCollocationSerializer().fromJson(e as Map<String, dynamic>)).toList();
    w_synonym = json['w_synonym'] == null
                ? []
                : json['w_synonym'].map<String>((e) => e as String).toList();
    w_antonym = json['w_antonym'] == null
                ? []
                : json['w_antonym'].map<String>((e) => e as String).toList();
    distinguish = json['distinguish'] == null
                ? []
                : json['distinguish'].map<DistinguishSerializer>((e) => DistinguishSerializer().fromJson(e as Map<String, dynamic>)).toList();
    word_grammar = json['word_grammar'] == null
                ? []
                : json['word_grammar'].map<GrammarSerializer>((e) => GrammarSerializer().fromJson(e as Map<String, dynamic>)).toList();
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'w_name': w_name,
    'w_voice_us': w_voice_us,
    'w_voice_uk': w_voice_uk,
    'w_morph': w_morph == null ? null : w_morph.map((e) => e).toList(),
    'w_tags': w_tags == null ? null : w_tags.map((e) => e).toList(),
    'w_etyma': w_etyma == null ? null : w_etyma.map((e) => e).toList(),
    'w_origin': w_origin,
    'w_shorthand': w_shorthand,
    'w_partofspeech': w_partofspeech == null ? null : w_partofspeech.map((e) => e.toJson()).toList(),
    'w_sentence_pattern': w_sentence_pattern == null ? null : w_sentence_pattern.map((e) => e.toJson()).toList(),
    'w_word_collocation': w_word_collocation == null ? null : w_word_collocation.map((e) => e.toJson()).toList(),
    'w_synonym': w_synonym == null ? null : w_synonym.map((e) => e).toList(),
    'w_antonym': w_antonym == null ? null : w_antonym.map((e) => e).toList(),
    'distinguish': distinguish == null ? null : distinguish.map((e) => e.toJson()).toList(),
    'word_grammar': word_grammar == null ? null : word_grammar.map((e) => e.toJson()).toList(),
  };
}


