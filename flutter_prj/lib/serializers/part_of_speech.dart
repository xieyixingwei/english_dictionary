// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'paraphrase.dart';


class PartOfSpeechSerializer {
  PartOfSpeechSerializer();

  String type = '';
  List<ParaphraseSerializer> means = [];
  


  PartOfSpeechSerializer fromJson(Map<String, dynamic> json) {
    type = json['type'] as String;
    means = json['means'] == null
                ? []
                : json['means'].map<ParaphraseSerializer>((e) => ParaphraseSerializer().fromJson(e as Map<String, dynamic>)).toList();
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'type': type,
    'means': means == null ? null : means.map((e) => e.toJson()).toList(),
  };
}


