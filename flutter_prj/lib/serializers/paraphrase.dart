// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
import 'package:json_annotation/json_annotation.dart';
import 'sentence.dart';
part 'paraphrase.g.dart';

@JsonSerializable()
class ParaphraseSerializer {
    ParaphraseSerializer();

    String paraphrase = '';
    List<SentenceSerializer> exampleSentences = [];

    factory ParaphraseSerializer.fromJson(Map<String,dynamic> json) => _$ParaphraseSerializerFromJson(json);
    Map<String, dynamic> toJson() => _$ParaphraseSerializerToJson(this);
}
