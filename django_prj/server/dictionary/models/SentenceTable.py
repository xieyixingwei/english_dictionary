from django.db import models
from server.models  import JSONFieldUtf8
from dictionary.models import ParaphraseTable

class SentenceTable(models.Model):
    """
    句子表
    """
    id = models.AutoField(primary_key=True)
    en = models.CharField(max_length=512) # 英文
    cn = models.CharField(max_length=512, null=True) # 中文
    type = models.IntegerField(default=0)  # sentence|phrase|词汇搭配
    tag = JSONFieldUtf8(null=True)    # 标记 [日常用语,商务用语]
    tense = models.CharField(max_length=32, null=True, blank=True)   # 时态 [一般过去式,被动语态]
    pattern = JSONFieldUtf8(null=True)    # 句型 [复合句,问候语,从句,陈述句]
    synonym = models.ManyToManyField(to='self', blank=True) # 同义句 [Sentence.id,Sentence.id,...]
    antonym = models.ManyToManyField(to='self', blank=True) # 反义句 [Sentence.id,Sentence.id,...]
    paraphraseForeign = models.ForeignKey(to=ParaphraseTable, related_name='sentenceSet', null=True, on_delete=models.CASCADE)
    next = models.IntegerField(null=True) # 下个句子id
    class Meta:
        ordering = ['id']  # 消除list警告UnorderedObjectListWarning: Pagination may yield inconsistent results with an unordered object_list

    @property
    def _type(self) -> str:
        if self.type == 0:
            return "sentence"
        elif self.type == 1:
            return "phrase"
        else:
            return "unkown"


class SentenceTagTable(models.Model):
    """
    句子 Tags
    """
    name = models.CharField(max_length=32, primary_key=True)
