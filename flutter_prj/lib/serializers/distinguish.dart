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
  List<num> sentencePatternForeign = [];
  List<SentencePatternSerializer> sentencePatternForeignSet = [];

  Future<bool> create({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/api/dictionary/distinguish/', data:data ?? toJson(), queries:queries, cache:cache);
    if(res != null) {
      var jsonObj = {'id': res.data['id'] ?? id};
      fromJson(jsonObj); // Only update primary member after create
    }
    return res != null;
  }

  Future<bool> update({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.PUT, '/api/dictionary/distinguish/$id/', data:data ?? toJson(), queries:queries, cache:cache);
    return res != null;
  }

  Future<bool> retrieve({Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/api/dictionary/distinguish/$id/', queries:queries, cache:cache);
    if(res != null) fromJson(res.data);
    return res != null;
  }

  Future<bool> delete({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    if(_id == null) return true;
    var res = await Http().request(HttpType.DELETE, '/api/dictionary/distinguish/$id/', data:data ?? toJson(), queries:queries, cache:cache);
    /*
    if(sentencePatternForeignSet != null){sentencePatternForeignSet.forEach((e){e.delete();});}
    */
    return res != null ? res.statusCode == 204 : false;
  }

  Future<bool> save({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    bool res = _id == null ?
      await create(data:data, queries:queries, cache:cache) :
      await update(data:data, queries:queries, cache:cache);

    if(res) {
      await Future.forEach(sentencePatternForeignSet, (e) async { await e.save();});
    }
    res = await uploadFile();
    return res;
  }

  DistinguishSerializer fromJson(Map<String, dynamic> json) {
    id = json['id'] == null ? id : json['id'] as num;
    content = json['content'] == null ? content : json['content'] as String;
    image.url = json['image'] == null ? image.url : json['image'] as String;
    vedio.url = json['vedio'] == null ? vedio.url : json['vedio'] as String;
    wordsForeign = json['wordsForeign'] == null
                ? wordsForeign
                : json['wordsForeign'].map<String>((e) => e as String).toList();
    sentencePatternForeign = json['sentencePatternForeign'] == null
                ? sentencePatternForeign
                : json['sentencePatternForeign'].map<num>((e) => e as num).toList();
    _id = id;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'content': content,
    'wordsForeign': wordsForeign == null ? null : wordsForeign.map((e) => e).toList(),
    'sentencePatternForeign': sentencePatternForeign == null ? null : sentencePatternForeign.map((e) => e).toList(),
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
    sentencePatternForeign = List.from(instance.sentencePatternForeign);
    sentencePatternForeignSet = List.from(instance.sentencePatternForeignSet.map((e) => SentencePatternSerializer().from(e)).toList());
    _id = instance._id;
    return this;
  }
}


