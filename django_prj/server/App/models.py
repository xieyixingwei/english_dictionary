from django.db import models

# 单词表
class Word(models.Model):
    # 单词 (primary key)
    w_name = models.CharField(max_length=32)
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
    w_form = models.CharField()
    # 音标 美国
    w_voice_us = models.CharField(max_length=48)
    # 音标 英国
    w_voice_uk = models.CharField(max_length=48)
    # 标记 格式:情态动词,动物名词,蔬菜名词
    w_tag = models.CharField(max_length=200)
    # 词根 格式: root1,root2,...
    w_etyma = models.CharField(max_length=64)
    # 近义词 格式: word1,word2,...
    w_synonym = models.CharField(max_length=320)
    # 反义词 格式: word1,word2,...
    w_antonym = models.CharField(max_length=320)
    # 词义辨析 
    w_distinguish = models.IntegerField()
    # 释义 markdown文本
    w_paraphrase = models.CharField()

# 词根表
class Etyma(models.Model):
    # 词根 (primary key)
    e_name = models.CharField(max_length=32)
    # 含义
    e_meaning =  models.CharField()
    # 类型 前缀|后缀|词根
    e_type = models.IntegerField()

# 词义辨析表
class Distinguish(models.Model):
    # 单词列表 格式: word1,word2,...
    d_words = models.CharField(max_length=320)
    # 内容 markdown文本
    d_content = models.CharField()

# 句子表
class Sentence(models.Model):
    # 英文
    s_en = models.CharField()
    # 中文
    s_ch = models.CharField()
    # 同义句 格式: Sentence.id,Sentence.id,...
    s_synonym = models.CharField()
    # 反义句
    s_antonym = models.CharField()
    # 标记 格式: 日常用语,商务用语,问候语,一般过去式,被动语态
    s_tag = models.CharField()

# 用户表
class User(models.Model):
    # 姓名
    u_name = models.CharField(max_length=64)
    # 密码
    u_passwd = models.CharField(max_length=64)
    # 性别
    u_gender = models.BooleanField()
    # 生日
    u_birthday = models.DateTimeField()
    # 学历
    u_education = models.IntegerField()
    # 注册时间
    u_register_date = models.DateTimeField()
    # 微信号
    u_wechart = models.CharField(max_length=64)
    # QQ号
    u_qq = models.CharField(max_length=64)
    # email
    u_email = models.CharField(max_length=64)
    # 电话
    u_telephone = models.CharField(max_length=16)
    # 状态码
    u_status = models.IntegerField()
    # Study表ID
    u_study = models.IntegerField()

# 学习表
class Study(models.Model):
    # 单词列表 格式(json):
    # [
    #     {
    #        word: string
    #        in_plan: bool(0|1)
    #        familiarity: int(0~5)
    #        repeats: int
    #        learn_time: [09122030,09112030,09102030,09092030,09082030,09072030,09062030]
    #        comments: markdown text
    #     },
    # ]
    st_words = models.CharField()
    # 句子列表 格式(json):
    # [
    #    {
    #       sentence_id: int
    #       in_plan: bool(0|1)
    #       familiarity: int(0~5)
    #       repeats: int
    #       learn_time: [09122030,09112030,09102030,09092030,09082030,09072030,09062030]
    #       new_words: [word1, word2]
    #       comments: markdown text
    #       
    #    },
    # ]
    st_sentences = models.CharField()
    # 学习计划 格式(json):
    # [
    #     {
    #        words_oneday: int
    #        sentences_oneday: int
    #        other_settings: string
    #     },
    # ]
    st_plan = models.CharField()

# 管理表
class Management(models.Model):
    # 根用户,只有一个
    root_user = User.id
    # 管理员用户,格式: name1,name2,...
    admin_users = models.CharField()
