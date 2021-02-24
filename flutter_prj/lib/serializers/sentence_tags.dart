// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
import 'package:json_annotation/json_annotation.dart';

part 'sentence_tags.g.dart';

@JsonSerializable()
class SentenceTagsSerializer {
    SentenceTagsSerializer();

    String t_name = '';

    factory SentenceTagsSerializer.fromJson(Map<String,dynamic> json) => _$SentenceTagsSerializerFromJson(json);
    Map<String, dynamic> toJson() => _$SentenceTagsSerializerToJson(this);
}
