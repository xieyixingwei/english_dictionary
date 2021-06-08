// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'single_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';
import 'sentence.dart';
import 'package:flutter_prj/common/http.dart';


class DialogSerializer {
  DialogSerializer();

  num _id;
  num id;
  String title = '';
  List<String> tag = [];
  SingleFile vedio = SingleFile('vedio', FileType.video);
  List<SentenceSerializer> sentenceSet = [];

  Future<bool> create({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/api/dictionary/dialog/', data:data ?? toJson(), queries:queries, cache:cache);
    if(res != null) {
      var jsonObj = {'id': res.data['id'] ?? id};
      fromJson(jsonObj); // Only update primary member after create
    }
    return res != null;
  }

  Future<bool> update({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.PUT, '/api/dictionary/dialog/$id/', data:data ?? toJson(), queries:queries, cache:cache);
    return res != null;
  }

  Future<bool> retrieve({Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/api/dictionary/dialog/$id/', queries:queries, cache:cache);
    if(res != null) fromJson(res.data);
    return res != null;
  }

  Future<bool> delete({num pk}) async {
    if(_id == null && pk == null) return true;
    if(pk != null) id = pk;
    var res = await Http().request(HttpType.DELETE, '/api/dictionary/dialog/$id/');
    /*
    if(sentenceSet != null){sentenceSet.forEach((e){e.delete();});}
    */
    return res != null ? res.statusCode == 204 : false;
  }

  Future<bool> save({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    bool res = _id == null ?
      await create(data:data, queries:queries, cache:cache) :
      await update(data:data, queries:queries, cache:cache);

    if(res) {
      await Future.forEach(sentenceSet, (e) async {e.dialogForeign = id; await e.save();});
    }
    res = await uploadFile();
    return res;
  }

  DialogSerializer fromJson(Map<String, dynamic> json) {
    id = json['id'] == null ? id : json['id'] as num;
    title = json['title'] == null ? title : json['title'] as String;
    tag = json['tag'] == null
                ? tag
                : json['tag'].map<String>((e) => e as String).toList();
    vedio.url = json['vedio'] == null ? vedio.url : json['vedio'] as String;
    sentenceSet = json['sentenceSet'] == null
                ? sentenceSet
                : json['sentenceSet'].map<SentenceSerializer>((e) => SentenceSerializer().fromJson(e as Map<String, dynamic>)).toList();
    _id = id;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'title': title,
    'tag': tag == null ? null : tag.map((e) => e).toList(),
  }..removeWhere((k, v) => v==null);

  Future<bool> uploadFile() async {
    var jsonObj = {'id': id};
    var formData = FormData.fromMap(jsonObj, ListFormat.multi);
    if(vedio.mptFile != null) formData.files.add(vedio.file);
    bool ret = true;
    if(formData.files.isNotEmpty) {
      ret = await update(data:formData);
      if(vedio.mptFile != null) vedio.mptFile = null;
    }
    return ret;
  }

  DialogSerializer from(DialogSerializer instance) {
    if(instance == null) return this;
    id = instance.id;
    title = instance.title;
    tag = List.from(instance.tag);
    vedio.from(instance.vedio);
    sentenceSet = List.from(instance.sentenceSet.map((e) => SentenceSerializer().from(e)).toList());
    _id = instance._id;
    return this;
  }
}



