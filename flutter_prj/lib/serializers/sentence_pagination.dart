// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'sentence.dart';
import 'package:flutter_prj/common/http.dart';
import 'global_queryset.dart';

class SentencePaginationSerializer {
  SentencePaginationSerializer();

  num count = 0;
  String next = '';
  String previous = '';
  List<SentenceSerializer> results = [];
  SentenceFilter filter = SentenceFilter();
  GlobalQuerySet queryset = GlobalQuerySet();

  Future<bool> retrieve({Map<String, dynamic> queries, bool cache=false}) async {
    if(queries == null) queries = <String, dynamic>{};
    queries.addAll(queryset.queries);
    queries.addAll(filter.queries);
    var res = await Http().request(HttpType.GET, '/api/dictionary/sentence/', queries:queries, cache:cache);
    fromJson(res?.data);
    return res != null;
  }

  SentencePaginationSerializer fromJson(Map<String, dynamic> json, {bool slave = true}) {
    if(json == null) return this;
    count = json['count'] == null ? count : json['count'] as num;
    next = json['next'] == null ? next : json['next'] as String;
    previous = json['previous'] == null ? previous : json['previous'] as String;
    results = json['results'] == null
                ? results
                : json['results'].map<SentenceSerializer>((e) => SentenceSerializer().fromJson(e as Map<String, dynamic>)).toList();
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'count': count,
    'next': next,
    'previous': previous,
    'results': results == null ? null : results.map((e) => e.toJson()).toList(),
  }..removeWhere((k, v) => v==null);


  SentencePaginationSerializer from(SentencePaginationSerializer instance) {
    if(instance == null) return this;
    count = instance.count;
    next = instance.next;
    previous = instance.previous;
    results = List.from(instance.results.map((e) => SentenceSerializer().from(e)).toList());
    return this;
  }
}

class SentenceFilter {
  String en__icontains;
  String cn__icontains;
  num type;
  String tag__icontains;
  String tense;
  String pattern__icontains;

  Map<String, dynamic> get queries => <String, dynamic>{
    'en__icontains': en__icontains,
    'cn__icontains': cn__icontains,
    'type': type,
    'tag__icontains': tag__icontains,
    'tense': tense,
    'pattern__icontains': pattern__icontains,
  }..removeWhere((String key, dynamic value) => value == null);

  void clear() {
    en__icontains = null;
    cn__icontains = null;
    type = null;
    tag__icontains = null;
    tense = null;
    pattern__icontains = null;
  }
}
