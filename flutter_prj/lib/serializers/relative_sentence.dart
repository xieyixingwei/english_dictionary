// GENERATED CODE BY json_serializer.py - DO NOT MODIFY BY HAND
import 'package:json_annotation/json_annotation.dart';
import 'word.dart';
import 'sentence.dart';
import 'user.dart';
import 'net_cache_config.dart';
import 'paraphrase.dart';
import 'cache_config.dart';
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
