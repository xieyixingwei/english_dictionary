// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'package:flutter_prj/common/http.dart';


class LoginSerializer {
  LoginSerializer();

  String msg = '';
  num status = 0;
  String token;

  Future<bool> login({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/user/login/', data:data ?? toJson(), queries:queries, cache:cache);
    if(res != null) fromJson(res.data);
    return res != null;
  }

  LoginSerializer fromJson(Map<String, dynamic> json) {
    msg = json['msg'] == null ? null : json['msg'] as String;
    status = json['status'] == null ? null : json['status'] as num;
    token = json['token'] == null ? null : json['token'] as String;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'msg': msg,
    'status': status,
    'token': token,
  };

  LoginSerializer from(LoginSerializer instance) {
    msg = instance.msg;
    status = instance.status;
    token = instance.token;
    return this;
  }
}


