// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'package:flutter_prj/common/http.dart';


class GrammarTypeSerializer {
  GrammarTypeSerializer();

  String _name;
  String name = '';

  Future<bool> create({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/api/dictionary/grammar_type/', data:data ?? toJson(), queries:queries, cache:cache);
    if(res != null) {
      var jsonObj = {'name': res.data['name'] ?? name};
      fromJson(jsonObj); // Only update primary member after create
    }
    return res != null;
  }

  Future<List<GrammarTypeSerializer>> list({Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/api/dictionary/grammar_type/', queries:queries, cache:cache);
    return res != null ? res.data.map<GrammarTypeSerializer>((e) => GrammarTypeSerializer().fromJson(e)).toList() : [];
  }

  Future<bool> delete({String pk}) async {
    if(_name == null && pk == null) return true;
    if(pk != null) name = pk;
    var res = await Http().request(HttpType.DELETE, '/api/dictionary/grammar_type/$name/');
    /*
    
    */
    return res != null ? res.statusCode == 204 : false;
  }

  GrammarTypeSerializer fromJson(Map<String, dynamic> json) {
    name = json['name'] == null ? name : json['name'] as String;
    _name = name;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
  }..removeWhere((k, v) => v==null);


  GrammarTypeSerializer from(GrammarTypeSerializer instance) {
    if(instance == null) return this;
    name = instance.name;
    _name = instance._name;
    return this;
  }
}



