import 'package:flutter/cupertino.dart';
import 'package:flutter_prj/serializers/index.dart';
import '../common/global.dart';


class LocalStoreChangeNotifier extends ChangeNotifier {
  LocalStoreSerializer get localStore => Global.localStore;

  @override
  void notifyListeners() {
    Global.saveLocalStore(); //保存变更
    super.notifyListeners(); //通知依赖的Widget更新
  }
}
