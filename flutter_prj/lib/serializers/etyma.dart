// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'package:flutter_prj/common/http.dart';


class EtymaSerializer {
  EtymaSerializer();

  String e_name = '';
  String e_meaning = '';
  num e_type;
  

  Future<EtymaSerializer> create({dynamic data, Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/dictionary/etyma/create/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : EtymaSerializer().fromJson(res.data);
  }

  Future<EtymaSerializer> update({dynamic data, Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    var res = await Http().request(HttpType.PUT, '/dictionary/etyma/update/$e_name/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : EtymaSerializer().fromJson(res.data);
  }

  Future<EtymaSerializer> retrieve({Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/dictionary/etyma/$e_name/', queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : EtymaSerializer().fromJson(res.data);
  }

  Future<bool> delete({dynamic data, Map<String, dynamic> queryParameters, bool cache=false}) async {
    if(e_name == null) return false;
    var res = await Http().request(HttpType.DELETE, '/dictionary/etyma/delete/$e_name/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    /*
    
    */
    return res != null ? res.statusCode == 204 : false;
  }

  EtymaSerializer fromJson(Map<String, dynamic> json) {
    e_name = json['e_name'] == null ? null : json['e_name'] as String;
    e_meaning = json['e_meaning'] == null ? null : json['e_meaning'] as String;
    e_type = json['e_type'] == null ? null : json['e_type'] as num;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'e_name': e_name,
    'e_meaning': e_meaning,
    'e_type': e_type,
  };
}


