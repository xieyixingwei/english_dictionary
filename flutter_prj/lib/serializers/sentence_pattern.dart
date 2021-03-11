// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'paraphrase.dart';


class SentencePatternSerializer {
  SentencePatternSerializer();

  num id;
  String content = '';
  String wordForeign;
  List<ParaphraseSerializer> paraphraseSet = [];
  


  SentencePatternSerializer fromJson(Map<String, dynamic> json) {
    id = json['id'] == null ? null : json['id'] as num;
    content = json['content'] == null ? null : json['content'] as String;
    wordForeign = json['wordForeign'] == null ? null : json['wordForeign'] as String;
    paraphraseSet = json['paraphraseSet'] == null
                ? []
                : json['paraphraseSet'].map<ParaphraseSerializer>((e) => ParaphraseSerializer().fromJson(e as Map<String, dynamic>)).toList();
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'content': content,
    'wordForeign': wordForeign,
  };
}


