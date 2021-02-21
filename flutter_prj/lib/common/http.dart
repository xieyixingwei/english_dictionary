import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prj/models/sentence.dart';
import 'package:flutter_prj/models/word_tags.dart';
import '../models/index.dart';
import './global.dart';
import 'dart:convert';


class Http {
  Options _options;
  static Dio _dio = new Dio(
    BaseOptions(
      baseUrl: 'http://192.168.1.10:5005',
    )
  );

  // 在网络请求过程中可能会需要使用当前的context信息，比如在请求失败时
  // 打开一个新路由，而打开新路由需要context信息。
  Http([BuildContext context]) {
    _options = Options(extra: {"context": context},);
  }

  static void init() {
    ///_dio.interceptors.add(Global.cache); // dio添加缓存插件
    // 设置用户token（可能为null，代表未登录）
    _dio.options.headers[HttpHeaders.authorizationHeader] = Global.profile.token;

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

  Future<User> register(String uname, String pwd) async {
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
    print(res.data);
    return User.fromJson(res.data);
  }

  Future<User> login(String uname, String pwd) async {
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

    Global.cache.clear(); //清空所有缓存
    Global.profile.token = token; // 更新profile中的token信息
    return User.fromJson(res.data);
  }

  Future<List<String>> listWordTagOptions() async {
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

  Future<List<String>> listPartOfSpeech() async {
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

  void createWordTagOption(String tag) async {
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

  void deleteWordTagOption(String tag) async {
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

  void createSentenceOption(Sentence sentence) async {
    print(sentence.toJson());
    FormData formData = FormData.fromMap({
      "s_id": sentence.s_id,
      "s_en": sentence.s_en,
      "s_ch": sentence.s_ch,
      "s_type": sentence.s_type,
      "s_tags": sentence.s_tags,
      "s_tense": ["一般过去式", "被动语态"],
      "s_form": sentence.s_form, //"[复合句, 问候语, 从句, 陈述句]"
    });
    await _dio.post(
      "/dictionary/sentence/create/",
      data: formData,
      options: _options.merge(
        extra: {
          "noCache": true, //本接口禁用缓存
        }
      ),
    );
  }
}
