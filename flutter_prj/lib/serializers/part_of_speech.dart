// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
import 'package:json_annotation/json_annotation.dart';
import 'paraphrase.dart';
part 'part_of_speech.g.dart';

@JsonSerializable()
class PartOfSpeechSerializer {
    PartOfSpeechSerializer();

    String partOfSpeech = '';
    List<ParaphraseSerializer> paraphrases = [];

    factory PartOfSpeechSerializer.fromJson(Map<String,dynamic> json) => _$PartOfSpeechSerializerFromJson(json);
    Map<String, dynamic> toJson() => _$PartOfSpeechSerializerToJson(this);
}
