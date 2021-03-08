// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'grammar.dart';
import 'package:flutter_prj/common/http.dart';


class GrammarsPaginationSerializer {
  GrammarsPaginationSerializer();

  num count = 0;
  String next = '';
  String previous = '';
  List<GrammarSerializer> results = [];
  GrammarSerializerFilter filter = GrammarSerializerFilter();

  Future<GrammarsPaginationSerializer> retrieve({Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    (queryParameters != null && filter.queryset != null) ? queryParameters.addAll(filter.queryset) : queryParameters = filter.queryset;
var res = await Http().request(HttpType.GET, '/dictionary/grammar/', queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : GrammarsPaginationSerializer().fromJson(res.data);
  }

  GrammarsPaginationSerializer fromJson(Map<String, dynamic> json) {
    count = json['count'] as num;
    next = json['next'] as String;
    previous = json['previous'] as String;
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
}

class GrammarSerializerFilter {
  String g_type__icontains;
  String g_tags__icontains;
  String g_content__icontains;

  Map<String, dynamic> get queryset => <String, dynamic>{
    "g_type__icontains": g_type__icontains,
    "g_tags__icontains": g_tags__icontains,
    "g_content__icontains": g_content__icontains,
  }..removeWhere((String key, dynamic value) => value == null);

  void clear() {
    g_type__icontains = null;
    g_tags__icontains = null;
    g_content__icontains = null;
  }
}

