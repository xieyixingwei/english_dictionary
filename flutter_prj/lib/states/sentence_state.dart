import 'package:flutter_prj/models/sentence.dart';
import 'profile_change_notifier.dart';

class SentenceState extends ProfileChangeNotifier {
  Sentence _sentence = Sentence();

  Sentence get sentence => _sentence;

  //用户信息发生变化，更新用户信息并通知依赖它的子孙Widgets更新
  set sentence(Sentence sentence) {
    _sentence = sentence;
    notifyListeners();
  }
}
