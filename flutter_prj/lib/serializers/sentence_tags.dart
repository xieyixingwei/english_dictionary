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
part 'sentence_tags.g.dart';

@JsonSerializable()
class SentenceTagsSerializer {
    SentenceTagsSerializer();

    String t_name = '';

    factory SentenceTagsSerializer.fromJson(Map<String,dynamic> json) => _$SentenceTagsSerializerFromJson(json);
    Map<String, dynamic> toJson() => _$SentenceTagsSerializerToJson(this);
}
