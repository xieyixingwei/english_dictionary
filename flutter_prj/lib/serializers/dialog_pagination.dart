// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'dialog.dart';
import 'package:flutter_prj/common/http.dart';


class DialogPaginationSerializer {
  DialogPaginationSerializer();

  num count = 0;
  String next = '';
  String previous = '';
  List<DialogSerializer> results = [];
  DialogSerializerFilter filter = DialogSerializerFilter();

  Future<bool> retrieve({Map<String, dynamic> queries, bool cache=false}) async {
    if(queries == null) queries = <String, dynamic>{};
    queries.addAll(filter.queries);
    var res = await Http().request(HttpType.GET, '/api/dictionary/dialog/', queries:queries, cache:cache);
    fromJson(res?.data);
    return res != null;
  }

  DialogPaginationSerializer fromJson(Map<String, dynamic> json, {bool slave = true}) {
    if(json == null) return this;
    count = json['count'] == null ? count : json['count'] as num;
    next = json['next'] == null ? next : json['next'] as String;
    previous = json['previous'] == null ? previous : json['previous'] as String;
    results = json['results'] == null
                ? results
                : json['results'].map<DialogSerializer>((e) => DialogSerializer().fromJson(e as Map<String, dynamic>)).toList();
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'count': count,
    'next': next,
    'previous': previous,
    'results': results == null ? null : results.map((e) => e.toJson()).toList(),
  }..removeWhere((k, v) => v==null);


  DialogPaginationSerializer from(DialogPaginationSerializer instance) {
    if(instance == null) return this;
    count = instance.count;
    next = instance.next;
    previous = instance.previous;
    results = List.from(instance.results.map((e) => DialogSerializer().from(e)).toList());
    return this;
  }
}

class DialogSerializerFilter {
  String tag__icontains;
  String title__icontains;

  Map<String, dynamic> get queries => <String, dynamic>{
    'tag__icontains': tag__icontains,
    'title__icontains': title__icontains,
  }..removeWhere((String key, dynamic value) => value == null);

  void clear() {
    tag__icontains = null;
    title__icontains = null;
  }
}

