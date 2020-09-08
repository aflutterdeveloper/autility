import 'package:shared_preferences/shared_preferences.dart';

class SP {
  static SharedPreferences instance;
  static Future init() async {
    instance = await SharedPreferences.getInstance();
  }
}
