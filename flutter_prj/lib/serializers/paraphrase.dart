// GENERATED CODE BY json_serializer.py - DO NOT MODIFY BY HAND
import 'package:json_annotation/json_annotation.dart';
import 'word.dart';
import 'sentence.dart';
import 'user.dart';
import 'net_cache_config.dart';
part 'paraphrase.g.dart';

@JsonSerializable()
class ParaphraseSerializer {
    ParaphraseSerializer();

    String paraphrase = '';
    List<SentenceSerializer> exampleSentences = [];

    factory ParaphraseSerializer.fromJson(Map<String,dynamic> json) => _$ParaphraseSerializerFromJson(json);
    Map<String, dynamic> toJson() => _$ParaphraseSerializerToJson(this);
}
