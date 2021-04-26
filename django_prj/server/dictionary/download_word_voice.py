import urllib3
from bs4 import BeautifulSoup
from pathlib import PosixPath
from typing import Generator


class DownloadWordVoice:
    """
    下载单词发音
    """
    url = 'http://dict.cn/'
    audioUrl = 'http://audio.dict.cn/'

    def __init__(self, savePath:str):
        if isinstance(savePath, str):
            self.savePath = savePath
        elif isinstance(savePath, PosixPath):
            self.savePath = savePath.as_posix()

        if self.savePath[-1] != '/':
            self.savePath += '/'

        self.http = urllib3.PoolManager()

    def download(self, word:str) -> Generator:
        res = self.http.request('GET', self.url + word)
        soup = BeautifulSoup(res.data.decode('utf-8'), features="html.parser")
        sounds = soup.findAll(name="i", attrs={"class" :"sound"})
        #names = []
        for s in sounds:
            fileName, src = self._fileNameAndUrl(s, word)
            res = self.http.request('GET', src)
            if res.status != 200:
                continue
            yield fileName, res.data
            #with open(self.savePath + fileName, "wb") as f:
            #    f.write(res.data)
            #    f.close()
            #names.append(fileName)
        #return names

    def _fileNameAndUrl(self, s, word:str):
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


#a = DownloadWordVoice('./').download('dense')
#print(a)
