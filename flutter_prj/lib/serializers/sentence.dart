// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
import 'package:json_annotation/json_annotation.dart';
import 'relative_sentence.dart';
import 'grammar.dart';
part 'sentence.g.dart';

@JsonSerializable()
class SentenceSerializer {
    SentenceSerializer();

    num s_id = -1;
    String s_en = '';
    String s_ch = '';
    num s_type = 0;
    List<String> s_tags = [];
    List<String> s_tense = [];
    List<String> s_form = [];
    List<RelativeSentenceSerializer> s_synonym = [];
    List<RelativeSentenceSerializer> s_antonym = [];
    List<GrammarSerializer> s_grammar_id = [];

    factory SentenceSerializer.fromJson(Map<String,dynamic> json) => _$SentenceSerializerFromJson(json);
    Map<String, dynamic> toJson() => _$SentenceSerializerToJson(this);
}
