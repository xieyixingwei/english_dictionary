// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'single_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter_prj/common/http.dart';


class EtymaSerializer {
  EtymaSerializer();

  String _name;
  String name = '';
  String interpretation = '';
  num type = 0;
  SingleFile image = SingleFile('image', FileType.image);
  SingleFile vedio = SingleFile('vedio', FileType.video);

  Future<bool> create({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/api/dictionary/etyma/', data:data ?? _formData, queries:queries, cache:cache);
    if(res != null) fromJson(res.data);
    return res != null;
  }

  Future<bool> update({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.PUT, '/api/dictionary/etyma/$name/', data:data ?? _formData, queries:queries, cache:cache);
    return res != null;
  }

  Future<bool> retrieve({Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/api/dictionary/etyma/$name/', queries:queries, cache:cache);
    if(res != null) fromJson(res.data);
    return res != null;
  }

  Future<bool> delete({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    if(_name == null) return true;
    var res = await Http().request(HttpType.DELETE, '/api/dictionary/etyma/$name/', data:data ?? _formData, queries:queries, cache:cache);
    /*
    
    */
    return res != null ? res.statusCode == 204 : false;
  }

  Future<bool> save({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    bool res = false;
    if(_name == null) {
      res = await create(data:data, queries:queries, cache:cache);
    } else {
      res = await update(data:data, queries:queries, cache:cache);
    }
    return res;
  }

  EtymaSerializer fromJson(Map<String, dynamic> json) {
    name = json['name'] == null ? null : json['name'] as String;
    interpretation = json['interpretation'] == null ? null : json['interpretation'] as String;
    type = json['type'] == null ? null : json['type'] as num;
    image.url = json['image'] == null ? null : json['image'] as String;
    vedio.url = json['vedio'] == null ? null : json['vedio'] as String;
    _name = name;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
    'interpretation': interpretation,
    'type': type,
  };
  FormData get _formData {
    var jsonObj = toJson();
    
    var formData = FormData.fromMap(jsonObj, ListFormat.multi);
    if(image.mptFile != null) formData.files.add(image.file);
    if(vedio.mptFile != null) formData.files.add(vedio.file);
    return formData;
  }

  EtymaSerializer from(EtymaSerializer instance) {
    if(instance == null) return this;
    name = instance.name;
    interpretation = instance.interpretation;
    type = instance.type;
    image.from(instance.image);
    vedio.from(instance.vedio);
    _name = instance._name;
    return this;
  }
}


