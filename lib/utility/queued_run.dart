import 'dart:collection';

import 'a_timer.dart';
import 'runnable.dart';

class QueuedRun {
  final int _maxActionCount;
  final int _duration;
  final ATimer _delayTimer = ATimer();
  final ListQueue<AVoidRunnable> _queue = ListQueue<AVoidRunnable>();
  bool _running = false;

  QueuedRun({int maxActionCount = 2, duration = 800})
      : _maxActionCount = maxActionCount,
        _duration = duration;

  void queue(AVoidRunnable runnable) {
    if (_queue.length >= _maxActionCount) {
      _queue.removeFirst();
      _queue.addLast(runnable);
    } else {
      _queue.addLast(runnable);
    }

    if (!_running) {
      _running = true;
      _action(runnable);
    }
  }

  void _run() async {
    if (_queue.isNotEmpty) {
      _queue.removeFirst();
      if (_queue.length > 0) {
        await _action(_queue.first);
        return;
      }
    }
    _running = false;
  }

  Future _action(AVoidRunnable runnable) async {
    await runnable().catchError((error) {});
    _delayTimer.delay(_duration, _run);
  }

  void cancel() {
    _queue.clear();
    _delayTimer.cancel();
  }
}
