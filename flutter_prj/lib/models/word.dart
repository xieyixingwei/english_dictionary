import 'package:json_annotation/json_annotation.dart';

part 'word.g.dart';

@JsonSerializable()
class Word {
    Word();

    String w_name = "";
    String w_voice_us = "";
    String w_voice_uk = "";
    List<String> w_morph = [];
    List<String> w_tags = [];
    List<String> w_etyma = [];
    //# w_synonym: models.JSONField(null=True)  # 近义词 [word1,word2,...]
    //# w_antonym: models.JSONField(null=True)  # 反义词 [word1,word2,...]
    //# w_distinguish_id: models.JSONField()     # 词义辨析id [id1,id2,...]
    //# w_grammar_id: models.JSONField() # 语法id [id1,id2,...]
    String w_origin = "";
    String w_shorthand = "";
    List<Map> w_partofspeech = [ // 词性
      {
        "type": "n.",
        "items": [
          {
            "type": "移动",
            "sentences": [
              {
                "tags":["问候语"],
                "tense": "过去时",
                "form": ["被动语态"],
                "synonym": [1,2],
                "antonym": [3,5],
                "pattern": ["The object is no longer in motion", "该物体已不处於运动状态"],
              }
            ]
          },
          {
            "type": "同位",
            "sentences": []
          },
        ],
      },
      {
        "type": "动词(v.)",
        "items": [
          {
            "type": "协调，协调一致",
            "sentences": [
              {
                "tags":["问候语"],
                "tense": "过去时",
                "form": ["被动语态"],
                "synonym": [1,2],
                "antonym": [3,5],
                "pattern": ["If we coordinate our efforts we should be able to win the game.", "如果我们同心协力,我们应该能够打赢这场比赛。"],
              },
              {
                "tags":["问候语"],
                "tense": "过去时",
                "form": ["被动语态"],
                "synonym": [1,2],
                "antonym": [3,5],
                "pattern": ["You must coordinate the movements of your arms and legs when swimming.", "游泳时你必须使臂和腿的动作相协调。"],
              },
            ]
          },
        ],
      },
    ]; 
    List<Map> w_sentence_pattern = [ // 常用句型
      {
        "type": "It is that ...",
        "sentences": [
          {
            "tags":["日常用语", "商务用语"],
            "tense": "一般现在时",
            "form": ["复合句","问候语","从句","陈述句"],
            "synonym": [1,2],
            "antonym": [3,5],
            "pattern": ["thank you", "谢谢你"],
          }
        ],
      },
      {
        "type": "That's why ...",
        "sentences": [
          {
            "tags":["问候语"],
            "tense": "过去时",
            "form": ["被动语态"],
            "synonym": [1,2],
            "antonym": [3,5],
            "pattern": ["That's why I thank you", "为什么"],
          }
        ],
      },
    ];
    List<Map> w_word_collocation = [ // 词汇搭配
      {
        "type": "用作动词(v.)",
        "sentences": [
          {
           "pattern": ["coordinate one's efforts", "齐心协力"],
          },
          {
           "pattern": ["coordinate closely", "紧密配合"],
          }
        ],
      },
    ];
    
    factory Word.fromJson(Map<String,dynamic> json) => _$WordFromJson(json);
    Map<String, dynamic> toJson() => _$WordToJson(this);
}
