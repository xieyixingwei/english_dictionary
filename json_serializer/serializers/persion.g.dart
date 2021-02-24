
// GENERATED CODE BY json_serializer.py - DO NOT MODIFY BY HAND
part of 'persion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersionSerializer _$PersionSerializerFromJson(Map<String, dynamic> json) {
  return PersionSerializer()
    ..name = json['name'] as String
    ..age = json['age'] as num;
}

Map<String, dynamic> _$PersionSerializerToJson(PersionSerializer instance) => <String, dynamic>{
    'name': instance.name,
    'age': instance.age
};
