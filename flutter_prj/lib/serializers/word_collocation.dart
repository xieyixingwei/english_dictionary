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
import 'part_of_speech.dart';
import 'sentence_pattern.dart';
import 'word_collocation.dart';
import 'distinguish.dart';
part 'word_collocation.g.dart';

@JsonSerializable()
class WordCollocationSerializer {
    WordCollocationSerializer();

    String partOfSpeech = '';
    List<SentenceSerializer> exampleSentences = [];

    factory WordCollocationSerializer.fromJson(Map<String,dynamic> json) => _$WordCollocationSerializerFromJson(json);
    Map<String, dynamic> toJson() => _$WordCollocationSerializerToJson(this);
}
