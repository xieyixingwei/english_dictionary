// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'etyma.dart';
import 'package:flutter_prj/common/http.dart';
import 'global_queryset.dart';

class EtymaPaginationSerializer {
  EtymaPaginationSerializer();

  num count = 0;
  String next = '';
  String previous = '';
  List<EtymaSerializer> results = [];
  EtymaFilter filter = EtymaFilter();
  GlobalQuerySet queryset = GlobalQuerySet();

  Future<bool> retrieve({Map<String, dynamic> queries, bool cache=false}) async {
    if(queries == null) queries = <String, dynamic>{};
    queries.addAll(queryset.queries);
    queries.addAll(filter.queries);
    var res = await Http().request(HttpType.GET, '/api/dictionary/etyma/', queries:queries, cache:cache);
    fromJson(res?.data);
    return res != null;
  }

  EtymaPaginationSerializer fromJson(Map<String, dynamic> json, {bool slave = true}) {
    if(json == null) return this;
    count = json['count'] == null ? count : json['count'] as num;
    next = json['next'] == null ? next : json['next'] as String;
    previous = json['previous'] == null ? previous : json['previous'] as String;
    results = json['results'] == null
                ? results
                : json['results'].map<EtymaSerializer>((e) => EtymaSerializer().fromJson(e as Map<String, dynamic>)).toList();
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'count': count,
    'next': next,
    'previous': previous,
    'results': results == null ? null : results.map((e) => e.toJson()).toList(),
  }..removeWhere((k, v) => v==null);


  EtymaPaginationSerializer from(EtymaPaginationSerializer instance) {
    if(instance == null) return this;
    count = instance.count;
    next = instance.next;
    previous = instance.previous;
    results = List.from(instance.results.map((e) => EtymaSerializer().from(e)).toList());
    return this;
  }
}

class EtymaFilter {
  String name;
  String name__icontains;
  num type;

  Map<String, dynamic> get queries => <String, dynamic>{
    'name': name,
    'name__icontains': name__icontains,
    'type': type,
  }..removeWhere((String key, dynamic value) => value == null);

  void clear() {
    name = null;
    name__icontains = null;
    type = null;
  }
}
