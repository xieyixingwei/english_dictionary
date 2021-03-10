// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'sentence.dart';


class WordCollocationSerializer {
  WordCollocationSerializer();

  String partOfSpeech = '';
  List<SentenceSerializer> exampleSentences = [];
  


  WordCollocationSerializer fromJson(Map<String, dynamic> json) {
    partOfSpeech = json['partOfSpeech'] == null ? null : json['partOfSpeech'] as String;
    exampleSentences = json['exampleSentences'] == null
                ? []
                : json['exampleSentences'].map<SentenceSerializer>((e) => SentenceSerializer().fromJson(e as Map<String, dynamic>)).toList();
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'partOfSpeech': partOfSpeech,
    'exampleSentences': exampleSentences == null ? null : exampleSentences.map((e) => e.toJson()).toList(),
  };
}


