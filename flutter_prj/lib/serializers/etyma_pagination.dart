// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'etyma.dart';
import 'package:flutter_prj/common/http.dart';


class EtymaPaginationSerializer {
  EtymaPaginationSerializer();

  num count = 0;
  String next = '';
  String previous = '';
  List<EtymaSerializer> results = [];
  EtymaSerializerFilter filter = EtymaSerializerFilter();

  Future<EtymaPaginationSerializer> retrieve({Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    (queryParameters != null && filter.queryset != null) ? queryParameters.addAll(filter.queryset) : queryParameters = filter.queryset;
    var res = await Http().request(HttpType.GET, '/dictionary/etyma', queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : EtymaPaginationSerializer().fromJson(res.data);
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
}

class EtymaSerializerFilter {
  String e_name;
  String e_name__icontains;
  num e_type;

  Map<String, dynamic> get queryset => <String, dynamic>{
    "e_name": e_name,
    "e_name__icontains": e_name__icontains,
    "e_type": e_type,
  }..removeWhere((String key, dynamic value) => value == null);

  void clear() {
    e_name = null;
    e_name__icontains = null;
    e_type = null;
  }
}

