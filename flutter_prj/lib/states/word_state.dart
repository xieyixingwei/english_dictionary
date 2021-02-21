import 'package:flutter_prj/models/word.dart';
import 'profile_change_notifier.dart';

class WordState extends ProfileChangeNotifier {
  Word _word = Word();

  Word get word => _word;

  //用户信息发生变化，更新用户信息并通知依赖它的子孙Widgets更新
  set word(Word word) {
    _word = word;
    notifyListeners();
  }
}
