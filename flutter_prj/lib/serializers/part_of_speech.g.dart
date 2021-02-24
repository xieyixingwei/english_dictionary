// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
part of 'part_of_speech.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartOfSpeechSerializer _$PartOfSpeechSerializerFromJson(Map<String, dynamic> json) {
  return PartOfSpeechSerializer()
    ..partOfSpeech = json['partOfSpeech'] as String
    ..paraphrases = json['paraphrases'] == null
        ? null
        : json['paraphrases'].map<ParaphraseSerializer>((e) => ParaphraseSerializer.fromJson(e as Map<String, dynamic>)).toList();
}

Map<String, dynamic> _$PartOfSpeechSerializerToJson(PartOfSpeechSerializer instance) => <String, dynamic>{
    'partOfSpeech': instance.partOfSpeech,
    'paraphrases': instance.paraphrases
};
