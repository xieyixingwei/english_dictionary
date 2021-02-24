// GENERATED CODE BY json_serializer.py - DO NOT MODIFY BY HAND
import 'package:json_annotation/json_annotation.dart';
import 'word.dart';
import 'sentence.dart';
import 'user.dart';
import 'net_cache_config.dart';
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
