// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
import 'package:json_annotation/json_annotation.dart';

part 'distinguish.g.dart';

@JsonSerializable()
class DistinguishSerializer {
    DistinguishSerializer();

    num d_id = -1;
    List<String> d_words = [];
    String d_content = '';

    factory DistinguishSerializer.fromJson(Map<String,dynamic> json) => _$DistinguishSerializerFromJson(json);
    Map<String, dynamic> toJson() => _$DistinguishSerializerToJson(this);
}
