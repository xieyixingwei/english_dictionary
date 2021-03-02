// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'package:dio/dio.dart';

import 'sentence.dart';
import 'package:flutter_prj/common/http.dart';


class ListSentencesSerializer {
  ListSentencesSerializer();

  num count = 0;
  String next = '';
  String previous = '';
  List<SentenceSerializer> results;
  SentenceSerializerFilter filter = SentenceSerializerFilter();

  Future<ListSentencesSerializer> retrieve({Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    (queryParameters != null && filter.queryset != null) ? queryParameters.addAll(filter.queryset) : queryParameters = filter.queryset;
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

class SentenceSerializerFilter {
  String s_en__icontains;
  String s_ch__icontains;
  num s_type;
  String s_tags__icontains;
  String s_tense__icontains;
  String s_form__icontains;

  Map<String, dynamic> get queryset => <String, dynamic>{
    "s_en__icontains": s_en__icontains,
    "s_ch__icontains": s_ch__icontains,
    "s_type": s_type,
    "s_tags__icontains": s_tags__icontains,
    "s_tense__icontains": s_tense__icontains,
    "s_form__icontains": s_form__icontains,
  }..removeWhere((String key, dynamic value) => value == null);

  void clear() {
    s_en__icontains = null;
    s_ch__icontains = null;
    s_type = null;
    s_tags__icontains = null;
    s_tense__icontains = null;
    s_form__icontains = null;
  }
}

