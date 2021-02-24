// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
part of 'word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordSerializer _$WordSerializerFromJson(Map<String, dynamic> json) {
  return WordSerializer()
    ..w_name = json['w_name'] as String
    ..w_voice_us = json['w_voice_us'] as String
    ..w_voice_uk = json['w_voice_uk'] as String
    ..w_morph = json['w_morph'] == null
        ? null
        : json['w_morph'].map<String>((e) => e as String).toList()
    ..w_tags = json['w_tags'] == null
        ? null
        : json['w_tags'].map<String>((e) => e as String).toList()
    ..w_etyma = json['w_etyma'] == null
        ? null
        : json['w_etyma'].map<String>((e) => e as String).toList()
    ..w_origin = json['w_origin'] as String
    ..w_shorthand = json['w_shorthand'] as String
    ..w_partofspeech = json['w_partofspeech'] == null
        ? null
        : json['w_partofspeech'].map<PartOfSpeechSerializer>((e) => PartOfSpeechSerializer.fromJson(e as Map<String, dynamic>)).toList()
    ..w_sentence_pattern = json['w_sentence_pattern'] == null
        ? null
        : json['w_sentence_pattern'].map<SentencePatternSerializer>((e) => SentencePatternSerializer.fromJson(e as Map<String, dynamic>)).toList()
    ..w_word_collocation = json['w_word_collocation'] == null
        ? null
        : json['w_word_collocation'].map<WordCollocationSerializer>((e) => WordCollocationSerializer.fromJson(e as Map<String, dynamic>)).toList();
}

Map<String, dynamic> _$WordSerializerToJson(WordSerializer instance) => <String, dynamic>{
    'w_name': instance.w_name,
    'w_voice_us': instance.w_voice_us,
    'w_voice_uk': instance.w_voice_uk,
    'w_morph': instance.w_morph,
    'w_tags': instance.w_tags,
    'w_etyma': instance.w_etyma,
    'w_origin': instance.w_origin,
    'w_shorthand': instance.w_shorthand,
    'w_partofspeech': instance.w_partofspeech,
    'w_sentence_pattern': instance.w_sentence_pattern,
    'w_word_collocation': instance.w_word_collocation
};
