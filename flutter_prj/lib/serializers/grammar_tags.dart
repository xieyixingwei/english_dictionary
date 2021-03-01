// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'package:flutter_prj/common/http.dart';


class GrammarTagsSerializer {
  GrammarTagsSerializer();

  String g_name = '';
  

  Future<GrammarTagsSerializer> create({dynamic data, Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/dictionary/grammartags/create/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : GrammarTagsSerializer().fromJson(res.data);
  }

  static Future<List<GrammarTagsSerializer>> list({Map<String, dynamic> queryParameters, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/dictionary/grammartags/', queryParameters:queryParameters, cache:cache);
    return res.data.map<GrammarTagsSerializer>((e) => GrammarTagsSerializer().fromJson(e)).toList();
  }

  Future<bool> delete({dynamic data, Map<String, dynamic> queryParameters, bool cache=false}) async {
    if(g_name == null) return false;
    var res = await Http().request(HttpType.DELETE, '/dictionary/grammartags/delete/$g_name/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    /*
    
    */
    return res != null ? res.statusCode == 204 : false;
  }

  GrammarTagsSerializer fromJson(Map<String, dynamic> json) {
    g_name = json['g_name'] as String;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'g_name': g_name,
  };
}
