import 'package:json_annotation/json_annotation.dart';

part 'word_tags.g.dart';

@JsonSerializable()
class WordTags {
    WordTags();

    String t_name;
    
    factory WordTags.fromJson(Map<String,dynamic> json) => _$WordFromJson(json);
    Map<String, dynamic> toJson() => _$WordToJson(this);
}
