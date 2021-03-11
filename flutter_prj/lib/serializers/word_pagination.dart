// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'word.dart';
import 'package:flutter_prj/common/http.dart';


class WordPaginationSerializer {
  WordPaginationSerializer();

  num count = 0;
  String next = '';
  String previous = '';
  List<WordSerializer> results = [];
  WordSerializerFilter filter = WordSerializerFilter();

  Future<WordPaginationSerializer> retrieve({Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    (queryParameters != null && filter.queryset != null) ? queryParameters.addAll(filter.queryset) : queryParameters = filter.queryset;
    var res = await Http().request(HttpType.GET, '/dictionary/word/', queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : WordPaginationSerializer().fromJson(res.data);
  }

  WordPaginationSerializer fromJson(Map<String, dynamic> json) {
    count = json['count'] == null ? null : json['count'] as num;
    next = json['next'] == null ? null : json['next'] as String;
    previous = json['previous'] == null ? null : json['previous'] as String;
    results = json['results'] == null
                ? []
                : json['results'].map<WordSerializer>((e) => WordSerializer().fromJson(e as Map<String, dynamic>)).toList();
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'count': count,
    'next': next,
    'previous': previous,
    'results': results == null ? null : results.map((e) => e.toJson()).toList(),
  };
}

class WordSerializerFilter {
  String name;
  String name__icontains;
  String tag__icontains;
  String etyma__icontains;

  Map<String, dynamic> get queryset => <String, dynamic>{
    "name": name,
    "name__icontains": name__icontains,
    "tag__icontains": tag__icontains,
    "etyma__icontains": etyma__icontains,
  }..removeWhere((String key, dynamic value) => value == null);

  void clear() {
    name = null;
    name__icontains = null;
    tag__icontains = null;
    etyma__icontains = null;
  }
}

