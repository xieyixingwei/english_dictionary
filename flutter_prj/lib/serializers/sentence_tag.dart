// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'package:flutter_prj/common/http.dart';


class SentenceTagSerializer {
  SentenceTagSerializer();

  String name = '';
  

  Future<SentenceTagSerializer> create({dynamic data, Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/dictionary/sentence_tag/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : SentenceTagSerializer().fromJson(res.data);
  }

  static Future<List<SentenceTagSerializer>> list({Map<String, dynamic> queryParameters, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/dictionary/sentence_tag/', queryParameters:queryParameters, cache:cache);
    return res.data.map<SentenceTagSerializer>((e) => SentenceTagSerializer().fromJson(e)).toList();
  }

  Future<bool> delete({dynamic data, Map<String, dynamic> queryParameters, bool cache=false}) async {
    if(name == null) return false;
    var res = await Http().request(HttpType.DELETE, '/dictionary/sentence_tag/$name/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    /*
    
    */
    return res != null ? res.statusCode == 204 : false;
  }

  SentenceTagSerializer fromJson(Map<String, dynamic> json) {
    name = json['name'] == null ? null : json['name'] as String;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
  };
}


