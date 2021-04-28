// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'package:flutter_prj/common/http.dart';


class GrammarTagSerializer {
  GrammarTagSerializer();

  String _name;
  String name = '';

  Future<bool> create({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/dictionary/grammar_tag/', data:data ?? toJson(), queries:queries, cache:cache);
    if(res != null) fromJson(res.data);
    return res != null;
  }

  static Future<List<GrammarTagSerializer>> list({Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/dictionary/grammar_tag/', queries:queries, cache:cache);
    return res != null ? res.data.map<GrammarTagSerializer>((e) => GrammarTagSerializer().fromJson(e)).toList() : [];
  }

  Future<bool> delete({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    if(_name == null) return true;
    var res = await Http().request(HttpType.DELETE, '/dictionary/grammar_tag/$name/', data:data ?? toJson(), queries:queries, cache:cache);
    /*
    
    */
    return res != null ? res.statusCode == 204 : false;
  }

  GrammarTagSerializer fromJson(Map<String, dynamic> json) {
    name = json['name'] == null ? null : json['name'] as String;
    _name = name;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
  };

  GrammarTagSerializer from(GrammarTagSerializer instance) {
    if(instance == null) return this;
    name = instance.name;
    _name = instance._name;
    return this;
  }
}


