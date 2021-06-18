// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'single_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';
import 'sentence_pattern.dart';
import 'package:flutter_prj/common/http.dart';


class DistinguishSerializer {
  DistinguishSerializer();

  num _id;
  num id;
  String content = '';
  SingleFile image = SingleFile('image', FileType.image);
  SingleFile vedio = SingleFile('vedio', FileType.video);
  List<String> wordsForeign = [];
  List<SentencePatternSerializer> sentencePatternForeign = [];

  Future<bool> create({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/api/dictionary/distinguish/', data:data ?? toJson(), queries:queries, cache:cache);
    fromJson(res?.data, slave:false); // Don't update slave forign members in create to avoid erasing newly added associated data
    return res != null;
  }

  Future<bool> update({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.PUT, '/api/dictionary/distinguish/$id/', data:data ?? toJson(), queries:queries, cache:cache);
    fromJson(res?.data, slave:false); // Don't update slave forign members in update to avoid erasing newly added associated data
    return res != null;
  }

  Future<bool> retrieve({Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/api/dictionary/distinguish/$id/', queries:queries, cache:cache);
    fromJson(res?.data);
    return res != null;
  }

  Future<bool> delete({num pk}) async {
    if(_id == null && pk == null) return true;
    if(pk != null) id = pk;
    var res = await Http().request(HttpType.DELETE, '/api/dictionary/distinguish/$id/');
    /*
    
    */
    return res != null ? res.statusCode == 204 : false;
  }

  Future<bool> save({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    bool res = _id == null ?
      await create(data:data, queries:queries, cache:cache) :
      await update(data:data, queries:queries, cache:cache);

    res = await uploadFile();
    return res;
  }

  DistinguishSerializer fromJson(Map<String, dynamic> json, {bool slave = true}) {
    if(json == null) return this;
    id = json['id'] == null ? id : json['id'] as num;
    content = json['content'] == null ? content : json['content'] as String;
    image.url = json['image'] == null ? image.url : json['image'] as String;
    vedio.url = json['vedio'] == null ? vedio.url : json['vedio'] as String;
    wordsForeign = json['wordsForeign'] == null
                ? wordsForeign
                : json['wordsForeign'].map<String>((e) => e as String).toList();
    sentencePatternForeign = json['sentencePatternForeign'] == null
                ? sentencePatternForeign
                : json['sentencePatternForeign'].map<SentencePatternSerializer>((e) => SentencePatternSerializer().fromJson(e as Map<String, dynamic>)).toList();
    _id = id;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'content': content,
    'wordsForeign': wordsForeign == null ? null : wordsForeign.map((e) => e).toList(),
    'sentencePatternForeign': sentencePatternForeign == null ? null : sentencePatternForeign.map((e) => e.toJson()).toList(),
  }..removeWhere((k, v) => v==null);

  Future<bool> uploadFile() async {
    var jsonObj = {'id': id};
    var formData = FormData.fromMap(jsonObj, ListFormat.multi);
    if(image.mptFile != null) formData.files.add(image.file);
    if(vedio.mptFile != null) formData.files.add(vedio.file);
    bool ret = true;
    if(formData.files.isNotEmpty) {
      ret = await update(data:formData);
      if(image.mptFile != null) image.mptFile = null;
      if(vedio.mptFile != null) vedio.mptFile = null;
    }
    return ret;
  }

  DistinguishSerializer from(DistinguishSerializer instance) {
    if(instance == null) return this;
    id = instance.id;
    content = instance.content;
    image.from(instance.image);
    vedio.from(instance.vedio);
    wordsForeign = List.from(instance.wordsForeign);
    sentencePatternForeign = List.from(instance.sentencePatternForeign.map((e) => SentencePatternSerializer().from(e)).toList());
    _id = instance._id;
    return this;
  }
}



