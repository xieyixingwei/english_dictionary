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
    var res = await Http().request(HttpType.POST, '/dictionary/sentence_tag/', data:data ?? this.toJson(), queries:queries, cache:cache);
    if(res != null) this.fromJson(res.data);
    return res != null;
  }

  static Future<List<SentenceTagSerializer>> list({Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/dictionary/sentence_tag/', queries:queries, cache:cache);
    return res != null ? res.data.map<SentenceTagSerializer>((e) => SentenceTagSerializer().fromJson(e)).toList() : [];
  }

  Future<bool> delete({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    if(_name == null) return false;
    var res = await Http().request(HttpType.DELETE, '/dictionary/sentence_tag/$name/', data:data ?? this.toJson(), queries:queries, cache:cache);
    /*
    
    */
    return res != null ? res.statusCode == 204 : false;
  }

  SentenceTagSerializer fromJson(Map<String, dynamic> json) {
    name = json['name'] == null ? null : json['name'] as String;
    _name = name;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
  };

  SentenceTagSerializer from(SentenceTagSerializer instance) {
    name = instance.name;
    _name = instance._name;
    return this;
  }
}


