// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'package:flutter_prj/common/http.dart';


class EtymaSerializer {
  EtymaSerializer();

  String _name;
  String name = '';
  String interpretation = '';
  num type = 0;
  String image = '';
  String vedio = '';

  Future<bool> create({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/dictionary/etyma/', data:data ?? this.toJson(), queries:queries, cache:cache);
    if(res != null) this.fromJson(res.data);
    return res != null;
  }

  Future<bool> update({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.PUT, '/dictionary/etyma/$name/', data:data ?? this.toJson(), queries:queries, cache:cache);
    return res != null;
  }

  Future<bool> retrieve({Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/dictionary/etyma/$name/', queries:queries, cache:cache);
    if(res != null) this.fromJson(res.data);
    return res != null;
  }

  Future<bool> delete({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    if(_name == null) return true;
    var res = await Http().request(HttpType.DELETE, '/dictionary/etyma/$name/', data:data ?? this.toJson(), queries:queries, cache:cache);
    /*
    
    */
    return res != null ? res.statusCode == 204 : false;
  }

  Future<bool> save({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    bool res = false;
    if(_name == null) {
      res = await this.create(data:data, queries:queries, cache:cache);
    } else {
      res = await this.update(data:data, queries:queries, cache:cache);
    }
    return res;
  }

  EtymaSerializer fromJson(Map<String, dynamic> json) {
    name = json['name'] == null ? null : json['name'] as String;
    interpretation = json['interpretation'] == null ? null : json['interpretation'] as String;
    type = json['type'] == null ? null : json['type'] as num;
    image = json['image'] == null ? null : json['image'] as String;
    vedio = json['vedio'] == null ? null : json['vedio'] as String;
    _name = name;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
    'interpretation': interpretation,
    'type': type,
  };

  EtymaSerializer from(EtymaSerializer instance) {
    name = instance.name;
    interpretation = instance.interpretation;
    type = instance.type;
    image = instance.image;
    vedio = instance.vedio;
    _name = instance._name;
    return this;
  }
}


