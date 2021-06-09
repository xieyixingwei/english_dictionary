import 'dart:convert';
import 'package:flutter_prj/common/net_cache.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'http.dart';


class Global {
  // 全局单例共享数据
  static bool get isRelease => true; // 是否为release版
  static SharedPreferences _prefs;
  static LocalStoreSerializer localStore = LocalStoreSerializer();
  static NetCache netCache = NetCache(); // 网络缓存对象
  static List<String> wordTagOptions = [];
  static List<String> sentenceTagOptions = [];
  static List<String> grammarTypeOptions = [];
  static List<String> grammarTagOptions = [];
  static List<String> etymaOptions = [];
  static List<String> dialogTagOptions = [];
  static const List<String> partOfSpeechOptions = const ['n.', 'adj.', 'adv.', 'v.', 'vt.', 'vi.', 'pron.', 'num.', 'interj.', 'prep.', 'conj.', 'art.', 'phrase'];
  static const List<String> tenseOptions = const ['一般过去时', '一般现在时', '一般将来时', '一般过去将来时',
                                                  '过去进行时', '现在进行时', '将来进行时', '过去将来进行时',
                                                  '过去完成时', '现在完成时', '将来完成时', '过去将来完成时',
                                                  '过去完成进行时', '现在完成进行时', '将来完成进行时', '过去将来完成进行时'];
  static const List<String> sentenceFormOptions = const ['简单句', '复合句', '复杂句', '主语从句', '定语从句', '状语从句', '名词性从句'];
  static final List<String> etymaTypeOptions = ['前缀', '后缀', '词根'];
  static List<bool> onOffWidget = [true, true, true];
  static bool isLogin = false;

  // 初始化全局信息，会在APP启动时执行
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
    var localStoreString = _prefs.getString("localStore");
    if (localStoreString != null) {
      localStore = LocalStoreSerializer().fromJson(jsonDecode(localStoreString));
    }

    localStore.netCacheConfig = localStore.netCacheConfig ?? NetCacheConfigSerializer()
      ..enable = true
      ..maxAge = 3600
      ..maxCount = 100;

    Http.init();
    List<WordTagSerializer> wTags = await WordTagSerializer().list();
    wordTagOptions = wTags.map((e) => e.name).toList();
    List<SentenceTagSerializer> sTags = await SentenceTagSerializer().list();
    sentenceTagOptions = sTags.map((e) => e.name).toList();
    List<GrammarTypeSerializer> gTypes = await GrammarTypeSerializer().list();
    grammarTypeOptions = gTypes.map((e) => e.name).toList();
    List<GrammarTagSerializer> gTags = await GrammarTagSerializer().list();
    grammarTagOptions = gTags.map((e) => e.name).toList();
    EtymaPaginationSerializer etymas = EtymaPaginationSerializer();
    await etymas.retrieve();
    etymaOptions = etymas.results.map((e) => e.name).toList();

    var dTags = await DialogTagSerializer().list();
    dialogTagOptions = dTags.map((e) => e.name).toList();
  
    isLogin = await localStore.user.retrieve();
  }

  // 持久化本地存储数据
  static saveLocalStore() {
    _prefs.setString("localStore", jsonEncode(localStore.toJson()));
  }

  static clear() {
    netCache.clear();
  }
}
