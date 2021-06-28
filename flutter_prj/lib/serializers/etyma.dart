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
    var res = await Http().request(HttpType.POST, '/api/dictionary/etyma/', data:data ?? toJson(), queries:queries, cache:cache);
    fromJson(res?.data, slave:false); // Don't update slave forign members in create to avoid erasing newly added associated data
    return res != null;
  }

  Future<bool> update({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.PUT, '/api/dictionary/etyma/$name/', data:data ?? toJson(), queries:queries, cache:cache);
    fromJson(res?.data, slave:false); // Don't update slave forign members in update to avoid erasing newly added associated data
    return res != null;
  }

  Future<bool> retrieve({Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/api/dictionary/etyma/$name/', queries:queries, cache:cache);
    fromJson(res?.data);
    return res != null;
  }

  Future<bool> delete({String pk}) async {
    if(_name == null && pk == null) return true;
    if(pk != null) name = pk;
    var res = await Http().request(HttpType.DELETE, '/api/dictionary/etyma/$name/');
    /*
    
    */
    return res != null ? res.statusCode == 204 : false;
  }

  Future<List<EtymaSerializer>> list({Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/api/dictionary/etyma/', queries:queries, cache:cache);
    return res != null ? res.data.map<EtymaSerializer>((e) => EtymaSerializer().fromJson(e)).toList() : [];
  }

  Future<bool> save({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    bool res = _name == null ?
      await create(data:data, queries:queries, cache:cache) :
      await update(data:data, queries:queries, cache:cache);
    res = await uploadFile();
    return res;
  }

  EtymaSerializer fromJson(Map<String, dynamic> json, {bool slave = true}) {
    if(json == null) return this;
    name = json['name'] == null ? name : json['name'] as String;
    interpretation = json['interpretation'] == null ? interpretation : json['interpretation'] as String;
    type = json['type'] == null ? type : json['type'] as num;
    image.url = json['image'] == null ? image.url : json['image'] as String;
    vedio.url = json['vedio'] == null ? vedio.url : json['vedio'] as String;
    _name = name;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
    'interpretation': interpretation,
    'type': type,
  }..removeWhere((k, v) => v==null);

  Future<bool> uploadFile() async {
    var jsonObj = {'name': name};
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


