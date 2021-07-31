
// GENERATED CODE BY json_serializer.py - DO NOT MODIFY BY HAND
part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSerializer _$UserSerializerFromJson(Map<String, dynamic> json) {
  return UserSerializer()
    ..name = json['name'] as String
    ..height = json['height'] as double
    ..age = json['age'] as num
    ..email = json['email'] as String
    ..likes = json['likes'] == null
        ? null
        : json['likes'].map((e) => PersonSerializer.fromJson(e as Map<String, dynamic>)).toList()
    ..grade = json['grade'] as Map<String, dynamic>
    ..mother = json['mother'] == null
        ? null
        : PersonSerializer.fromJson(json['mother'] as Map<String, dynamic>)
    ..friends = json['friends'] == null
        ? null
        : json['friends'].map((e) => PersonSerializer.fromJson(e as Map<String, dynamic>)).toList();
}

Map<String, dynamic> _$UserSerializerToJson(UserSerializer instance) => <String, dynamic>{
    'name': instance.name,
    'height': instance.height,
    'age': instance.age,
    'email': instance.email,
    'likes': instance.likes,
    'grade': instance.grade,
    'mother': instance.mother,
    'friends': instance.friends
};
