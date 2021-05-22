
from gtts import gTTS


def text_to_mp3(text:str, savePath:str, lang:str='en'):
    """
    lang: "zh-CN" 表示中文
    """
    tts = gTTS(text=(text), lang=lang)
    tts.save(savePath)


# text_to_mp3('你最近过得怎么样，还可以', './test.mp3', 'zh-tw')
