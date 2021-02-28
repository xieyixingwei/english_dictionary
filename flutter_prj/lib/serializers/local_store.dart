// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************
import 'user.dart';

import 'net_cache_config.dart';


class LocalStoreSerializer {
  LocalStoreSerializer();

  UserSerializer user = UserSerializer();
  String token = '';
  NetCacheConfigSerializer netCacheConfig = NetCacheConfigSerializer();


  LocalStoreSerializer fromJson(Map<String, dynamic> json) {
    user = json['user'] == null
                ? null
                : UserSerializer().fromJson(json['user'] as Map<String, dynamic>);
    token = json['token'] as String;
    netCacheConfig = json['netCacheConfig'] == null
                ? null
                : NetCacheConfigSerializer().fromJson(json['netCacheConfig'] as Map<String, dynamic>);
    return this;
  }

  factory LocalStoreSerializer.newFromJson(Map<String, dynamic> json) {
    return LocalStoreSerializer()
      ..user = json['user'] == null
                ? null
                : UserSerializer().fromJson(json['user'] as Map<String, dynamic>)
      ..token = json['token'] as String
      ..netCacheConfig = json['netCacheConfig'] == null
                ? null
                : NetCacheConfigSerializer().fromJson(json['netCacheConfig'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'user': user == null ? null : user.toJson(),
    'token': token,
    'netCacheConfig': netCacheConfig == null ? null : netCacheConfig.toJson(),
  };
}
