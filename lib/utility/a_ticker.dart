import 'dart:async';

import 'dart:ui';

class ATicker {
  Timer _timer;
  bool _running = false;

  void tick(int milliseconds, VoidCallback callback) {
    _timer?.cancel();
    _running = true;
    _timer = Timer.periodic(Duration(milliseconds: milliseconds), (timer) {
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
