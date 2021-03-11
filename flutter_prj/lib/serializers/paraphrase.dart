// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'sentence.dart';


class ParaphraseSerializer {
  ParaphraseSerializer();

  num id;
  String interpret = '';
  String partOfSpeech = '';
  String wordForeign;
  num sentencePatternForeign;
  List<SentenceSerializer> sentenceSet = [];
  


  ParaphraseSerializer fromJson(Map<String, dynamic> json) {
    id = json['id'] == null ? null : json['id'] as num;
    interpret = json['interpret'] == null ? null : json['interpret'] as String;
    partOfSpeech = json['partOfSpeech'] == null ? null : json['partOfSpeech'] as String;
    wordForeign = json['wordForeign'] == null ? null : json['wordForeign'] as String;
    sentencePatternForeign = json['sentencePatternForeign'] == null ? null : json['sentencePatternForeign'] as num;
    sentenceSet = json['sentenceSet'] == null
                ? []
                : json['sentenceSet'].map<SentenceSerializer>((e) => SentenceSerializer().fromJson(e as Map<String, dynamic>)).toList();
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'interpret': interpret,
    'partOfSpeech': partOfSpeech,
    'wordForeign': wordForeign,
    'sentencePatternForeign': sentencePatternForeign,
  };
}


