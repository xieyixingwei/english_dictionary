// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'sentence_pattern.dart';
import 'dart:convert';
import 'package:flutter_prj/common/http.dart';


class SentencePatternPaginationSerializer {
  SentencePatternPaginationSerializer();

  num count = 0;
  String next = '';
  String previous = '';
  List<SentencePatternSerializer> results = [];
  SentencePatternSerializerFilter filter = SentencePatternSerializerFilter();

  Future<bool> retrieve({Map<String, dynamic> queries, bool cache=false}) async {
    (queries != null && filter.queryset != null) ? queries.addAll(filter.queryset) : queries = filter.queryset;
    var res = await Http().request(HttpType.GET, '/api/dictionary/sentence_pattern/', queries:queries, cache:cache);
    if(res != null) fromJson(res.data);
    return res != null;
  }

  SentencePatternPaginationSerializer fromJson(Map<String, dynamic> json) {
    count = json['count'] == null ? null : json['count'] as num;
    next = json['next'] == null ? null : json['next'] as String;
    previous = json['previous'] == null ? null : json['previous'] as String;
    results = json['results'] == null
                ? []
                : json['results'].map<SentencePatternSerializer>((e) => SentencePatternSerializer().fromJson(e as Map<String, dynamic>)).toList();
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'count': count,
    'next': next,
    'previous': previous,
    'results': results == null ? null : results.map((e) => e.toJson()).toList(),
  };

  SentencePatternPaginationSerializer from(SentencePatternPaginationSerializer instance) {
    if(instance == null) return this;
    count = instance.count;
    next = instance.next;
    previous = instance.previous;
    results = List.from(instance.results.map((e) => SentencePatternSerializer().from(e)).toList());
    return this;
  }
}

class SentencePatternSerializerFilter {
  String content__icontains;

  Map<String, dynamic> get queryset => <String, dynamic>{
    "content__icontains": content__icontains,
  }..removeWhere((String key, dynamic value) => value == null);

  void clear() {
    content__icontains = null;
  }
}
