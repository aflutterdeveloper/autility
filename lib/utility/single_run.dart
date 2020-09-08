import 'dart:async';

import 'runnable.dart';
class SingleRun<R> {
  List<Completer<R>> _completerList = List<Completer<R>>();

  Future<R> run<T>(ARunnable<T, R> runnable, [T param]) async {
    final completer = Completer<R>();
    if (_completerList.isNotEmpty) {
      _completerList.add(completer);
      return completer.future;
    } else {
      _completerList.add(completer);
    }

    try {
      final result = await runnable(param);
      _completerList.forEach((element) {
        element.complete(result);
      });
      _completerList.clear();
    } catch(e) {
      _completerList.forEach((element) {
        element.completeError(e);
      });
      _completerList.clear();
    }
    return completer.future;
  }

  void cancel() {
    _completerList.forEach((element) {
      element.completeError(Exception("canceled"));
    });
    _completerList.clear();
  }
}
