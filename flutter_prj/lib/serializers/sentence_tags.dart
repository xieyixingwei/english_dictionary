// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'package:flutter_prj/common/http.dart';


class SentenceTagsSerializer {
  SentenceTagsSerializer();

  String t_name = '';

  Future<SentenceTagsSerializer> create({dynamic data, Map<String, dynamic> queryParameters, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/dictionary/sentencetags/create/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    return this.fromJson(res.data);
  }

  Future<SentenceTagsSerializer> list({Map<String, dynamic> queryParameters, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/dictionary/sentencetags/', queryParameters:queryParameters, cache:cache);
    return this.fromJson(res.data);
  }

  Future<bool> delete({dynamic data, Map<String, dynamic> queryParameters, bool cache=false}) async {
    var res = await Http().request(HttpType.DELETE, '/dictionary/sentencetags/delete/$t_name/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    return res.statusCode == 204;
  }

  SentenceTagsSerializer fromJson(Map<String, dynamic> json) {
    t_name = json['t_name'] as String;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    't_name': t_name,
  };

}
