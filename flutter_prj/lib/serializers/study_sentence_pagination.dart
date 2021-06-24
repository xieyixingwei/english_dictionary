// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'study_sentence.dart';
import 'package:flutter_prj/common/http.dart';


class StudySentencePaginationSerializer {
  StudySentencePaginationSerializer();

  num count = 0;
  String next = '';
  String previous = '';
  List<StudySentenceSerializer> results = [];
  StudySentenceSerializerFilter filter = StudySentenceSerializerFilter();
  StudySentencePaginationSerializerQuerySet queryset = StudySentencePaginationSerializerQuerySet();

  Future<bool> retrieve({Map<String, dynamic> queries, bool cache=false}) async {
    if(queries == null) queries = <String, dynamic>{};
    queries.addAll(queryset.queries);
    queries.addAll(filter.queries);
    var res = await Http().request(HttpType.GET, '/api/study/sentence/', queries:queries, cache:cache);
    fromJson(res?.data);
    return res != null;
  }

  StudySentencePaginationSerializer fromJson(Map<String, dynamic> json, {bool slave = true}) {
    if(json == null) return this;
    count = json['count'] == null ? count : json['count'] as num;
    next = json['next'] == null ? next : json['next'] as String;
    previous = json['previous'] == null ? previous : json['previous'] as String;
    results = json['results'] == null
                ? results
                : json['results'].map<StudySentenceSerializer>((e) => StudySentenceSerializer().fromJson(e as Map<String, dynamic>)).toList();
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'count': count,
    'next': next,
    'previous': previous,
    'results': results == null ? null : results.map((e) => e.toJson()).toList(),
  }..removeWhere((k, v) => v==null);


  StudySentencePaginationSerializer from(StudySentencePaginationSerializer instance) {
    if(instance == null) return this;
    count = instance.count;
    next = instance.next;
    previous = instance.previous;
    results = List.from(instance.results.map((e) => StudySentenceSerializer().from(e)).toList());
    return this;
  }
}


class StudySentencePaginationSerializerQuerySet {
  num pageSize = 10;
  num pageIndex = 1;
  String ordering = null;

  Map<String, dynamic> get queries => <String, dynamic>{
    'pageSize': pageSize,
    'pageIndex': pageIndex,
    'ordering': ordering,
  }..removeWhere((String key, dynamic value) => value == null);

  void clear() {
    pageSize = null;
    pageIndex = null;
    ordering = null;
  }
}
