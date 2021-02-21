// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sentence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sentence _$SentenceFromJson(Map<String, dynamic> json) {
  return Sentence()
    ..s_id = json['s_id'] as num
    ..s_en = json['s_en'] as String
    ..s_ch = json['s_ch'] as String
    ..s_type = json['s_type'] as num
    ..s_tags = json['s_tags'] as List<String>
    ..s_tense = json['s_tense'] as List<String>
    ..s_form = json['s_form'] as List<String>;
}

Map<String, dynamic> _$SentenceToJson(Sentence instance) => <String, dynamic>{
      's_id': instance.s_id,
      's_en': instance.s_en,
      's_ch': instance.s_ch,
      's_type': instance.s_type,
      's_tags': instance.s_tags,
      's_tense': instance.s_tense,
      's_form': instance.s_form
    };
