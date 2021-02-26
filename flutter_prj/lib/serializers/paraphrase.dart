// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************
import 'sentence.dart';


class ParaphraseSerializer {
  ParaphraseSerializer();

  String paraphrase = '';
  List<SentenceSerializer> exampleSentences = [SentenceSerializer()];


  ParaphraseSerializer fromJson(Map<String, dynamic> json) {
    paraphrase = json['paraphrase'] as String;
    exampleSentences = json['exampleSentences'] == null
        ? []
        : json['exampleSentences'].map<SentenceSerializer>((e) => SentenceSerializer().fromJson(e as Map<String, dynamic>)).toList();
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'paraphrase': paraphrase,
    'exampleSentences': exampleSentences,
  };

}
