// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
import 'package:json_annotation/json_annotation.dart';
import 'part_of_speech.dart';
import 'sentence_pattern.dart';
import 'word_collocation.dart';
import 'distinguish.dart';
import 'grammar.dart';
part 'word.g.dart';

@JsonSerializable()
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

    factory WordSerializer.fromJson(Map<String,dynamic> json) => _$WordSerializerFromJson(json);
    Map<String, dynamic> toJson() => _$WordSerializerToJson(this);
}
