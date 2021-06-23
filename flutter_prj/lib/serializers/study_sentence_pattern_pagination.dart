// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'study_sentence_pattern.dart';
import 'package:flutter_prj/common/http.dart';


class StudySentencePatternPaginationSerializer {
  StudySentencePatternPaginationSerializer();

  num count = 0;
  String next = '';
  String previous = '';
  List<StudySentencePatternSerializer> results = [];
  StudySentencePatternSerializerFilter filter = StudySentencePatternSerializerFilter();
  StudySentencePatternPaginationSerializerQuerySet queryset = StudySentencePatternPaginationSerializerQuerySet();

  Future<bool> retrieve({Map<String, dynamic> queries, bool cache=false}) async {
    if(queries == null) queries = <String, dynamic>{};
    queries.addAll(queryset.queries);
    queries.addAll(filter.queries);
    var res = await Http().request(HttpType.GET, '/api/study/sentence_pattern/', queries:queries, cache:cache);
    fromJson(res?.data);
    return res != null;
  }

  StudySentencePatternPaginationSerializer fromJson(Map<String, dynamic> json, {bool slave = true}) {
    if(json == null) return this;
    count = json['count'] == null ? count : json['count'] as num;
    next = json['next'] == null ? next : json['next'] as String;
    previous = json['previous'] == null ? previous : json['previous'] as String;
    results = json['results'] == null
                ? results
                : json['results'].map<StudySentencePatternSerializer>((e) => StudySentencePatternSerializer().fromJson(e as Map<String, dynamic>)).toList();
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'count': count,
    'next': next,
    'previous': previous,
    'results': results == null ? null : results.map((e) => e.toJson()).toList(),
  }..removeWhere((k, v) => v==null);


  StudySentencePatternPaginationSerializer from(StudySentencePatternPaginationSerializer instance) {
    if(instance == null) return this;
    count = instance.count;
    next = instance.next;
    previous = instance.previous;
    results = List.from(instance.results.map((e) => StudySentencePatternSerializer().from(e)).toList());
    return this;
  }
}


class StudySentencePatternPaginationSerializerQuerySet {
  num pageSize = 10;
  num pageIndex = 1;

  Map<String, dynamic> get queries => <String, dynamic>{
    'pageSize': pageSize,
    'pageIndex': pageIndex,
  }..removeWhere((String key, dynamic value) => value == null);

  void clear() {
    pageSize = null;
    pageIndex = null;
  }
}