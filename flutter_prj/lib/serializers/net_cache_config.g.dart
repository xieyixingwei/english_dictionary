// GENERATED CODE BY json_serializer.py - DO NOT MODIFY BY HAND
part of 'net_cache_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetCacheConfigSerializer _$NetCacheConfigSerializerFromJson(Map<String, dynamic> json) {
  return NetCacheConfigSerializer()
    ..enable = json['enable '] as bool
    ..maxAge = json['maxAge '] as num
    ..maxCount = json['maxCount '] as num;
}

Map<String, dynamic> _$NetCacheConfigSerializerToJson(NetCacheConfigSerializer instance) => <String, dynamic>{
    'enable': instance.enable,
    'maxAge': instance.maxAge,
    'maxCount': instance.maxCount
};
