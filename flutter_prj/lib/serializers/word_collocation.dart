// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
import 'package:json_annotation/json_annotation.dart';
import 'sentence.dart';
part 'word_collocation.g.dart';

@JsonSerializable()
class WordCollocationSerializer {
    WordCollocationSerializer();

    String partOfSpeech = '';
    List<SentenceSerializer> exampleSentences = [];

    factory WordCollocationSerializer.fromJson(Map<String,dynamic> json) => _$WordCollocationSerializerFromJson(json);
    Map<String, dynamic> toJson() => _$WordCollocationSerializerToJson(this);
}
