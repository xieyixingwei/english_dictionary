// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************



class DistinguishSerializer {
  DistinguishSerializer();

  num id;
  List<String> words = [];
  String content = '';
  String image = '';
  String vedio = '';
  List<String> wordsForeign = [];
  


  DistinguishSerializer fromJson(Map<String, dynamic> json) {
    id = json['id'] == null ? null : json['id'] as num;
    words = json['words'] == null
                ? []
                : json['words'].map<String>((e) => e as String).toList();
    content = json['content'] == null ? null : json['content'] as String;
    image = json['image'] == null ? null : json['image'] as String;
    vedio = json['vedio'] == null ? null : json['vedio'] as String;
    wordsForeign = json['wordsForeign'] == null
                ? []
                : json['wordsForeign'].map<String>((e) => e as String).toList();
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'words': words == null ? null : words.map((e) => e).toList(),
    'content': content,
    'wordsForeign': wordsForeign == null ? null : wordsForeign.map((e) => e).toList(),
  };
}


