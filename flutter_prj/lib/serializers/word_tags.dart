// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'package:flutter_prj/common/http.dart';


class WordTagsSerializer {
  WordTagsSerializer();

  String t_name = '';
  

  Future<WordTagsSerializer> create({dynamic data, Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/dictionary/sentencetags/create/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : WordTagsSerializer().fromJson(res.data);
  }

  static Future<List<WordTagsSerializer>> list({Map<String, dynamic> queryParameters, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/dictionary/sentencetags/', queryParameters:queryParameters, cache:cache);
    return res.data.map<WordTagsSerializer>((e) => WordTagsSerializer().fromJson(e)).toList();
  }

  Future<bool> delete({dynamic data, Map<String, dynamic> queryParameters, bool cache=false}) async {
    if(t_name == null) return false;
    var res = await Http().request(HttpType.DELETE, '/dictionary/sentencetags/delete/$t_name/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    /*
    
    */
    return res != null ? res.statusCode == 204 : false;
  }

  WordTagsSerializer fromJson(Map<String, dynamic> json) {
    t_name = json['t_name'] as String;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    't_name': t_name,
  };
}
