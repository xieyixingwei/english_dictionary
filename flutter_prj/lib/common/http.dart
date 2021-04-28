import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';
import 'package:flutter/material.dart';
import './global.dart';

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
      receiveDataWhenStatusError: true,
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

  Future<Response> request(HttpType type, String path, {dynamic data, Map<String, dynamic> queries, bool cache=true}) async {
    Options opt = _options.copyWith(
            extra: {
              "noCache": cache, //本接口禁用缓存
            }
          );
    Response res;
    try{
      switch(type) {
        case HttpType.GET:
          res = await _dio.get(path, queryParameters: queries, options: opt);
          break;
        case HttpType.POST:
          res = await _dio.post(path, data:data, queryParameters: queries, options: opt, onSendProgress: (int a, int b) => print('---upload $a $b'));
          break;
        case HttpType.PUT:
          res = await _dio.put(path, data:data, queryParameters: queries, options: opt, onSendProgress: (int a, int b) => print('---upload $a $b'));
          break;
        case HttpType.DELETE:
          res = await _dio.delete(path, data:data, queryParameters: queries, options: opt);
          break;
      }
    } on DioError catch(e) {
      print('*** Http Error: ${e.response?.statusCode} ${e.response?.data}');
      return null;
    }

    return res;
  }
}
