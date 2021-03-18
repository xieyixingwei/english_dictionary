// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'word.dart';
import 'package:flutter_prj/common/http.dart';


class DistinguishSerializer {
  DistinguishSerializer();

  num _id;
  num id;
  List<String> words = [];
  String content = '';
  String image = '';
  String vedio = '';
  List<String> wordsForeign = [];

  Future<bool> create({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/dictionary/distinguish_word/', data:data ?? this.toJson(), queries:queries, cache:cache);
    if(res != null) this.fromJson(res.data);
    return res != null;
  }

  Future<bool> update({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.PUT, '/dictionary/distinguish_word/$id/', data:data ?? this.toJson(), queries:queries, cache:cache);
    return res != null;
  }

  Future<bool> retrieve({Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/dictionary/distinguish_word/$id/', queries:queries, cache:cache);
    if(res != null) this.fromJson(res.data);
    return res != null;
  }

  Future<bool> delete({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    if(_id == null) return false;
    var res = await Http().request(HttpType.DELETE, '/dictionary/distinguish_word/$id/', data:data ?? this.toJson(), queries:queries, cache:cache);
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

  DistinguishSerializer fromJson(Map<String, dynamic> json) {
    id = json['id'] == null ? null : json['id'] as num;
    words = json['words'] == null
                ? []
                : json['words'].map<String>((e) => e as String).toList();
    content = json['content'] == null ? null : json['content'] as String;
    image = json['image'] == null ? null : json['image'] as String;
    vedio = json['vedio'] == null ? null : json['vedio'] as String;
    wordsForeign = json['wordsForeign'] == null
                ? []
                : json['wordsForeign'].map<String>((e) => e as String).toList();
    _id = id;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'words': words == null ? null : words.map((e) => e).toList(),
    'content': content,
    'wordsForeign': wordsForeign == null ? null : wordsForeign.map((e) => e).toList(),
  };

  DistinguishSerializer from(DistinguishSerializer instance) {
    id = instance.id;
    words = List.from(instance.words);
    content = instance.content;
    image = instance.image;
    vedio = instance.vedio;
    wordsForeign = List.from(instance.wordsForeign);
    _id = instance._id;
    return this;
  }
}


