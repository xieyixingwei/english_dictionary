// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'grammar.dart';
import 'dart:convert';
import 'package:flutter_prj/common/http.dart';


class GrammarPaginationSerializer {
  GrammarPaginationSerializer();

  num count = 0;
  String next = '';
  String previous = '';
  List<GrammarSerializer> results = [];
  GrammarSerializerFilter filter = GrammarSerializerFilter();

  Future<bool> retrieve({Map<String, dynamic> queries, bool cache=false}) async {
    (queries != null && filter.queryset != null) ? queries.addAll(filter.queryset) : queries = filter.queryset;
    var res = await Http().request(HttpType.GET, '/api/dictionary/grammar/', queries:queries, cache:cache);
    if(res != null) fromJson(res.data);
    return res != null;
  }

  GrammarPaginationSerializer fromJson(Map<String, dynamic> json) {
    count = json['count'] == null ? null : json['count'] as num;
    next = json['next'] == null ? null : json['next'] as String;
    previous = json['previous'] == null ? null : json['previous'] as String;
    results = json['results'] == null
                ? []
                : json['results'].map<GrammarSerializer>((e) => GrammarSerializer().fromJson(e as Map<String, dynamic>)).toList();
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'count': count,
    'next': next,
    'previous': previous,
    'results': results == null ? null : results.map((e) => e.toJson()).toList(),
  };

  GrammarPaginationSerializer from(GrammarPaginationSerializer instance) {
    if(instance == null) return this;
    count = instance.count;
    next = instance.next;
    previous = instance.previous;
    results = List.from(instance.results.map((e) => GrammarSerializer().from(e)).toList());
    return this;
  }
}

class GrammarSerializerFilter {
  String type__icontains;
  String tag__icontains;
  String content__icontains;

  Map<String, dynamic> get queryset => <String, dynamic>{
    "type__icontains": type__icontains,
    "tag__icontains": tag__icontains,
    "content__icontains": content__icontains,
  }..removeWhere((String key, dynamic value) => value == null);

  void clear() {
    type__icontains = null;
    tag__icontains = null;
    content__icontains = null;
  }
}
