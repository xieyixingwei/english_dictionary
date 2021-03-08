import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter/cupertino.dart';

class SentencesModel extends ChangeNotifier {
  SentencePatternSerializer _sentences = SentencePatternSerializer();

  SentencePatternSerializer get sentences => _sentences;

  //用户信息发生变化，更新用户信息并通知依赖它的子孙Widgets更新
  set sentence(SentencePatternSerializer sentences) {
    _sentences = sentences;
    notifyListeners();
  }
}

