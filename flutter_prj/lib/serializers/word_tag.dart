// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'package:flutter_prj/common/http.dart';


class WordTagSerializer {
  WordTagSerializer();

  String name = '';
  

  Future<WordTagSerializer> create({dynamic data, Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/dictionary/word_tag/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : WordTagSerializer().fromJson(res.data);
  }

  static Future<List<WordTagSerializer>> list({Map<String, dynamic> queryParameters, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/dictionary/word_tag/', queryParameters:queryParameters, cache:cache);
    return res.data.map<WordTagSerializer>((e) => WordTagSerializer().fromJson(e)).toList();
  }

  Future<bool> delete({dynamic data, Map<String, dynamic> queryParameters, bool cache=false}) async {
    if(name == null) return false;
    var res = await Http().request(HttpType.DELETE, '/dictionary/word_tag/$name/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    /*
    
    */
    return res != null ? res.statusCode == 204 : false;
  }

  WordTagSerializer fromJson(Map<String, dynamic> json) {
    name = json['name'] == null ? null : json['name'] as String;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
  };
}


