// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'package:flutter_prj/common/http.dart';


class UserSerializer {
  UserSerializer();

  num id;
  String uname = '';
  String passwd = '';
  bool isAdmin = false;
  String register_date = '';
  String name = '';
  bool gender = true;
  String birthday = '';
  num education = 0;
  String wechart = '';
  String qq = '';
  String email = '';
  String telephone = '';
  String status = '';
  

  static Future<List<UserSerializer>> list({Map<String, dynamic> queryParameters, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/user/', queryParameters:queryParameters, cache:cache);
    return res.data.map<UserSerializer>((e) => UserSerializer().fromJson(e)).toList();
  }

  Future<UserSerializer> retrieve({Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/user/$uname/', queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : UserSerializer().fromJson(res.data);
  }

  Future<bool> delete({dynamic data, Map<String, dynamic> queryParameters, bool cache=false}) async {
    if(id == null) return false;
    var res = await Http().request(HttpType.DELETE, '/user/$uname/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    /*
    
    */
    return res != null ? res.statusCode == 204 : false;
  }

  Future<UserSerializer> register({dynamic data, Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/user/register/', data:(data == null ? this.toJson() : data), queryParameters:queryParameters, cache:cache);
    return update ? this.fromJson(res.data) : UserSerializer().fromJson(res.data);
  }

  UserSerializer fromJson(Map<String, dynamic> json) {
    id = json['id'] == null ? null : json['id'] as num;
    uname = json['uname'] == null ? null : json['uname'] as String;
    passwd = json['passwd'] == null ? null : json['passwd'] as String;
    isAdmin = json['isAdmin'] == null ? null : json['isAdmin'] as bool;
    register_date = json['register_date'] == null ? null : json['register_date'] as String;
    name = json['name'] == null ? null : json['name'] as String;
    gender = json['gender'] == null ? null : json['gender'] as bool;
    birthday = json['birthday'] == null ? null : json['birthday'] as String;
    education = json['education'] == null ? null : json['education'] as num;
    wechart = json['wechart'] == null ? null : json['wechart'] as String;
    qq = json['qq'] == null ? null : json['qq'] as String;
    email = json['email'] == null ? null : json['email'] as String;
    telephone = json['telephone'] == null ? null : json['telephone'] as String;
    status = json['status'] == null ? null : json['status'] as String;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'uname': uname,
    'passwd': passwd,
    'isAdmin': isAdmin,
    'register_date': register_date,
    'name': name,
    'gender': gender,
    'birthday': birthday,
    'education': education,
    'wechart': wechart,
    'qq': qq,
    'email': email,
    'telephone': telephone,
    'status': status,
  };
}


