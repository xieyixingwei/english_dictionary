// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
import 'package:json_annotation/json_annotation.dart';

part 'net_cache_config.g.dart';

@JsonSerializable()
class NetCacheConfigSerializer {
    NetCacheConfigSerializer();

    bool enable = true;
    num maxAge = 1000;
    num maxCount = 100;

    factory NetCacheConfigSerializer.fromJson(Map<String,dynamic> json) => _$NetCacheConfigSerializerFromJson(json);
    Map<String, dynamic> toJson() => _$NetCacheConfigSerializerToJson(this);
}
