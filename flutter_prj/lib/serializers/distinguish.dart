// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************



class DistinguishSerializer {
  DistinguishSerializer();

  num d_id = -1;
  List<String> d_words = [];
  String d_content = '';
  


  DistinguishSerializer fromJson(Map<String, dynamic> json) {
    d_id = json['d_id'] == null ? null : json['d_id'] as num;
    d_words = json['d_words'] == null
                ? []
                : json['d_words'].map<String>((e) => e as String).toList();
    d_content = json['d_content'] == null ? null : json['d_content'] as String;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'd_id': d_id,
    'd_words': d_words == null ? null : d_words.map((e) => e).toList(),
    'd_content': d_content,
  };
}


