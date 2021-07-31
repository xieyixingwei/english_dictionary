
// GENERATED CODE BY json_serializer.py - DO NOT MODIFY BY HAND
import 'Person';

part of 'UserSerializer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSerializer _$UserSerializerFromJson(Map<String, dynamic> json) {
  return UserSerializer()
    ..name = json['name'] as String
    ..height = json['height'] as double
    ..age = json['age'] as num
    ..email = json['email'] as String
    ..likes = json['likes'] as List<String>
    ..class = json['class'] as Map
    ..mother = json['mother'] as Person
    ..friends = json['friends'] as List<Person>;
}

Map<String, dynamic> _$UserSerializerToJson(UserSerializer instance) => <String, dynamic>{
    'name': instance.name,
    'height': instance.height,
    'age': instance.age,
    'email': instance.email,
    'likes': instance.likes,
    'class': instance.class,
    'mother': instance.mother,
    'friends': instance.friends
};
