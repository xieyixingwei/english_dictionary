import 'dart:convert';
import 'package:flutter_prj/common/net_cache.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'http.dart';



class Global {
  static bool get isRelease => true; // 是否为release版
  static SharedPreferences _prefs;
  static LocalStoreSerializer localStore = LocalStoreSerializer();
  static NetCache netCache = NetCache(); // 网络缓存对象
  static List<String> wordTagOptions = [];//["现在分词", "过去分词", "完成时", "第三人称单数", "名词形式", "副词形式", "形容词形式"]
  static List<String> sentenceTagOptions = [];
  static List<String> grammarTypeOptions = [];
  static List<String> grammarTagOptions = [];
  static const List<String> partOfSpeechOptions = const ["n.", "vt.", "vi.", "v.", "adj."];
  static const List<String> tenseOptions = const ["一般现在时", "一般过去时", "一般过去时", "将来时"];
  static const List<String> sentenceFormOptions = const ["定语从句","主语从句","被动句"];
  static List<bool> onOffWidget = [true, true, true];

  // 初始化全局信息，会在APP启动时执行
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
    var _localStore = _prefs.getString("localStore");
    if (_localStore != null) {
      try {
        localStore = LocalStoreSerializer().fromJson(jsonDecode(_localStore));
      } catch (e) {
        print('--- $e');
      }
    }

    localStore.netCacheConfig = localStore.netCacheConfig ?? NetCacheConfigSerializer()
      ..enable = true
      ..maxAge = 3600
      ..maxCount = 100;

    Http.init();
    List<WordTagsSerializer> wTags = await WordTagsSerializer.list();
    wordTagOptions = wTags.map((e) => e.t_name).toList();
    List<SentenceTagsSerializer> sTags = await SentenceTagsSerializer.list();
    sentenceTagOptions = sTags.map((e) => e.t_name).toList();
    List<GrammarTypeSerializer> gTypes = await GrammarTypeSerializer.list();
    grammarTypeOptions = gTypes.map((e) => e.g_name).toList();
    List<GrammarTagsSerializer> gTags = await GrammarTagsSerializer.list();
    grammarTagOptions = gTags.map((e) => e.g_name).toList();
  }

  // 持久化本地存储数据
  static saveLocalStore() {
    _prefs.setString("localStore", jsonEncode(localStore.toJson()));
  }

  static clear() {
    netCache.clear();
    localStore.user = null;
  }
}
