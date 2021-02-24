// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
import 'package:json_annotation/json_annotation.dart';
import 'sentence.dart';
part 'list_senteces.g.dart';

@JsonSerializable()
class ListSentecesSerializer {
    ListSentecesSerializer();

    num count = 0;
    String next = '';
    String previous = '';
    List<SentenceSerializer> results = [];

    factory ListSentecesSerializer.fromJson(Map<String,dynamic> json) => _$ListSentecesSerializerFromJson(json);
    Map<String, dynamic> toJson() => _$ListSentecesSerializerToJson(this);
}
