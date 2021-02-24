// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
part of 'word_collocation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordCollocationSerializer _$WordCollocationSerializerFromJson(Map<String, dynamic> json) {
  return WordCollocationSerializer()
    ..partOfSpeech = json['partOfSpeech'] as String
    ..exampleSentences = json['exampleSentences'] == null
        ? null
        : json['exampleSentences'].map<SentenceSerializer>((e) => SentenceSerializer.fromJson(e as Map<String, dynamic>)).toList();
}

Map<String, dynamic> _$WordCollocationSerializerToJson(WordCollocationSerializer instance) => <String, dynamic>{
    'partOfSpeech': instance.partOfSpeech,
    'exampleSentences': instance.exampleSentences
};
