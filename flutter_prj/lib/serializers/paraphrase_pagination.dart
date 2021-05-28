// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'paraphrase.dart';
import 'package:flutter_prj/common/http.dart';


class ParaphrasePaginationSerializer {
  ParaphrasePaginationSerializer();

  num count = 0;
  String next = '';
  String previous = '';
  List<ParaphraseSerializer> results = [];
  ParaphraseSerializerFilter filter = ParaphraseSerializerFilter();

  Future<bool> retrieve({Map<String, dynamic> queries, bool cache=false}) async {
    (queries != null && filter.queryset != null) ? queries.addAll(filter.queryset) : queries = filter.queryset;
    var res = await Http().request(HttpType.GET, '/api/dictionary/paraphrase/', queries:queries, cache:cache);
    if(res != null) fromJson(res.data);
    return res != null;
  }

  ParaphrasePaginationSerializer fromJson(Map<String, dynamic> json) {
    count = json['count'] == null ? count : json['count'] as num;
    next = json['next'] == null ? next : json['next'] as String;
    previous = json['previous'] == null ? previous : json['previous'] as String;
    results = json['results'] == null
                ? results
                : json['results'].map<ParaphraseSerializer>((e) => ParaphraseSerializer().fromJson(e as Map<String, dynamic>)).toList();
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'count': count,
    'next': next,
    'previous': previous,
    'results': results == null ? null : results.map((e) => e.toJson()).toList(),
  }..removeWhere((k, v) => v==null);


  ParaphrasePaginationSerializer from(ParaphrasePaginationSerializer instance) {
    if(instance == null) return this;
    count = instance.count;
    next = instance.next;
    previous = instance.previous;
    results = List.from(instance.results.map((e) => ParaphraseSerializer().from(e)).toList());
    return this;
  }
}

class ParaphraseSerializerFilter {
  String interpret__icontains;

  Map<String, dynamic> get queryset => <String, dynamic>{
    "interpret__icontains": interpret__icontains,
  }..removeWhere((String key, dynamic value) => value == null);

  void clear() {
    interpret__icontains = null;
  }
}
