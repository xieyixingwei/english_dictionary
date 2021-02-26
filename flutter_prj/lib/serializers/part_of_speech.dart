// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************
import 'paraphrase.dart';


class PartOfSpeechSerializer {
  PartOfSpeechSerializer();

  String partOfSpeech = '';
  List<ParaphraseSerializer> paraphrases = [ParaphraseSerializer()];


  PartOfSpeechSerializer fromJson(Map<String, dynamic> json) {
    partOfSpeech = json['partOfSpeech'] as String;
    paraphrases = json['paraphrases'] == null
        ? []
        : json['paraphrases'].map<ParaphraseSerializer>((e) => ParaphraseSerializer().fromJson(e as Map<String, dynamic>)).toList();
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'partOfSpeech': partOfSpeech,
    'paraphrases': paraphrases,
  };

}
