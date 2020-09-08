import 'package:connectivity/connectivity.dart';

class NetUtil {
  static Future<bool> hasNetwork() async {
    bool flag = false;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      flag = false;
    } else {
      flag = true;
    }
    return flag;
  }

  static Future<ConnectivityResult> networkType() async {
    return await (Connectivity().checkConnectivity());
  }
}

