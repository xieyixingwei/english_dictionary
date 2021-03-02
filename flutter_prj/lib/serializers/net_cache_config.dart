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
    enable = json['enable'] as bool;
    maxAge = json['maxAge'] as num;
    maxCount = json['maxCount'] as num;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'enable': enable,
    'maxAge': maxAge,
    'maxCount': maxCount,
  };
}


