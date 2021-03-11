// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'sentence.dart';
import 'package:flutter_prj/common/http.dart';


class SentencePaginationSerializer {
  SentencePaginationSerializer();

  num count = 0;
  String next = '';
  String previous = '';
  List<SentenceSerializer> results = [];
  SentenceSerializerFilter filter = SentenceSerializerFilter();

  Future<SentencePaginationSerializer> retrieve({Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    (queryParameters != null && filter.queryset != null) ? queryParameters.addAll(filter.queryset) : queryParameters = filter.queryset;
    var res = await Http().request(HttpType.GET, '/dictionary/sentence/', queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : SentencePaginationSerializer().fromJson(res.data);
  }

  SentencePaginationSerializer fromJson(Map<String, dynamic> json) {
    count = json['count'] == null ? null : json['count'] as num;
    next = json['next'] == null ? null : json['next'] as String;
    previous = json['previous'] == null ? null : json['previous'] as String;
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

class SentenceSerializerFilter {
  String en__icontains;
  String cn__icontains;
  num type;
  String tag__icontains;
  String tense__icontains;
  String pattern__icontains;

  Map<String, dynamic> get queryset => <String, dynamic>{
    "en__icontains": en__icontains,
    "cn__icontains": cn__icontains,
    "type": type,
    "tag__icontains": tag__icontains,
    "tense__icontains": tense__icontains,
    "pattern__icontains": pattern__icontains,
  }..removeWhere((String key, dynamic value) => value == null);

  void clear() {
    en__icontains = null;
    cn__icontains = null;
    type = null;
    tag__icontains = null;
    tense__icontains = null;
    pattern__icontains = null;
  }
}

