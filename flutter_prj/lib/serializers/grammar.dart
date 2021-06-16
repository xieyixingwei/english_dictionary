// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

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
  String title = '';
  String content = '';
  SingleFile image = SingleFile('image', FileType.image);
  SingleFile vedio = SingleFile('vedio', FileType.video);
  String wordForeign;
  num sentenceForeign;

  Future<bool> create({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/api/dictionary/grammar/', data:data ?? toJson(), queries:queries, cache:cache);
    fromJson(res?.data, slave:false); // Don't update slave forign members in create to avoid erasing newly added associated data
    return res != null;
  }

  Future<bool> update({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.PUT, '/api/dictionary/grammar/$id/', data:data ?? toJson(), queries:queries, cache:cache);
    fromJson(res?.data, slave:false); // Don't update slave forign members in update to avoid erasing newly added associated data
    return res != null;
  }

  Future<bool> retrieve({Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/api/dictionary/grammar/$id/', queries:queries, cache:cache);
    fromJson(res?.data);
    return res != null;
  }

  Future<bool> delete({num pk}) async {
    if(_id == null && pk == null) return true;
    if(pk != null) id = pk;
    var res = await Http().request(HttpType.DELETE, '/api/dictionary/grammar/$id/');
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

  GrammarSerializer fromJson(Map<String, dynamic> json, {bool slave = true}) {
    if(json == null) return this;
    id = json['id'] == null ? id : json['id'] as num;
    type = json['type'] == null
                ? type
                : json['type'].map<String>((e) => e as String).toList();
    tag = json['tag'] == null
                ? tag
                : json['tag'].map<String>((e) => e as String).toList();
    title = json['title'] == null ? title : json['title'] as String;
    content = json['content'] == null ? content : json['content'] as String;
    image.url = json['image'] == null ? image.url : json['image'] as String;
    vedio.url = json['vedio'] == null ? vedio.url : json['vedio'] as String;
    wordForeign = json['wordForeign'] == null ? wordForeign : json['wordForeign'] as String;
    sentenceForeign = json['sentenceForeign'] == null ? sentenceForeign : json['sentenceForeign'] as num;
    _id = id;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'type': type == null ? null : type.map((e) => e).toList(),
    'tag': tag == null ? null : tag.map((e) => e).toList(),
    'title': title,
    'content': content,
    'wordForeign': wordForeign,
    'sentenceForeign': sentenceForeign,
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

  GrammarSerializer from(GrammarSerializer instance) {
    if(instance == null) return this;
    id = instance.id;
    type = List.from(instance.type);
    tag = List.from(instance.tag);
    title = instance.title;
    content = instance.content;
    image.from(instance.image);
    vedio.from(instance.vedio);
    wordForeign = instance.wordForeign;
    sentenceForeign = instance.sentenceForeign;
    _id = instance._id;
    return this;
  }
}



