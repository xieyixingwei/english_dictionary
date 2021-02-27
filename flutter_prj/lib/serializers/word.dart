// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'part_of_speech.dart';
import 'sentence_pattern.dart';
import 'word_collocation.dart';
import 'distinguish.dart';
import 'grammar.dart';


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
  List<DistinguishSerializer> w_distinguish = [];
  List<GrammarSerializer> w_grammar = [];


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
    w_distinguish = json['w_distinguish'] == null
                ? []
                : json['w_distinguish'].map<DistinguishSerializer>((e) => DistinguishSerializer().fromJson(e as Map<String, dynamic>)).toList();
    w_grammar = json['w_grammar'] == null
                ? []
                : json['w_grammar'].map<GrammarSerializer>((e) => GrammarSerializer().fromJson(e as Map<String, dynamic>)).toList();
    return this;
  }

  factory WordSerializer.newFromJson(Map<String, dynamic> json) {
    return WordSerializer()
      ..w_name = json['w_name'] as String
      ..w_voice_us = json['w_voice_us'] as String
      ..w_voice_uk = json['w_voice_uk'] as String
      ..w_morph = json['w_morph'] == null
                ? []
                : json['w_morph'].map<String>((e) => e as String).toList()
      ..w_tags = json['w_tags'] == null
                ? []
                : json['w_tags'].map<String>((e) => e as String).toList()
      ..w_etyma = json['w_etyma'] == null
                ? []
                : json['w_etyma'].map<String>((e) => e as String).toList()
      ..w_origin = json['w_origin'] as String
      ..w_shorthand = json['w_shorthand'] as String
      ..w_partofspeech = json['w_partofspeech'] == null
                ? []
                : json['w_partofspeech'].map<PartOfSpeechSerializer>((e) => PartOfSpeechSerializer().fromJson(e as Map<String, dynamic>)).toList()
      ..w_sentence_pattern = json['w_sentence_pattern'] == null
                ? []
                : json['w_sentence_pattern'].map<SentencePatternSerializer>((e) => SentencePatternSerializer().fromJson(e as Map<String, dynamic>)).toList()
      ..w_word_collocation = json['w_word_collocation'] == null
                ? []
                : json['w_word_collocation'].map<WordCollocationSerializer>((e) => WordCollocationSerializer().fromJson(e as Map<String, dynamic>)).toList()
      ..w_synonym = json['w_synonym'] == null
                ? []
                : json['w_synonym'].map<String>((e) => e as String).toList()
      ..w_antonym = json['w_antonym'] == null
                ? []
                : json['w_antonym'].map<String>((e) => e as String).toList()
      ..w_distinguish = json['w_distinguish'] == null
                ? []
                : json['w_distinguish'].map<DistinguishSerializer>((e) => DistinguishSerializer().fromJson(e as Map<String, dynamic>)).toList()
      ..w_grammar = json['w_grammar'] == null
                ? []
                : json['w_grammar'].map<GrammarSerializer>((e) => GrammarSerializer().fromJson(e as Map<String, dynamic>)).toList();
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
  };
}