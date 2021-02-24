// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
import 'package:json_annotation/json_annotation.dart';
import 'sentence.dart';
part 'relative_sentence.g.dart';

@JsonSerializable()
class RelativeSentenceSerializer {
    RelativeSentenceSerializer();

    num r_id = -1;
    SentenceSerializer r_sentence_a = SentenceSerializer();
    SentenceSerializer r_sentence_b = SentenceSerializer();
    bool r_type = true;

    factory RelativeSentenceSerializer.fromJson(Map<String,dynamic> json) => _$RelativeSentenceSerializerFromJson(json);
    Map<String, dynamic> toJson() => _$RelativeSentenceSerializerToJson(this);
}
