import 'dart:async';

import 'dart:ui';

class ATimer {
  Timer _timer;
  bool _running = false;

  void delay(int milliseconds, VoidCallback callback) {
    _timer?.cancel();
    _running = true;
    _timer = Timer(Duration(milliseconds: milliseconds), () {
      _running = false;
      _timer = null;
      callback();
    });
  }

  bool get running => _running;

  void cancel() {
    if (running) {
      _running = false;
      _timer?.cancel();
      _timer = null;
    }
  }
}
