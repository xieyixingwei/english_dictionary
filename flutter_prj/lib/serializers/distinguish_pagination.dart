// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'distinguish.dart';
import 'package:flutter_prj/common/http.dart';


class DistinguishPaginationSerializer {
  DistinguishPaginationSerializer();

  num count = 0;
  String next = '';
  String previous = '';
  List<DistinguishSerializer> results = [];
  DistinguishSerializerFilter filter = DistinguishSerializerFilter();

  Future<bool> retrieve({Map<String, dynamic> queries, bool cache=false}) async {
    (queries != null && filter.queryset != null) ? queries.addAll(filter.queryset) : queries = filter.queryset;
    var res = await Http().request(HttpType.GET, '/dictionary/distinguish_word/', queries:queries, cache:cache);
    if(res != null) this.fromJson(res.data);
    return res != null;
  }

  DistinguishPaginationSerializer fromJson(Map<String, dynamic> json) {
    count = json['count'] == null ? null : json['count'] as num;
    next = json['next'] == null ? null : json['next'] as String;
    previous = json['previous'] == null ? null : json['previous'] as String;
    results = json['results'] == null
                ? []
                : json['results'].map<DistinguishSerializer>((e) => DistinguishSerializer().fromJson(e as Map<String, dynamic>)).toList();
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'count': count,
    'next': next,
    'previous': previous,
    'results': results == null ? null : results.map((e) => e.toJson()).toList(),
  };

  DistinguishPaginationSerializer from(DistinguishPaginationSerializer instance) {
    count = instance.count;
    next = instance.next;
    previous = instance.previous;
    results = List.from(instance.results.map((e) => DistinguishSerializer().from(e)).toList());
    return this;
  }
}

class DistinguishSerializerFilter {
  String wordsForeign__icontains;
  String content__icontains;

  Map<String, dynamic> get queryset => <String, dynamic>{
    "wordsForeign__icontains": wordsForeign__icontains,
    "content__icontains": content__icontains,
  }..removeWhere((String key, dynamic value) => value == null);

  void clear() {
    wordsForeign__icontains = null;
    content__icontains = null;
  }
}