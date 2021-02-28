// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'paraphrase.dart';


class PartOfSpeechSerializer {
  PartOfSpeechSerializer();

  String partOfSpeech = '';
  List<ParaphraseSerializer> paraphrases = [];


  PartOfSpeechSerializer fromJson(Map<String, dynamic> json) {
    partOfSpeech = json['partOfSpeech'] as String;
    paraphrases = json['paraphrases'] == null
                ? []
                : json['paraphrases'].map<ParaphraseSerializer>((e) => ParaphraseSerializer().fromJson(e as Map<String, dynamic>)).toList();
    return this;
  }

  factory PartOfSpeechSerializer.newFromJson(Map<String, dynamic> json) {
    return PartOfSpeechSerializer()
      ..partOfSpeech = json['partOfSpeech'] as String
      ..paraphrases = json['paraphrases'] == null
                ? []
                : json['paraphrases'].map<ParaphraseSerializer>((e) => ParaphraseSerializer().fromJson(e as Map<String, dynamic>)).toList();
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'partOfSpeech': partOfSpeech,
    'paraphrases': paraphrases == null ? null : paraphrases.map((e) => e.toJson()).toList(),
  };
}
