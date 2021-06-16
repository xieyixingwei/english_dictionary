// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************


class NetCacheConfigSerializer {
  NetCacheConfigSerializer();

  bool enable = true;
  num maxAge = 1000;
  num maxCount = 100;


  NetCacheConfigSerializer fromJson(Map<String, dynamic> json, {bool slave = true}) {
    if(json == null) return this;
    enable = json['enable'] == null ? enable : json['enable'] as bool;
    maxAge = json['maxAge'] == null ? maxAge : json['maxAge'] as num;
    maxCount = json['maxCount'] == null ? maxCount : json['maxCount'] as num;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'enable': enable,
    'maxAge': maxAge,
    'maxCount': maxCount,
  }..removeWhere((k, v) => v==null);


  NetCacheConfigSerializer from(NetCacheConfigSerializer instance) {
    if(instance == null) return this;
    enable = instance.enable;
    maxAge = instance.maxAge;
    maxCount = instance.maxCount;
    return this;
  }
}



