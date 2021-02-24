// GENERATED CODE BY json_serializer.py - DO NOT MODIFY BY HAND
import 'package:json_annotation/json_annotation.dart';
import 'word.dart';
import 'sentence.dart';
part 'grammar.g.dart';

@JsonSerializable()
class GrammarSerializer {
    GrammarSerializer();

    num g_id = -1;
    List<String> g_type = [];
    List<String> g_tags = [];
    String g_content = '';
    List<WordSerializer> g_word = [];
    List<SentenceSerializer> g_sentence = [];

    factory GrammarSerializer.fromJson(Map<String,dynamic> json) => _$GrammarSerializerFromJson(json);
    Map<String, dynamic> toJson() => _$GrammarSerializerToJson(this);
}
