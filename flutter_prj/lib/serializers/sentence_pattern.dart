// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'sentence.dart';


class SentencePatternSerializer {
  SentencePatternSerializer();

  String pattern = '';
  List<SentenceSerializer> exampleSentences = [];
  


  SentencePatternSerializer fromJson(Map<String, dynamic> json) {
    pattern = json['pattern'] as String;
    exampleSentences = json['exampleSentences'] == null
                ? []
                : json['exampleSentences'].map<SentenceSerializer>((e) => SentenceSerializer().fromJson(e as Map<String, dynamic>)).toList();
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'pattern': pattern,
    'exampleSentences': exampleSentences == null ? null : exampleSentences.map((e) => e.toJson()).toList(),
  };
}


