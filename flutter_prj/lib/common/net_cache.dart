import 'dart:collection';
import 'package:dio/dio.dart';
import './global.dart';


class CacheObject { // 保存缓存信息
  Response response;
  int timeStamp;

  CacheObject(this.response)
      : timeStamp = DateTime.now().millisecondsSinceEpoch;

  @override
  bool operator ==(other) {
    return response.hashCode == other.hashCode;
  }

  @override
  int get hashCode => response.realUri.hashCode;
}


class NetCache extends Interceptor {
  // 为确保迭代器顺序和对象插入时间一致顺序一致，我们使用LinkedHashMap
  var _cache = LinkedHashMap<String, CacheObject>();

  @override
  onRequest(RequestOptions options, RequestInterceptorHandler rth) async {
    if (!Global.localStore.netCacheConfig.enable) return;

    //如果是下拉刷新，先删除相关缓存
    if (options.extra["refresh"] == true) {
      if (options.extra["list"] == true) {
        //若是列表，则只要url中包含当前path的缓存全部删除（简单实现，并不精准）
        _cache.removeWhere((key, v) => key.contains(options.path));
      } else {
        // 如果不是列表，则只删除uri相同的缓存
        delete(options.uri.toString());
      }
      return;
    }

    if (options.extra["noCache"] != true &&
        options.method.toLowerCase() == 'get') {
      String key = options.extra["cacheKey"] ?? options.uri.toString();
      var ob = _cache[key];
      if (ob != null) {
        //若缓存未过期，则返回缓存内容
        if ((DateTime.now().millisecondsSinceEpoch - ob.timeStamp) / 1000 <
            Global.localStore.netCacheConfig.maxAge) {
          return;
        } else {
          //若已过期则删除缓存，继续向服务器请求
          _cache.remove(key);
        }
      }
    }
  }

  @override
  onError(DioError err, ErrorInterceptorHandler eth) async {
    // 错误状态不缓存
  }

  @override
  onResponse(Response response, ResponseInterceptorHandler rth) async {
    // 如果启用缓存，将返回结果保存到缓存
    if (Global.localStore.netCacheConfig.enable) {
      _saveCache(response);
    }
  }

  _saveCache(Response object) {
    RequestOptions options = object.requestOptions;
    if (options.extra["noCache"] != true &&
        options.method.toLowerCase() == "get") {
      // 如果缓存数量超过最大数量限制，则先移除最早的一条记录
      if (_cache.length == Global.localStore.netCacheConfig.maxCount) {
        _cache.remove(_cache[_cache.keys.first]);
      }
      String key = options.extra["cacheKey"] ?? options.uri.toString();
      _cache[key] = CacheObject(object);
    }
  }

  void delete(String key) => _cache.remove(key);
  void clear() => _cache.clear();
}
