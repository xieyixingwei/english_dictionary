// GENERATED CODE BY json_serializer.py - DO NOT MODIFY BY HAND
part of 'cache_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CacheConfigSerializer _$CacheConfigSerializerFromJson(Map<String, dynamic> json) {
  return CacheConfigSerializer()
    ..enable = json['enable '] as bool
    ..maxAge = json['maxAge '] as num
    ..maxCount = json['maxCount '] as num;
}

Map<String, dynamic> _$CacheConfigSerializerToJson(CacheConfigSerializer instance) => <String, dynamic>{
    'enable': instance.enable,
    'maxAge': instance.maxAge,
    'maxCount': instance.maxCount
};
