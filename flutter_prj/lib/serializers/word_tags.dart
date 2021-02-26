// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************



class WordTagsSerializer {
  WordTagsSerializer();

  String t_name = '';


  WordTagsSerializer fromJson(Map<String, dynamic> json) {
    t_name = json['t_name'] as String;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    't_name': t_name,
  };

}
