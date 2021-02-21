import '../models/index.dart';
import 'profile_change_notifier.dart';

class UserModel extends ProfileChangeNotifier {
  User get user => profile.user;
  bool get isLogin => user != null && user.u_uname != null;

  //用户信息发生变化，更新用户信息并通知依赖它的子孙Widgets更新
  set user(User user) {
    if (user?.u_uname != profile.user?.u_uname) {
      profile.lastLogin = profile.user?.u_uname;
      profile.user = user;
      notifyListeners();
    }
  }
}
