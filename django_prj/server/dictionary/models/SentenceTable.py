from django.db import models
from server.models  import JSONFieldUtf8

class SentenceTable(models.Model):
    """
    句子表
    """
    s_id = models.AutoField(primary_key=True)
    s_en = models.CharField(max_length=512) # 英文
    s_ch = models.CharField(max_length=512, null=True) # 中文
    # s_word = models.JSONField() # 所属word ["word1:n.:1", "word2:v.:2"]
    s_type = models.IntegerField(default=0)  # sentence|phrase
    s_tags = JSONFieldUtf8(null=True)    # 标记 [日常用语,商务用语]
    s_tense = JSONFieldUtf8(null=True)   # 时态 [一般过去式,被动语态]
    s_form = JSONFieldUtf8(null=True)    # 句型 [复合句,问候语,从句,陈述句]
    s_synonym = models.ManyToManyField(to='self', blank=True) # 同义句 [Sentence.id,Sentence.id,...]
    s_antonym = models.ManyToManyField(to='self', blank=True) # 反义句 [Sentence.id,Sentence.id,...]
    # s_grammar_id = models.JSONField() # 语法 [id1,id2,id3]
    def type(self) -> str:
        if self.s_type == 0:
            return "sentence"
        elif self.s_type == 1:
            return "phrase"
        else:
            return "unkown"


class SentenceTagsTable(models.Model):
    """
    句子 Tags
    """
    t_name = models.CharField(max_length=32, primary_key=True)
