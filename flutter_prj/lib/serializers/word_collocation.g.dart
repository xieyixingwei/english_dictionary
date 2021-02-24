// GENERATED CODE BY json_serializer.py - DO NOT MODIFY BY HAND
part of 'word_collocation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordCollocationSerializer _$WordCollocationSerializerFromJson(Map<String, dynamic> json) {
  return WordCollocationSerializer()
    ..partOfSpeech = json['partOfSpeech '] as String
    ..exampleSentences = json['exampleSentences'] == null
        ? null
        : json['exampleSentences'].map<SentenceSerializer>((e) => e as SentenceSerializer).toList();
}

Map<String, dynamic> _$WordCollocationSerializerToJson(WordCollocationSerializer instance) => <String, dynamic>{
    'partOfSpeech': instance.partOfSpeech,
    'exampleSentences': instance.exampleSentences
};
