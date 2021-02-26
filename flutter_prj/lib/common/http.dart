import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prj/serializers/index.dart';
import './global.dart';
import 'dart:convert';

enum HttpType {
  POST,
  PUT,
  GET,
  DELETE
}

class Http {
  
  Options _options;
  static Dio _dio = new Dio(
    BaseOptions(
      baseUrl: 'http://192.168.2.10:5005',
    )
  );

  // 可能会使用当前的context信息，比如在请求失败时打开一个新路由。
  Http([BuildContext context]) {
    _options = Options(extra: {"context": context},);
  }

  static void init() {
    ///_dio.interceptors.add(Global.cache); // dio添加缓存插件
    // 设置用户token（可能为null，代表未登录）
    _dio.options.headers[HttpHeaders.authorizationHeader] = Global.localStore.token;

    // 在调试模式下需要抓包调试，所以我们使用代理，并禁用HTTPS证书校验
    if (!Global.isRelease) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
          client.findProxy = (uri) {
            return "PROXY 192.168.2.10:8118";
          };
        //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      };
    }
  }

  Future<UserSerializer> register(String uname, String pwd) async {
    FormData formData = FormData.fromMap({"u_uname":uname, "u_passwd":pwd});
    var res = await _dio.post(
      "/user/register/",
      data: formData,
      options: _options.merge(
        extra: {
          "noCache": true, //本接口禁用缓存
        }
      ),
    );
    return UserSerializer().fromJson(res.data);
  }

  Future<UserSerializer> login(String uname, String pwd) async {
    FormData formData = FormData.fromMap({"u_uname":uname, "u_passwd":pwd});
    var res = await _dio.post(
      "/user/login/",
      data: formData,
      options: _options.merge(
        extra: {
          "noCache": true, //本接口禁用缓存
        }
      ),
    );

    String token = res.data['token'];

    //登录成功后更新公共头（authorization），此后的所有请求都会带上用户身份信息
    _dio.options.headers[HttpHeaders.authorizationHeader] = token;

    res = await _dio.get(
      "/user/$uname/",
      options: _options.merge(
        extra: {
          "noCache": true, //本接口禁用缓存
        }
      ),
    );
    Global.netCache.clear(); //清空所有缓存
    Global.localStore.token = token; // 更新token信息
    return UserSerializer().fromJson(res.data);
  }

  Future<List<String>> listWordTags() async {
    var res = await _dio.get(
      "/dictionary/wordtags/",
      options: _options.merge(
        extra: {
          "noCache": true, //本接口禁用缓存
        }
      ),
    );
    List<String> tmp = [];
    res.data.forEach((e) => tmp.add(e["t_name"].toString()));
    return tmp;
  }

  void createWordTag(String tag) async {
    FormData formData = FormData.fromMap({"t_name":tag});
    await _dio.post(
      "/dictionary/wordtags/create/",
      data: formData,
      options: _options.merge(
        extra: {
          "noCache": true, //本接口禁用缓存
        }
      ),
    );
  }

  void deleteWordTag(String tag) async {
    await _dio.delete(
      "/dictionary/wordtags/delete/$tag/",
      options: _options.merge(
        extra: {
          "noCache": true, //本接口禁用缓存
        }
      ),
    );
  }

  Future listUsers() async {
    var res = await _dio.get(
      "/user/",
      options: _options.merge(
        extra: {
          "noCache": true, //本接口禁用缓存
        }
      ),
    );

    return res.data;
  }

  void deleteUser(String uname) async {
    await _dio.delete(
      "/user/$uname",
      options: _options.merge(
        extra: {
          "noCache": true, //本接口禁用缓存
        }
      ),
    );
  }

  Future<Response> request(HttpType type, String path, {dynamic data, Map<String, dynamic> queryParameters, bool cache=true}) async {
    Options opt = _options.merge(
            extra: {
              "noCache": cache, //本接口禁用缓存
            }
          );
    try{
      switch(type) {
        case HttpType.GET:
          return await _dio.get(path, queryParameters: queryParameters, options: opt);
        case HttpType.POST:
          return await _dio.post(path, data:data, queryParameters: queryParameters, options: opt);
        case HttpType.PUT:
          return await _dio.put(path, data:data, queryParameters: queryParameters, options: opt);
        case HttpType.DELETE:
          return await _dio.delete(path, data:data, queryParameters: queryParameters, options: opt);
      }
    } catch(e) {
      print('*** Http Error: $e');
    }
    return null;
  }
}
