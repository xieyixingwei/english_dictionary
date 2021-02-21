// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Word _$WordFromJson(Map<String, dynamic> json) {
  return Word()
    ..w_name = json['w_name'] as String
    ..w_voice_us = json['w_voice_us'] as String
    ..w_voice_uk = json['u_passwd'] as String
    ..w_morph = json['w_morph'] as List<String>
    ..w_tags = json['w_tags'] as List<String>
    ..w_etyma = json['w_etyma'] as List<String>
    ..w_origin = json['w_origin'] as String
    ..w_shorthand = json['w_shorthand'] as String
    ..w_partofspeech = json['w_partofspeech'] as List<Map>
    ..w_sentence_pattern = json['w_sentence_pattern'] as List<Map>
    ..w_word_collocation = json['w_word_collocation'] as List<Map>;
}

Map<String, dynamic> _$WordToJson(Word instance) => <String, dynamic>{
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
