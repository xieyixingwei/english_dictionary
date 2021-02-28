// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'sentence.dart';


class ParaphraseSerializer {
  ParaphraseSerializer();

  String paraphrase = '';
  List<SentenceSerializer> exampleSentences = [];


  ParaphraseSerializer fromJson(Map<String, dynamic> json) {
    paraphrase = json['paraphrase'] as String;
    exampleSentences = json['exampleSentences'] == null
                ? []
                : json['exampleSentences'].map<SentenceSerializer>((e) => SentenceSerializer().fromJson(e as Map<String, dynamic>)).toList();
    return this;
  }

  factory ParaphraseSerializer.newFromJson(Map<String, dynamic> json) {
    return ParaphraseSerializer()
      ..paraphrase = json['paraphrase'] as String
      ..exampleSentences = json['exampleSentences'] == null
                ? []
                : json['exampleSentences'].map<SentenceSerializer>((e) => SentenceSerializer().fromJson(e as Map<String, dynamic>)).toList();
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'paraphrase': paraphrase,
    'exampleSentences': exampleSentences == null ? null : exampleSentences.map((e) => e.toJson()).toList(),
  };
}
