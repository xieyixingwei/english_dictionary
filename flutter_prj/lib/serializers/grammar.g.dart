// GENERATED CODE BY json_serializer.py - DO NOT MODIFY BY HAND
part of 'grammar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrammarSerializer _$GrammarSerializerFromJson(Map<String, dynamic> json) {
  return GrammarSerializer()
    ..g_id = json['g_id '] as num
    ..g_type = json['g_type'] == null
        ? null
        : json['g_type'].map<String>((e) => e as String).toList()
    ..g_tags = json['g_tags'] == null
        ? null
        : json['g_tags'].map<String>((e) => e as String).toList()
    ..g_content = json['g_content '] as String;
}

Map<String, dynamic> _$GrammarSerializerToJson(GrammarSerializer instance) => <String, dynamic>{
    'g_id': instance.g_id,
    'g_type': instance.g_type,
    'g_tags': instance.g_tags,
    'g_content': instance.g_content
};
