// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'sentence.dart';
import 'package:flutter_prj/common/http.dart';


class GrammarSerializer {
  GrammarSerializer();

  num g_id;
  List<String> g_type = [];
  List<String> g_tags = [];
  String g_content = '';
  String g_word;
  num g_sentence;

  Future<GrammarSerializer> create({dynamic data, Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/dictionary/grammar/create/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : GrammarSerializer.newFromJson(res.data);
  }

  Future<GrammarSerializer> update({dynamic data, Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    var res = await Http().request(HttpType.PUT, '/dictionary/grammar/update/$g_id/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : GrammarSerializer.newFromJson(res.data);
  }

  Future<GrammarSerializer> retrieve({Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/dictionary/grammar/$g_id/', queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : GrammarSerializer.newFromJson(res.data);
  }

  Future<bool> delete({dynamic data, Map<String, dynamic> queryParameters, bool cache=false}) async {
    if(g_id == null) return false;
    var res = await Http().request(HttpType.DELETE, '/dictionary/grammar/delete/$g_id/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    /*
    
    */
    return res != null ? res.statusCode == 204 : false;
  }

  static Future<List<GrammarSerializer>> list({Map<String, dynamic> queryParameters, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/dictionary/grammar/', queryParameters:queryParameters, cache:cache);
    return res.data.map<GrammarSerializer>((e) => GrammarSerializer().fromJson(e)).toList();
  }

  Future<GrammarSerializer> save({dynamic data, Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    GrammarSerializer res = g_id == null
                               ? await this.create(data:data, queryParameters:queryParameters, update:update, cache:cache)
                               : await this.update(data:data, queryParameters:queryParameters, update:update, cache:cache);
    
    return res;
  }

  GrammarSerializer fromJson(Map<String, dynamic> json) {
    g_id = json['g_id'] as num;
    g_type = json['g_type'] == null
                ? []
                : json['g_type'].map<String>((e) => e as String).toList();
    g_tags = json['g_tags'] == null
                ? []
                : json['g_tags'].map<String>((e) => e as String).toList();
    g_content = json['g_content'] as String;
    g_word = json['g_word'] as String;
    g_sentence = json['g_sentence'] as num;
    return this;
  }

  factory GrammarSerializer.newFromJson(Map<String, dynamic> json) {
    return GrammarSerializer()
      ..g_id = json['g_id'] as num
      ..g_type = json['g_type'] == null
                ? []
                : json['g_type'].map<String>((e) => e as String).toList()
      ..g_tags = json['g_tags'] == null
                ? []
                : json['g_tags'].map<String>((e) => e as String).toList()
      ..g_content = json['g_content'] as String
      ..g_word = json['g_word'] as String
      ..g_sentence = json['g_sentence'] as num;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'g_id': g_id,
    'g_type': g_type == null ? null : g_type.map((e) => e).toList(),
    'g_tags': g_tags == null ? null : g_tags.map((e) => e).toList(),
    'g_content': g_content,
    'g_word': g_word,
    'g_sentence': g_sentence,
  };
}
