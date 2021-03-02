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
  

  Future<LoginSerializer> login({dynamic data, Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/user/login/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : LoginSerializer().fromJson(res.data);
  }

  LoginSerializer fromJson(Map<String, dynamic> json) {
    msg = json['msg'] as String;
    status = json['status'] as num;
    token = json['token'] as String;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'msg': msg,
    'status': status,
    'token': token,
  };
}


