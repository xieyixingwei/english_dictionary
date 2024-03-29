// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'distinguish.dart';
import 'package:flutter_prj/common/http.dart';
import 'global_queryset.dart';

class DistinguishPaginationSerializer {
  DistinguishPaginationSerializer();

  num count = 0;
  String next = '';
  String previous = '';
  List<DistinguishSerializer> results = [];
  DistinguishFilter filter = DistinguishFilter();
  GlobalQuerySet queryset = GlobalQuerySet();

  Future<bool> retrieve({Map<String, dynamic> queries, bool cache=false}) async {
    if(queries == null) queries = <String, dynamic>{};
    queries.addAll(queryset.queries);
    queries.addAll(filter.queries);
    var res = await Http().request(HttpType.GET, '/api/dictionary/distinguish/', queries:queries, cache:cache);
    fromJson(res?.data);
    return res != null;
  }

  DistinguishPaginationSerializer fromJson(Map<String, dynamic> json, {bool slave = true}) {
    if(json == null) return this;
    count = json['count'] == null ? count : json['count'] as num;
    next = json['next'] == null ? next : json['next'] as String;
    previous = json['previous'] == null ? previous : json['previous'] as String;
    results = json['results'] == null
                ? results
                : json['results'].map<DistinguishSerializer>((e) => DistinguishSerializer().fromJson(e as Map<String, dynamic>)).toList();
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'count': count,
    'next': next,
    'previous': previous,
    'results': results == null ? null : results.map((e) => e.toJson()).toList(),
  }..removeWhere((k, v) => v==null);


  DistinguishPaginationSerializer from(DistinguishPaginationSerializer instance) {
    if(instance == null) return this;
    count = instance.count;
    next = instance.next;
    previous = instance.previous;
    results = List.from(instance.results.map((e) => DistinguishSerializer().from(e)).toList());
    return this;
  }
}

class DistinguishFilter {
  String wordsForeign__icontains;
  String content__icontains;

  Map<String, dynamic> get queries => <String, dynamic>{
    'wordsForeign__icontains': wordsForeign__icontains,
    'content__icontains': content__icontains,
  }..removeWhere((String key, dynamic value) => value == null);

  void clear() {
    wordsForeign__icontains = null;
    content__icontains = null;
  }
}
