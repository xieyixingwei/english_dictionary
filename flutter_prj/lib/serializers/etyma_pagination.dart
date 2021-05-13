// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'etyma.dart';
import 'dart:convert';
import 'package:flutter_prj/common/http.dart';


class EtymaPaginationSerializer {
  EtymaPaginationSerializer();

  num count = 0;
  String next = '';
  String previous = '';
  List<EtymaSerializer> results = [];
  EtymaSerializerFilter filter = EtymaSerializerFilter();

  Future<bool> retrieve({Map<String, dynamic> queries, bool cache=false}) async {
    (queries != null && filter.queryset != null) ? queries.addAll(filter.queryset) : queries = filter.queryset;
    var res = await Http().request(HttpType.GET, '/api/dictionary/etyma/', queries:queries, cache:cache);
    if(res != null) fromJson(res.data);
    return res != null;
  }

  EtymaPaginationSerializer fromJson(Map<String, dynamic> json) {
    count = json['count'] == null ? null : json['count'] as num;
    next = json['next'] == null ? null : json['next'] as String;
    previous = json['previous'] == null ? null : json['previous'] as String;
    results = json['results'] == null
                ? []
                : json['results'].map<EtymaSerializer>((e) => EtymaSerializer().fromJson(e as Map<String, dynamic>)).toList();
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'count': count,
    'next': next,
    'previous': previous,
    'results': results == null ? null : results.map((e) => e.toJson()).toList(),
  };

  EtymaPaginationSerializer from(EtymaPaginationSerializer instance) {
    if(instance == null) return this;
    count = instance.count;
    next = instance.next;
    previous = instance.previous;
    results = List.from(instance.results.map((e) => EtymaSerializer().from(e)).toList());
    return this;
  }
}

class EtymaSerializerFilter {
  String name;
  String name__icontains;
  num type;

  Map<String, dynamic> get queryset => <String, dynamic>{
    "name": name,
    "name__icontains": name__icontains,
    "type": type,
  }..removeWhere((String key, dynamic value) => value == null);

  void clear() {
    name = null;
    name__icontains = null;
    type = null;
  }
}
