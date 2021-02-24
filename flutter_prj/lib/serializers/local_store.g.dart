// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
part of 'local_store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalStoreSerializer _$LocalStoreSerializerFromJson(Map<String, dynamic> json) {
  return LocalStoreSerializer()
    ..user = json['user'] == null
        ? null
        : UserSerializer.fromJson(json['user'] as Map<String, dynamic>)
    ..token = json['token'] as String
    ..netCacheConfig = json['netCacheConfig'] == null
        ? null
        : NetCacheConfigSerializer.fromJson(json['netCacheConfig'] as Map<String, dynamic>);
}

Map<String, dynamic> _$LocalStoreSerializerToJson(LocalStoreSerializer instance) => <String, dynamic>{
    'user': instance.user,
    'token': instance.token,
    'netCacheConfig': instance.netCacheConfig
};
