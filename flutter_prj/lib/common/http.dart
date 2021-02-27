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
      baseUrl: 'http://192.168.1.10:5005',
    )
  );

  static set token(String token) => _dio.options.headers[HttpHeaders.authorizationHeader] = token;

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