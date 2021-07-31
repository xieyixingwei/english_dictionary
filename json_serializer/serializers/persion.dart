
// GENERATED CODE BY json_serializer.py - DO NOT MODIFY BY HAND
import 'package:json_annotation/json_annotation.dart';

part 'persion.g.dart';

@JsonSerializable()
class PersionSerializer {
    PersionSerializer();

    String name = "Tom";
    num age = 12;

    factory PersionSerializer.fromJson(Map<String,dynamic> json) => _$PersionSerializerFromJson(json);
    Map<String, dynamic> toJson() => _$PersionSerializerToJson(this);
}
