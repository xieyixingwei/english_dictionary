import 'package:flutter/cupertino.dart';
import 'package:flutter_prj/serializers/index.dart';

class WordModel extends ChangeNotifier {
  WordSerializer _word = WordSerializer();

  WordSerializer get word => _word;

  //用户信息发生变化，更新用户信息并通知依赖它的子孙Widgets更新
  set word(WordSerializer word) {
    _word = word;
    notifyListeners();
  }
}
