// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'package:flutter_prj/common/http.dart';

class SentenceTagSerializer {
  SentenceTagSerializer();

  String _name;
  String name = '';

  Future<bool> create({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/api/dictionary/sentence_tag/', data:data ?? toJson(), queries:queries, cache:cache);
    fromJson(res?.data, slave:false); // Don't update slave forign members in create to avoid erasing newly added associated data
    return res != null;
  }

  Future<List<SentenceTagSerializer>> list({Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/api/dictionary/sentence_tag/', queries:queries, cache:cache);
    return res != null ? res.data.map<SentenceTagSerializer>((e) => SentenceTagSerializer().fromJson(e)).toList() : [];
  }

  Future<bool> delete({String pk}) async {
    if(_name == null && pk == null) return true;
    if(pk != null) name = pk;
    var res = await Http().request(HttpType.DELETE, '/api/dictionary/sentence_tag/$name/');
    /*
    
    */
    return res != null ? res.statusCode == 204 : false;
  }

  SentenceTagSerializer fromJson(Map<String, dynamic> json, {bool slave = true}) {
    if(json == null) return this;
    name = json['name'] == null ? name : json['name'] as String;
    _name = name;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
  }..removeWhere((k, v) => v==null);


  SentenceTagSerializer from(SentenceTagSerializer instance) {
    if(instance == null) return this;
    name = instance.name;
    _name = instance._name;
    return this;
  }
}

