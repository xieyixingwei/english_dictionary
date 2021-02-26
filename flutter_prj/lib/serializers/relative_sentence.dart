// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************
import 'sentence.dart';


class RelativeSentenceSerializer {
  RelativeSentenceSerializer();

  num r_id = -1;
  SentenceSerializer r_sentence_a = SentenceSerializer();
  SentenceSerializer r_sentence_b = SentenceSerializer();
  bool r_type = true;


  RelativeSentenceSerializer fromJson(Map<String, dynamic> json) {
    r_id = json['r_id'] as num;
    r_sentence_a = json['r_sentence_a'] == null
        ? null
        : SentenceSerializer().fromJson(json['r_sentence_a'] as Map<String, dynamic>);
    r_sentence_b = json['r_sentence_b'] == null
        ? null
        : SentenceSerializer().fromJson(json['r_sentence_b'] as Map<String, dynamic>);
    r_type = json['r_type'] as bool;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'r_id': r_id,
    'r_sentence_a': r_sentence_a,
    'r_sentence_b': r_sentence_b,
    'r_type': r_type,
  };

}
