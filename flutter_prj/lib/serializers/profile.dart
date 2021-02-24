// GENERATED CODE BY json_serializer.py - DO NOT MODIFY BY HAND
import 'package:json_annotation/json_annotation.dart';
import 'word.dart';
import 'sentence.dart';
import 'user.dart';
import 'net_cache_config.dart';
import 'paraphrase.dart';
import 'cache_config.dart';
part 'profile.g.dart';

@JsonSerializable()
class ProfileSerializer {
    ProfileSerializer();

    UserSerializer user = UserSerializer();
    String token = '';
    num theme = 5678;
    CacheConfigSerializer cacheConfig = CacheConfigSerializer();
    String lastLogin = '';
    String locale = '';

    factory ProfileSerializer.fromJson(Map<String,dynamic> json) => _$ProfileSerializerFromJson(json);
    Map<String, dynamic> toJson() => _$ProfileSerializerToJson(this);
}
