// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
import 'package:json_annotation/json_annotation.dart';
import 'sentence.dart';
part 'sentence_pattern.g.dart';

@JsonSerializable()
class SentencePatternSerializer {
    SentencePatternSerializer();

    String pattern = '';
    List<SentenceSerializer> exampleSentences = [];

    factory SentencePatternSerializer.fromJson(Map<String,dynamic> json) => _$SentencePatternSerializerFromJson(json);
    Map<String, dynamic> toJson() => _$SentencePatternSerializerToJson(this);
}
