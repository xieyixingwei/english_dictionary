// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'package:flutter_prj/common/http.dart';


class GrammarSerializer {
  GrammarSerializer();

  num id;
  List<String> type = [];
  List<String> tag = [];
  String content = '';
  String image = '';
  String vedio = '';
  String wordForeign;
  num sentenceForeign;
  

  Future<GrammarSerializer> create({dynamic data, Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/dictionary/grammar/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : GrammarSerializer().fromJson(res.data);
  }

  Future<GrammarSerializer> update({dynamic data, Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    var res = await Http().request(HttpType.PUT, '/dictionary/grammar/$id/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : GrammarSerializer().fromJson(res.data);
  }

  Future<GrammarSerializer> retrieve({Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/dictionary/grammar/$id/', queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : GrammarSerializer().fromJson(res.data);
  }

  Future<bool> delete({dynamic data, Map<String, dynamic> queryParameters, bool cache=false}) async {
    if(id == null) return false;
    var res = await Http().request(HttpType.DELETE, '/dictionary/grammar/$id/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    /*
    
    */
    return res != null ? res.statusCode == 204 : false;
  }

  Future<GrammarSerializer> save({dynamic data, Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    GrammarSerializer res = id == null
                               ? await this.create(data:data, queryParameters:queryParameters, update:update, cache:cache)
                               : await this.update(data:data, queryParameters:queryParameters, update:update, cache:cache);
    
    return res;
  }

  GrammarSerializer fromJson(Map<String, dynamic> json) {
    id = json['id'] == null ? null : json['id'] as num;
    type = json['type'] == null
                ? []
                : json['type'].map<String>((e) => e as String).toList();
    tag = json['tag'] == null
                ? []
                : json['tag'].map<String>((e) => e as String).toList();
    content = json['content'] == null ? null : json['content'] as String;
    image = json['image'] == null ? null : json['image'] as String;
    vedio = json['vedio'] == null ? null : json['vedio'] as String;
    wordForeign = json['wordForeign'] == null ? null : json['wordForeign'] as String;
    sentenceForeign = json['sentenceForeign'] == null ? null : json['sentenceForeign'] as num;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'type': type == null ? null : type.map((e) => e).toList(),
    'tag': tag == null ? null : tag.map((e) => e).toList(),
    'content': content,
    'wordForeign': wordForeign,
    'sentenceForeign': sentenceForeign,
  };
}


