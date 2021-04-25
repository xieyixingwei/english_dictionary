// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'dart:convert';
import 'single_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter_prj/common/http.dart';


class DistinguishSerializer {
  DistinguishSerializer();

  num _id;
  num id;
  List<String> words = [];
  String content = '';
  SingleFile image = SingleFile('image', FileType.image);
  SingleFile vedio = SingleFile('vedio', FileType.video);
  List<String> wordsForeign = [];

  Future<bool> create({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/dictionary/distinguish_word/', data:data ?? _formData, queries:queries, cache:cache);
    if(res != null) fromJson(res.data);
    return res != null;
  }

  Future<bool> update({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.PUT, '/dictionary/distinguish_word/$id/', data:data ?? _formData, queries:queries, cache:cache);
    return res != null;
  }

  Future<bool> retrieve({Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/dictionary/distinguish_word/$id/', queries:queries, cache:cache);
    if(res != null) fromJson(res.data);
    return res != null;
  }

  Future<bool> delete({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    if(_id == null) return true;
    var res = await Http().request(HttpType.DELETE, '/dictionary/distinguish_word/$id/', data:data ?? _formData, queries:queries, cache:cache);
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

  DistinguishSerializer fromJson(Map<String, dynamic> json) {
    id = json['id'] == null ? null : json['id'] as num;
    words = json['words'] == null
                ? []
                : json['words'].map<String>((e) => e as String).toList();
    content = json['content'] == null ? null : json['content'] as String;
    image.url = json['image'] == null ? null : json['image'] as String;
    vedio.url = json['vedio'] == null ? null : json['vedio'] as String;
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
  FormData get _formData {
    var jsonObj = toJson();
    jsonObj['words'] = json.encode(jsonObj['words']);
    var formData = FormData.fromMap(jsonObj, ListFormat.multi);
    if(image.mptFile != null) formData.files.add(image.file);
    if(vedio.mptFile != null) formData.files.add(vedio.file);
    return formData;
  }

  DistinguishSerializer from(DistinguishSerializer instance) {
    id = instance.id;
    words = List.from(instance.words);
    content = instance.content;
    image.from(instance.image);
    vedio.from(instance.vedio);
    wordsForeign = List.from(instance.wordsForeign);
    _id = instance._id;
    return this;
  }
}


