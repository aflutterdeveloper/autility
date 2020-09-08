import 'package:flutter/services.dart';

class FullScreenRequire {
  static int _fullscreenRequireIndex = 0;

  static int require() {
     final index = ++_fullscreenRequireIndex;
     SystemChrome.setEnabledSystemUIOverlays([]);
     return index;
  }

  static bool release(int requireId) {
    if (_fullscreenRequireIndex == requireId) {
      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
      return true;
    }
    return false;
  }
}