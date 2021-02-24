import 'package:flutter_prj/models/local_store_notifier.dart';
import 'package:flutter_prj/serializers/index.dart';


class UserModel extends LocalStoreChangeNotifier {
  UserSerializer get user => localStore.user;
  bool get isLogin => user != null && user.u_uname != "";

  //用户信息发生变化，更新用户信息并通知依赖它的子孙Widgets更新
  set user(UserSerializer user) {
    if (user?.u_uname != localStore.user?.u_uname) {
      localStore.user = user;
      notifyListeners();
    }
  }
}
