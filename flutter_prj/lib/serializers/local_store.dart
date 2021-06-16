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


  LocalStoreSerializer fromJson(Map<String, dynamic> json, {bool slave = true}) {
    if(json == null) return this;
    user = json['user'] == null
                ? user
                : UserSerializer().fromJson(json['user'] as Map<String, dynamic>);
    token = json['token'] == null ? token : json['token'] as String;
    netCacheConfig = json['netCacheConfig'] == null
                ? netCacheConfig
                : NetCacheConfigSerializer().fromJson(json['netCacheConfig'] as Map<String, dynamic>);
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'user': user == null ? null : user.toJson(),
    'token': token,
    'netCacheConfig': netCacheConfig == null ? null : netCacheConfig.toJson(),
  }..removeWhere((k, v) => v==null);


  LocalStoreSerializer from(LocalStoreSerializer instance) {
    if(instance == null) return this;
    user = UserSerializer().from(instance.user);
    token = instance.token;
    netCacheConfig = NetCacheConfigSerializer().from(instance.netCacheConfig);
    return this;
  }
}



