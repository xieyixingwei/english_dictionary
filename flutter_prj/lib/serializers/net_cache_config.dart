// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************


class NetCacheConfigSerializer {
  NetCacheConfigSerializer();

  bool enable = true;
  num maxAge = 1000;
  num maxCount = 100;


  NetCacheConfigSerializer fromJson(Map<String, dynamic> json) {
    enable = json['enable'] == null ? null : json['enable'] as bool;
    maxAge = json['maxAge'] == null ? null : json['maxAge'] as num;
    maxCount = json['maxCount'] == null ? null : json['maxCount'] as num;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'enable': enable,
    'maxAge': maxAge,
    'maxCount': maxCount,
  };

  NetCacheConfigSerializer from(NetCacheConfigSerializer instance) {
    enable = instance.enable;
    maxAge = instance.maxAge;
    maxCount = instance.maxCount;
    return this;
  }
}


