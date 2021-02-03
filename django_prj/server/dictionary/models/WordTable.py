from django.db import models


class WordTable(models.Model):
    """
    单词表
    """
    w_name = models.CharField(max_length=32, primary_key=True)     # 单词 (primary key)
    w_voice_us = models.CharField(max_length=32, null=True) # 音标 美国
    w_voice_uk = models.CharField(max_length=32, null=True) # 音标 英国
    w_morph = models.JSONField(null=True)                 # 单词变形
    w_tags = models.JSONField(null=True)                  # 标记 [情态动词,动物名词,蔬菜名词]
    w_etyma = models.JSONField(null=True)    # 词根词缀 [root1,root2,...]
    # w_synonym = models.JSONField(null=True)  # 近义词 [word1,word2,...]
    # w_antonym = models.JSONField(null=True)  # 反义词 [word1,word2,...]
    # w_distinguish_id = models.JSONField()     # 词义辨析id [id1,id2,...]
    # w_grammar_id = models.JSONField() # 语法id [id1,id2,...]
    w_origin = models.CharField(max_length=512, null=True) # 词源 markdown "1660年左右进入英语，直接源自中古拉丁语的coordinare，意为同一等级的。"
    w_shorthand = models.CharField(max_length=256, null=True) # 速记 markdown
    w_partofspeech = models.JSONField(max_length=256, null=True) # 词性 []
    w_sentence_pattern = models.JSONField(max_length=256, null=True) # 常用句型 []
    w_word_collocation = models.JSONField(max_length=256, null=True) # 词汇搭配 []
    #w_image = models.ImageField(null=True) # 图片讲解
    #w_vedio = models.FilePathField(max_length=128, null=True) # 视频讲解
    def _paraphrase(self) -> str:
        return '''
        "PartOfSpeech": [
            {   "type":"n.",
                "means":[
                    {   "content":"同等者， 同等物，同等的人物",
                        "examples":[1,2,3],
                    },
                ]
            },
        ]'''

# 单词变形 格式(json):
# {
# "v.ing": coordinating, # 分词 进行时
# "v.ed": coordinated,   # 过去式
# "v.edt": coordinated,  # 完成时
# "v.es": coordinates,   # 第三人称单数
# "n": coordinateness,   # 名词
# "adj": coordinative,   # 形容词
# "adv": coordinately,   # 副词
# }

# 单词释义 json
# 1. 词源: 1660年左右进入英语，直接源自中古拉丁语的coordinare，意为同一等级的。
# 2. 词性:
#     1. 名词(n.) 
#         1. 同等者， 同等物，同等的人物
#             - The filter is defined as a box of coordinates.
#               过滤器定义的是一个方框的坐标。
#         2. 同位
#     2. 动词(v.)
#         1. 协调，协调一致
#             - If we coordinate our efforts we should be able to win the game.
#               如果我们同心协力,我们应该能够打赢这场比赛。
#             - You must coordinate the movements of your arms and legs when swimming.
#               游泳时你必须使臂和腿的动作相协调。
#     3. 形容词(adj.)
#         1. 同等的，同位的， 等位的
# 3. 词汇搭配
#     1. 用作动词(v.)
#         - coordinate one's efforts 齐心协力
#         - coordinate closely       紧密配合
#
# 4. 常用句型
#     1. It is that ....
#        It is that very much.
