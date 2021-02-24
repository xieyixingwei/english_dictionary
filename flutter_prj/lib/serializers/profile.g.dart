// GENERATED CODE BY json_serializer.py - DO NOT MODIFY BY HAND
part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileSerializer _$ProfileSerializerFromJson(Map<String, dynamic> json) {
  return ProfileSerializer()
    ..user = json['user'] == null
        ? null
        : UserSerializer.fromJson(json['user'] as Map<String, dynamic>)
    ..token = json['token '] as String
    ..theme = json['theme '] as num
    ..cacheConfig = json['cacheConfig'] == null
        ? null
        : CacheConfigSerializer.fromJson(json['cacheConfig'] as Map<String, dynamic>)
    ..lastLogin = json['lastLogin '] as String
    ..locale = json['locale '] as String;
}

Map<String, dynamic> _$ProfileSerializerToJson(ProfileSerializer instance) => <String, dynamic>{
    'user': instance.user,
    'token': instance.token,
    'theme': instance.theme,
    'cacheConfig': instance.cacheConfig,
    'lastLogin': instance.lastLogin,
    'locale': instance.locale
};
