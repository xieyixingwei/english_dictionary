// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
part of 'sentence_pattern.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SentencePatternSerializer _$SentencePatternSerializerFromJson(Map<String, dynamic> json) {
  return SentencePatternSerializer()
    ..pattern = json['pattern'] as String
    ..exampleSentences = json['exampleSentences'] == null
        ? null
        : json['exampleSentences'].map<SentenceSerializer>((e) => SentenceSerializer.fromJson(e as Map<String, dynamic>)).toList();
}

Map<String, dynamic> _$SentencePatternSerializerToJson(SentencePatternSerializer instance) => <String, dynamic>{
    'pattern': instance.pattern,
    'exampleSentences': instance.exampleSentences
};
