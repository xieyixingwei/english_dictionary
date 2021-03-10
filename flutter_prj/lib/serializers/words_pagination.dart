// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'word.dart';
import 'package:flutter_prj/common/http.dart';


class WordsPaginationSerializer {
  WordsPaginationSerializer();

  num count = 0;
  String next = '';
  String previous = '';
  List<WordSerializer> results = [];
  WordSerializerFilter filter = WordSerializerFilter();

  Future<WordsPaginationSerializer> retrieve({Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    (queryParameters != null && filter.queryset != null) ? queryParameters.addAll(filter.queryset) : queryParameters = filter.queryset;
    var res = await Http().request(HttpType.GET, '/dictionary/word', queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : WordsPaginationSerializer().fromJson(res.data);
  }

  WordsPaginationSerializer fromJson(Map<String, dynamic> json) {
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
  String w_name;
  String w_name__icontains;
  String w_tags__icontains;
  String w_etyma__icontains;

  Map<String, dynamic> get queryset => <String, dynamic>{
    "w_name": w_name,
    "w_name__icontains": w_name__icontains,
    "w_tags__icontains": w_tags__icontains,
    "w_etyma__icontains": w_etyma__icontains,
  }..removeWhere((String key, dynamic value) => value == null);

  void clear() {
    w_name = null;
    w_name__icontains = null;
    w_tags__icontains = null;
    w_etyma__icontains = null;
  }
}

