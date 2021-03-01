// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'sentence.dart';
import 'package:flutter_prj/common/http.dart';


class ListSentencesSerializer {
  ListSentencesSerializer();

  num count = 0;
  String next = '';
  String previous = '';
  List<SentenceSerializer> results;

  Future<ListSentencesSerializer> retrieve({Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/dictionary/sentence', queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : ListSentencesSerializer().fromJson(res.data);
  }

  ListSentencesSerializer fromJson(Map<String, dynamic> json) {
    count = json['count'] as num;
    next = json['next'] as String;
    previous = json['previous'] as String;
    results = json['results'] == null
                ? []
                : json['results'].map<SentenceSerializer>((e) => SentenceSerializer().fromJson(e as Map<String, dynamic>)).toList();
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'count': count,
    'next': next,
    'previous': previous,
    'results': results == null ? null : results.map((e) => e.toJson()).toList(),
  };
}
