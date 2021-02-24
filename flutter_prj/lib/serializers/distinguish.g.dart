// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
part of 'distinguish.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DistinguishSerializer _$DistinguishSerializerFromJson(Map<String, dynamic> json) {
  return DistinguishSerializer()
    ..d_id = json['d_id'] as num
    ..d_words = json['d_words'] == null
        ? null
        : json['d_words'].map<String>((e) => e as String).toList()
    ..d_content = json['d_content'] as String;
}

Map<String, dynamic> _$DistinguishSerializerToJson(DistinguishSerializer instance) => <String, dynamic>{
    'd_id': instance.d_id,
    'd_words': instance.d_words,
    'd_content': instance.d_content
};
