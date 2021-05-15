from django.db import models
from server.models  import JSONFieldUtf8
from ..download_word_voice import DownloadWordVoice
from server import settings
from django.core.files.base import ContentFile


class WordTable(models.Model):
    """
    单词表
    """
    name = models.CharField(max_length=32, primary_key=True)     # 单词 (primary key)
    voiceUs = models.CharField(max_length=32, null=True, blank=True) # 音标 美国
    voiceUk = models.CharField(max_length=32, null=True, blank=True) # 音标 英国
    audioUsMan = models.FileField(upload_to='word_audio/', null=True, blank=True, verbose_name="发音美男")
    audioUsWoman = models.FileField(upload_to='word_audio/', null=True, blank=True, verbose_name="发音美女")
    audioUkMan = models.FileField(upload_to='word_audio/', null=True, blank=True, verbose_name="发音英男")
    audioUkWoman = models.FileField(upload_to='word_audio/', null=True, blank=True, verbose_name="发音英女")
    morph = JSONFieldUtf8(null=True)                 # 单词形态
    tag = JSONFieldUtf8(null=True)                  # 标记 [情态动词,动物名词,蔬菜名词]
    etyma = JSONFieldUtf8(null=True)    # 词根词缀 [root1,root2,...]
    origin = models.CharField(max_length=512, null=True, blank=True) # 词源 markdown "1660年左右进入英语，直接源自中古拉丁语的coordinare，意为同一等级的。"
    shorthand = models.CharField(max_length=256, null=True, blank=True) # 速记 markdown
    synonym = models.ManyToManyField(to='self', blank=True) # 近义词 [word1,word2,...]
    antonym = models.ManyToManyField(to='self', blank=True) # 反义词 [word1,word2,...]
    image = models.ImageField(upload_to='word_images/', null=True, blank=True, verbose_name="图片讲解") # 图片讲解
    vedio = models.FileField(upload_to='word_videos/', null=True, blank=True, verbose_name="视频讲解") # 视频讲解
    class Meta:
        ordering = ['name']  # 消除list警告UnorderedObjectListWarning: Pagination may yield inconsistent results with an unordered object_list

    def save(self, *args, **kwargs):
        if self.audioUsMan.name == None\
            or self.audioUsMan.name == ''\
            or self.audioUsWoman.name == ''\
            or self.audioUkMan.name == ''\
            or self.audioUkWoman.name == '':
            for name, data in DownloadWordVoice(settings.MEDIA_ROOT).download(str(self.name)):
                fileContent = ContentFile(data)
                if 'us_man' in name and self.audioUsMan.name == None:
                    pathName = self.audioUsMan.field.upload_to+name
                    self.audioUsMan.name = pathName
                    self.audioUsMan.storage.save(pathName, fileContent)
                elif 'us_woman' in name and self.audioUsWoman.name == None:
                    pathName = self.audioUsWoman.field.upload_to+name
                    self.audioUsWoman.name = pathName
                    self.audioUsWoman.storage.save(pathName, fileContent)
                elif 'uk_man' in name and self.audioUkMan.name == None:
                    pathName = self.audioUkMan.field.upload_to+name
                    self.audioUkMan.name = pathName
                    self.audioUkMan.storage.save(pathName, fileContent)
                elif 'uk_woman' in name and self.audioUkWoman.name == None:
                    pathName = self.audioUkWoman.field.upload_to+name
                    self.audioUkWoman.name = pathName
                    self.audioUkWoman.storage.save(pathName, fileContent)
        super().save(*args, **kwargs)

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


class SentencePatternTable(models.Model):
    """
    常用句型表
    """
    id = models.AutoField(primary_key=True)
    content = models.CharField(max_length=64)  # 内容
    wordForeign = models.ForeignKey(to=WordTable, related_name='sentencePatternSet', null=True, on_delete=models.CASCADE)
    class Meta:
        ordering = ['id']

class ParaphraseTable(models.Model):
    """
    释义表
    """
    id = models.AutoField(primary_key=True)
    interpret = models.CharField(max_length=128)     # 翻译\含义
    partOfSpeech = models.CharField(max_length=32)   # 词性
    wordForeign = models.ForeignKey(to=WordTable, null=True, related_name='paraphraseSet', on_delete=models.CASCADE)
    sentencePatternForeign = models.ForeignKey(to=SentencePatternTable, null=True, related_name='paraphraseSet', on_delete=models.CASCADE)
    class Meta:
        ordering = ['id'] 

class EtymaTable(models.Model):
    """
    词根词缀表
    """
    name = models.CharField(max_length=32, primary_key=True) # 词根 (primary key)
    interpretation = models.TextField(max_length=512, null=True) # 含义 markdown
    type = models.IntegerField(null=True) # 类型: 前缀|后缀|词根
    image = models.ImageField(upload_to='etyma_images/', null=True, blank=True, verbose_name="图片讲解") # 图片讲解
    vedio = models.FileField(upload_to='etyma_videos/', null=True, blank=True, verbose_name="视频内容") # 视频讲解

    class Meta:
        ordering = ['name']  # 消除list警告UnorderedObjectListWarning: Pagination may yield inconsistent results with an unordered object_list

    @property
    def _type(self) -> str:
        if self.type == 0:
            return "prefix"
        elif self.type == 1:
            return "suffix"
        elif self.type == 2:
            return "etyma"
        else:
            return "unkown"


class WordTagTable(models.Model):
    """
    单词 Tags
    """
    name = models.CharField(max_length=32, primary_key=True)


class DistinguishWordTable(models.Model):
    """
    词义辨析表
    """
    id = models.AutoField(primary_key=True)
    content = models.TextField(null=True, blank=True) # 内容 markdown文本
    image = models.ImageField(upload_to='distinguish_word_images/', null=True, blank=True, verbose_name="图片讲解") # 图片讲解
    vedio = models.FileField(upload_to='distinguish_word_videos/', null=True, blank=True, verbose_name="视频讲解") # 视频讲解
    wordsForeign = models.ManyToManyField(to=WordTable, related_name='distinguishSet', blank=True)
    class Meta:
        ordering = ['id'] 
