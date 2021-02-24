// GENERATED CODE BY json_serializer.py - DO NOT MODIFY BY HAND
import 'package:json_annotation/json_annotation.dart';

part 'cache_config.g.dart';

@JsonSerializable()
class CacheConfigSerializer {
    CacheConfigSerializer();

    bool enable = true;
    num maxAge = 1000;
    num maxCount = 100;

    factory CacheConfigSerializer.fromJson(Map<String,dynamic> json) => _$CacheConfigSerializerFromJson(json);
    Map<String, dynamic> toJson() => _$CacheConfigSerializerToJson(this);
}
