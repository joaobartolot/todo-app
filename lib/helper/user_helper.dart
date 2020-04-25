import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_firebase/util/constants.dart';

class UserHelper {
  static Future<String> getUserUid() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(Consts.uidKey);
  }

  static Future<void> setUserUid(String uid) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.setString(Consts.uidKey, uid);
  }

  static Future<bool> userIsLogged() async {
    var uid = await getUserUid();

    if (uid != "") {
      return true;
    }
    return false;
  }
}
