// GENERATED CODE BY json_serializer.py - DO NOT MODIFY BY HAND
import 'package:json_annotation/json_annotation.dart';
import 'word.dart';
import 'sentence.dart';
import 'user.dart';
import 'net_cache_config.dart';
import 'paraphrase.dart';
import 'cache_config.dart';
import 'relative_sentence.dart';
import 'grammar.dart';
part 'sentence_pattern.g.dart';

@JsonSerializable()
class SentencePatternSerializer {
    SentencePatternSerializer();

    String pattern = '';
    List<SentenceSerializer> exampleSentences = [];

    factory SentencePatternSerializer.fromJson(Map<String,dynamic> json) => _$SentencePatternSerializerFromJson(json);
    Map<String, dynamic> toJson() => _$SentencePatternSerializerToJson(this);
}
