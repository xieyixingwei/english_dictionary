// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'package:flutter_prj/common/http.dart';


class RelativeSentenceSerializer {
  RelativeSentenceSerializer();

  num r_id;
  num r_sentence_a;
  num r_sentence_b;
  bool r_type = true;
  

  Future<RelativeSentenceSerializer> create({dynamic data, Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/dictionary/relative_sentence/create/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : RelativeSentenceSerializer().fromJson(res.data);
  }

  static Future<List<RelativeSentenceSerializer>> list({Map<String, dynamic> queryParameters, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/dictionary/relative_sentence/', queryParameters:queryParameters, cache:cache);
    return res.data.map<RelativeSentenceSerializer>((e) => RelativeSentenceSerializer().fromJson(e)).toList();
  }

  Future<bool> delete({dynamic data, Map<String, dynamic> queryParameters, bool cache=false}) async {
    if(r_id == null) return false;
    var res = await Http().request(HttpType.DELETE, '/dictionary/relative_sentence/delete/$r_id/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    /*
    
    */
    return res != null ? res.statusCode == 204 : false;
  }

  Future<RelativeSentenceSerializer> save({dynamic data, Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    RelativeSentenceSerializer res = r_id == null
                               ? await this.create(data:data, queryParameters:queryParameters, update:update, cache:cache)
                               : null;
    
    return res;
  }

  RelativeSentenceSerializer fromJson(Map<String, dynamic> json) {
    r_id = json['r_id'] as num;
    r_sentence_a = json['r_sentence_a'] as num;
    r_sentence_b = json['r_sentence_b'] as num;
    r_type = json['r_type'] as bool;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'r_id': r_id,
    'r_sentence_a': r_sentence_a,
    'r_sentence_b': r_sentence_b,
    'r_type': r_type,
  };
}
