// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'package:flutter_prj/common/http.dart';


class GrammarSerializer {
  GrammarSerializer();

  num _id;
  num id;
  List<String> type = [];
  List<String> tag = [];
  String content = '';
  String image = '';
  String vedio = '';
  String wordForeign;
  num sentenceForeign;

  Future<bool> create({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/dictionary/grammar/', data:data ?? this.toJson(), queries:queries, cache:cache);
    if(res != null) this.fromJson(res.data);
    return res != null;
  }

  Future<bool> update({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.PUT, '/dictionary/grammar/$id/', data:data ?? this.toJson(), queries:queries, cache:cache);
    return res != null;
  }

  Future<bool> retrieve({Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/dictionary/grammar/$id/', queries:queries, cache:cache);
    if(res != null) this.fromJson(res.data);
    return res != null;
  }

  Future<bool> delete({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    if(_id == null) return false;
    var res = await Http().request(HttpType.DELETE, '/dictionary/grammar/$id/', data:data ?? this.toJson(), queries:queries, cache:cache);
    /*
    
    */
    return res != null ? res.statusCode == 204 : false;
  }

  Future<bool> save({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    bool res = false;
    if(_id == null) {
      res = await this.create(data:data, queries:queries, cache:cache);
    } else {
      res = await this.update(data:data, queries:queries, cache:cache);
    }
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
    _id = id;
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

  GrammarSerializer from(GrammarSerializer instance) {
    id = instance.id;
    type = List.from(instance.type);
    tag = List.from(instance.tag);
    content = instance.content;
    image = instance.image;
    vedio = instance.vedio;
    wordForeign = instance.wordForeign;
    sentenceForeign = instance.sentenceForeign;
    _id = instance._id;
    return this;
  }
}


