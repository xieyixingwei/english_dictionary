// GENERATED CODE BY json_serializer.py - DO NOT MODIFY BY HAND
import 'package:json_annotation/json_annotation.dart';
import 'word.dart';
import 'sentence.dart';
import 'user.dart';
import 'net_cache_config.dart';
part 'local_store.g.dart';

@JsonSerializable()
class LocalStoreSerializer {
    LocalStoreSerializer();

    UserSerializer user = UserSerializer();
    String token = '';
    NetCacheConfigSerializer netCacheConfig = NetCacheConfigSerializer();

    factory LocalStoreSerializer.fromJson(Map<String,dynamic> json) => _$LocalStoreSerializerFromJson(json);
    Map<String, dynamic> toJson() => _$LocalStoreSerializerToJson(this);
}
