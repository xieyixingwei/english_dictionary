import 'dart:convert';
import '../models/index.dart';
import '../models/profile.dart';
import './cache.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'http.dart';



class Global {
  static bool get isRelease => true; // 是否为release版
  static SharedPreferences _prefs;
  static Profile profile = Profile();
  static Cache cache = Cache(); // 网络缓存对象
  static List<String> wordTagOptions = [];//["现在分词", "过去分词", "完成时", "第三人称单数", "名词形式", "副词形式", "形容词形式"]
  static const List<String> partOfSpeechOptions = const ["n.", "vt.", "vi.", "v.", "adj."];

  // 初始化全局信息，会在APP启动时执行
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.getString("profile");
    if (_profile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch (e) {
        print(e);
      }
    }

    profile.cacheConfig = profile.cacheConfig ?? CacheConfig()
      ..enable = true
      ..maxAge = 3600
      ..maxCount = 100;

    Http.init();
    wordTagOptions = await Http().listWordTagOptions();
  }

  // 持久化Profile信息
  static saveProfile() =>
      _prefs.setString("profile", jsonEncode(profile.toJson()));
  
  static clear() {
    cache.clear();
    profile.user = null;
  }
}
