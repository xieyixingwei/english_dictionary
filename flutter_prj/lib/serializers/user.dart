// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'package:flutter_prj/common/http.dart';


class UserSerializer {
  UserSerializer();

  num u_id;
  String u_uname = '';
  String u_passwd = '';
  bool u_is_admin = false;
  String u_register_date = '';
  String u_name = '';
  bool u_gender = true;
  String u_birthday = '';
  num u_education = 0;
  String u_wechart = '';
  String u_qq = '';
  String u_email = '';
  String u_telephone = '';
  String u_status = '';
  

  static Future<List<UserSerializer>> list({Map<String, dynamic> queryParameters, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/user/', queryParameters:queryParameters, cache:cache);
    return res.data.map<UserSerializer>((e) => UserSerializer().fromJson(e)).toList();
  }

  Future<UserSerializer> retrieve({Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/user/$u_uname/', queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : UserSerializer().fromJson(res.data);
  }

  Future<bool> delete({dynamic data, Map<String, dynamic> queryParameters, bool cache=false}) async {
    if(u_id == null) return false;
    var res = await Http().request(HttpType.DELETE, '/user/$u_uname/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    /*
    
    */
    return res != null ? res.statusCode == 204 : false;
  }

  Future<UserSerializer> register({dynamic data, Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/user/register/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : UserSerializer().fromJson(res.data);
  }

  UserSerializer fromJson(Map<String, dynamic> json) {
    u_id = json['u_id'] as num;
    u_uname = json['u_uname'] as String;
    u_passwd = json['u_passwd'] as String;
    u_is_admin = json['u_is_admin'] as bool;
    u_register_date = json['u_register_date'] as String;
    u_name = json['u_name'] as String;
    u_gender = json['u_gender'] as bool;
    u_birthday = json['u_birthday'] as String;
    u_education = json['u_education'] as num;
    u_wechart = json['u_wechart'] as String;
    u_qq = json['u_qq'] as String;
    u_email = json['u_email'] as String;
    u_telephone = json['u_telephone'] as String;
    u_status = json['u_status'] as String;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'u_id': u_id,
    'u_uname': u_uname,
    'u_passwd': u_passwd,
    'u_is_admin': u_is_admin,
    'u_register_date': u_register_date,
    'u_name': u_name,
    'u_gender': u_gender,
    'u_birthday': u_birthday,
    'u_education': u_education,
    'u_wechart': u_wechart,
    'u_qq': u_qq,
    'u_email': u_email,
    'u_telephone': u_telephone,
    'u_status': u_status,
  };
}


