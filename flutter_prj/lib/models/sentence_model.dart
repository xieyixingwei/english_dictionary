import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter/cupertino.dart';

class SentenceModel extends ChangeNotifier {
  SentenceSerializer _sentence = SentenceSerializer();

  SentenceSerializer get sentence => _sentence;

  //用户信息发生变化，更新用户信息并通知依赖它的子孙Widgets更新
  set sentence(SentenceSerializer sentence) {
    _sentence = sentence;
    notifyListeners();
  }
}

Map<String, Object> blankSentence() {
  return {
            "tags":[],
            "tense": "",
            "form": [],
            "synonym": [],
            "antonym": [],
            "pattern": ["", ""],
          };
}
