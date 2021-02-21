import 'package:json_annotation/json_annotation.dart';

part 'sentence.g.dart';

@JsonSerializable()
class Sentence {
    Sentence();

    num s_id = 0;
    String s_en = "hello";
    String s_ch = "你好";
    //s_word": models.JSONField() # 所属word ["word1:n.:1", "word2:v.:2"]
    num s_type = 0;
    List<String> s_tags = ["日常用语", "商务用语"];
    List<String> s_tense = ["一般过去式", "被动语态"];
    List<String> s_form = ["复合句", "问候语", "从句", "陈述句"];
    //s_synonym": models.JSONField(null=True) # 同义句 [Sentence.id,Sentence.id,...]
    //s_antonym": models.JSONField(null=True) # 反义句 [Sentence.id,Sentence.id,...]
    //s_grammar_id": models.JSONField() # 语法 [id1,id2,id3]
    
    factory Sentence.fromJson(Map<String,dynamic> json) => _$SentenceFromJson(json);
    Map<String, dynamic> toJson() => _$SentenceToJson(this);
}
