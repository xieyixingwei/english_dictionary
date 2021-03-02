// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'package:flutter_prj/common/http.dart';


class GrammarTypeSerializer {
  GrammarTypeSerializer();

  String g_name = '';
  

  Future<GrammarTypeSerializer> create({dynamic data, Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/dictionary/grammartype/create/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : GrammarTypeSerializer().fromJson(res.data);
  }

  static Future<List<GrammarTypeSerializer>> list({Map<String, dynamic> queryParameters, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/dictionary/grammartype/', queryParameters:queryParameters, cache:cache);
    return res.data.map<GrammarTypeSerializer>((e) => GrammarTypeSerializer().fromJson(e)).toList();
  }

  Future<bool> delete({dynamic data, Map<String, dynamic> queryParameters, bool cache=false}) async {
    if(g_name == null) return false;
    var res = await Http().request(HttpType.DELETE, '/dictionary/grammartype/delete/$g_name/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    /*
    
    */
    return res != null ? res.statusCode == 204 : false;
  }

  GrammarTypeSerializer fromJson(Map<String, dynamic> json) {
    g_name = json['g_name'] as String;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'g_name': g_name,
  };
}


