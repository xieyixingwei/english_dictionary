// GENERATED CODE BY json_serializer.py - DO NOT MODIFY BY HAND
part of 'relative_sentence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelativeSentenceSerializer _$RelativeSentenceSerializerFromJson(Map<String, dynamic> json) {
  return RelativeSentenceSerializer()
    ..r_id = json['r_id '] as num
    ..r_sentence_a = json['r_sentence_a'] == null
        ? null
        : SentenceSerializer.fromJson(json['r_sentence_a'] as Map<String, dynamic>)
    ..r_sentence_b = json['r_sentence_b'] == null
        ? null
        : SentenceSerializer.fromJson(json['r_sentence_b'] as Map<String, dynamic>)
    ..r_type = json['r_type '] as bool;
}

Map<String, dynamic> _$RelativeSentenceSerializerToJson(RelativeSentenceSerializer instance) => <String, dynamic>{
    'r_id': instance.r_id,
    'r_sentence_a': instance.r_sentence_a,
    'r_sentence_b': instance.r_sentence_b,
    'r_type': instance.r_type
};
