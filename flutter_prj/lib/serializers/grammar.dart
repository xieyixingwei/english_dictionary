// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'dart:convert';
import 'single_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter_prj/common/http.dart';


class GrammarSerializer {
  GrammarSerializer();

  num _id;
  num id;
  List<String> type = [];
  List<String> tag = [];
  String content = '';
  SingleFile image = SingleFile('image', FileType.image);
  SingleFile vedio = SingleFile('vedio', FileType.video);
  String wordForeign;
  num sentenceForeign;

  Future<bool> create({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/api/dictionary/grammar/', data:data ?? _formData, queries:queries, cache:cache);
    if(res != null) fromJson(res.data);
    return res != null;
  }

  Future<bool> update({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.PUT, '/api/dictionary/grammar/$id/', data:data ?? _formData, queries:queries, cache:cache);
    return res != null;
  }

  Future<bool> retrieve({Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/api/dictionary/grammar/$id/', queries:queries, cache:cache);
    if(res != null) fromJson(res.data);
    return res != null;
  }

  Future<bool> delete({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    if(_id == null) return true;
    var res = await Http().request(HttpType.DELETE, '/api/dictionary/grammar/$id/', data:data ?? _formData, queries:queries, cache:cache);
    /*
    
    */
    return res != null ? res.statusCode == 204 : false;
  }

  Future<bool> save({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    bool res = false;
    if(_id == null) {
      res = await create(data:data, queries:queries, cache:cache);
    } else {
      res = await update(data:data, queries:queries, cache:cache);
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
    image.url = json['image'] == null ? null : json['image'] as String;
    vedio.url = json['vedio'] == null ? null : json['vedio'] as String;
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
  FormData get _formData {
    var jsonObj = toJson();
    jsonObj['type'] = json.encode(jsonObj['type']);
    jsonObj['tag'] = json.encode(jsonObj['tag']);
    var formData = FormData.fromMap(jsonObj, ListFormat.multi);
    if(image.mptFile != null) formData.files.add(image.file);
    if(vedio.mptFile != null) formData.files.add(vedio.file);
    return formData;
  }

  GrammarSerializer from(GrammarSerializer instance) {
    if(instance == null) return this;
    id = instance.id;
    type = List.from(instance.type);
    tag = List.from(instance.tag);
    content = instance.content;
    image.from(instance.image);
    vedio.from(instance.vedio);
    wordForeign = instance.wordForeign;
    sentenceForeign = instance.sentenceForeign;
    _id = instance._id;
    return this;
  }
}


