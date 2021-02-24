// GENERATED CODE BY json_serializer.py - DO NOT MODIFY BY HAND
part of 'part_of_speech.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartOfSpeechSerializer _$PartOfSpeechSerializerFromJson(Map<String, dynamic> json) {
  return PartOfSpeechSerializer()
    ..partOfSpeech = json['partOfSpeech '] as String
    ..paraphrases = json['paraphrases'] == null
        ? null
        : json['paraphrases'].map<ParaphraseSerializer>((e) => e as ParaphraseSerializer).toList();
}

Map<String, dynamic> _$PartOfSpeechSerializerToJson(PartOfSpeechSerializer instance) => <String, dynamic>{
    'partOfSpeech': instance.partOfSpeech,
    'paraphrases': instance.paraphrases
};
