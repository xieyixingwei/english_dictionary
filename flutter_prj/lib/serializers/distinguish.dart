// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'single_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';
import 'sentence.dart';
import 'dart:convert';
import 'sentence.dart';
import 'package:flutter_prj/common/http.dart';


class DistinguishSerializer {
  DistinguishSerializer();

  num _id;
  num id;
  String content = '';
  SingleFile image = SingleFile('image', FileType.image);
  SingleFile vedio = SingleFile('vedio', FileType.video);
  List<String> wordsForeign = [];
  List<SentenceSerializer> sentencesForeign = [];
  List<SentenceSerializer> sentences = [];

  Future<bool> create({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/api/dictionary/distinguish/', data:data ?? _formData, queries:queries, cache:cache, options: Options(contentType: "multipart/form-data"));
    if(res != null) fromJson(res.data);
    return res != null;
  }

  Future<bool> update({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.PUT, '/api/dictionary/distinguish/$id/', data:data ?? _formData, queries:queries, cache:cache);
    return res != null;
  }

  Future<bool> retrieve({Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/api/dictionary/distinguish/$id/', queries:queries, cache:cache);
    if(res != null) fromJson(res.data);
    return res != null;
  }

  Future<bool> delete({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    if(_id == null) return true;
    var res = await Http().request(HttpType.DELETE, '/api/dictionary/distinguish/$id/', data:data ?? _formData, queries:queries, cache:cache);
    /*
    if(sentencesForeign != null){sentencesForeign.forEach((e){e.delete();});}
    if(sentences != null){sentences.forEach((e){e.delete();});}
    */
    return res != null ? res.statusCode == 204 : false;
  }

  Future<bool> save({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    bool res = false;
    if(_id == null) {
      var clone = DistinguishSerializer().from(this); // create will update self, maybe refresh the member of self.
      res = await clone.create(data:data, queries:queries, cache:cache);
      if(res == false) return false;
      id = clone.id;
      //if(sentencesForeign != null){await Future.forEach(sentencesForeign, (e) async { await e.save();});}
      //if(sentences != null){await Future.forEach(sentences, (e) async { await e.save();});}
      res = await retrieve();
    } else {
      res = await update(data:data, queries:queries, cache:cache);
      //if(sentencesForeign != null){await Future.forEach(sentencesForeign, (e) async { await e.save();});}
      //if(sentences != null){await Future.forEach(sentences, (e) async { await e.save();});}
    }
    return res;
  }

  DistinguishSerializer fromJson(Map<String, dynamic> json) {
    id = json['id'] == null ? null : json['id'] as num;
    content = json['content'] == null ? null : json['content'] as String;
    image.url = json['image'] == null ? null : json['image'] as String;
    vedio.url = json['vedio'] == null ? null : json['vedio'] as String;
    wordsForeign = json['wordsForeign'] == null
                ? []
                : json['wordsForeign'].map<String>((e) => e as String).toList();
    sentencesForeign = json['sentencesForeign'] == null
                ? []
                : json['sentencesForeign'].map<SentenceSerializer>((e) => SentenceSerializer().fromJson(e as Map<String, dynamic>)).toList();
    _id = id;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'content': content,
    'wordsForeign': wordsForeign == null ? null : wordsForeign.map((e) => e).toList(),
    'sentencesForeign': sentencesForeign == null ? null : sentencesForeign.map((e) => e.toJson()).toList(),
  };
  FormData get _formData {
    var jsonObj = toJson();
    //print(jsonObj);
    //jsonObj['sentencesForeign'] = json.encode(jsonObj['sentencesForeign']);
    //print(jsonObj);
    var formData = FormData.fromMap(jsonObj, ListFormat.multi);
    if(image.mptFile != null) formData.files.add(image.file);
    if(vedio.mptFile != null) formData.files.add(vedio.file);
    return formData;
  }

  DistinguishSerializer from(DistinguishSerializer instance) {
    if(instance == null) return this;
    id = instance.id;
    content = instance.content;
    image.from(instance.image);
    vedio.from(instance.vedio);
    wordsForeign = List.from(instance.wordsForeign);
    sentencesForeign = List.from(instance.sentencesForeign.map((e) => SentenceSerializer().from(e)).toList());
    sentences = List.from(instance.sentences.map((e) => SentenceSerializer().from(e)).toList());
    _id = instance._id;
    return this;
  }
}


