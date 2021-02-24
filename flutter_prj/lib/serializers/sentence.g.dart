// GENERATED CODE BY json_serializer.py - DO NOT MODIFY BY HAND
part of 'sentence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SentenceSerializer _$SentenceSerializerFromJson(Map<String, dynamic> json) {
  return SentenceSerializer()
    ..s_id = json['s_id '] as num
    ..s_en = json['s_en '] as String
    ..s_ch = json['s_ch '] as String
    ..s_type = json['s_type '] as num
    ..s_tags = json['s_tags'] == null
        ? null
        : json['s_tags'].map<String>((e) => e as String).toList()
    ..s_tense = json['s_tense'] == null
        ? null
        : json['s_tense'].map<String>((e) => e as String).toList()
    ..s_form = json['s_form'] == null
        ? null
        : json['s_form'].map<String>((e) => e as String).toList();
}

Map<String, dynamic> _$SentenceSerializerToJson(SentenceSerializer instance) => <String, dynamic>{
    's_id': instance.s_id,
    's_en': instance.s_en,
    's_ch': instance.s_ch,
    's_type': instance.s_type,
    's_tags': instance.s_tags,
    's_tense': instance.s_tense,
    's_form': instance.s_form
};
