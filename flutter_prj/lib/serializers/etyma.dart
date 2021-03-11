// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'package:flutter_prj/common/http.dart';


class EtymaSerializer {
  EtymaSerializer();

  String name = '';
  String interpretation = '';
  num type;
  String image = '';
  String vedio = '';
  

  Future<EtymaSerializer> create({dynamic data, Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/dictionary/etyma/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : EtymaSerializer().fromJson(res.data);
  }

  Future<EtymaSerializer> update({dynamic data, Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    var res = await Http().request(HttpType.PUT, '/dictionary/etyma/$name/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : EtymaSerializer().fromJson(res.data);
  }

  Future<EtymaSerializer> retrieve({Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/dictionary/etyma/$name/', queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : EtymaSerializer().fromJson(res.data);
  }

  Future<bool> delete({dynamic data, Map<String, dynamic> queryParameters, bool cache=false}) async {
    if(name == null) return false;
    var res = await Http().request(HttpType.DELETE, '/dictionary/etyma/$name/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    /*
    
    */
    return res != null ? res.statusCode == 204 : false;
  }

  EtymaSerializer fromJson(Map<String, dynamic> json) {
    name = json['name'] == null ? null : json['name'] as String;
    interpretation = json['interpretation'] == null ? null : json['interpretation'] as String;
    type = json['type'] == null ? null : json['type'] as num;
    image = json['image'] == null ? null : json['image'] as String;
    vedio = json['vedio'] == null ? null : json['vedio'] as String;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
    'interpretation': interpretation,
    'type': type,
  };
}


