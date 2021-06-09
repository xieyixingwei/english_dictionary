import urllib3
from bs4 import BeautifulSoup
from pathlib import PosixPath
from typing import Generator
from pathlib import Path
from typing import Union

class DownloadWord:
    """
    下载单词发音
    """
    url = 'http://dict.cn/'
    audioUrl = 'http://audio.dict.cn/'

    def __init__(self, savePath: Union[str, Path], word:str):
        if isinstance(savePath, str):
            self.savePath = savePath
        elif isinstance(savePath, PosixPath):
            self.savePath = savePath.as_posix()

        if self.savePath[-1] != '/':
            self.savePath += '/'

        self.http = urllib3.PoolManager()
        self.word = word
        self.response = self.http.request('GET', self.url + word)
        self.soup = BeautifulSoup(self.response.data.decode('utf-8'), features="html.parser")

    def sounds(self) -> Generator:
        sounds = self.soup.findAll(name="i", attrs={"class" :"sound"})
        for s in sounds:
            fileName, src = self._get_filename_url(s, self.word)
            res = self.http.request('GET', src)
            if res.status != 200:
                continue
            yield fileName, res.data

    def voice(self, type:str) -> str:
        """
        type: '美' or '英'
        """
        voices = self.soup.findAll(name="bdo", attrs={"lang" :"EN-US"})
        for v in voices:
            parent = v.findParent()
            if type in parent.text:
                return v.text
        return ''

    def _get_filename_url(self, s, word:str):
        name = word
        parent = s.findParent()
        if '英' in parent.text:
            name += '_uk'
        elif '美' in parent.text:
            name += '_us'
        titleAttr = s.attrs['title']
        if '男' in titleAttr:
            name += '_man'
        elif '女' in titleAttr:
            name += '_woman'
        return name + '.mp3', self.audioUrl + s.attrs['naudio']


#a = DownloadWord('./', 'presume').voice('英')
#print(a)
