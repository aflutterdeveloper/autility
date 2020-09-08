import 'dart:async';

import 'runnable.dart';

class ConcurrencyRun {
  List<Completer> _completerList;

  Future run(List<AVoidRunnable> runnableList) async {
    if (runnableList?.isNotEmpty != true) {
      return;
    }

    _completerList = runnableList.map((e) => Completer()).toList();
    for (int i = 0; i < runnableList.length; ++i) {
      runnableList[i]().then((value) {
        _completeRun(i);
      }).catchError((err) {
        _completeRun(i);
      });
    }

    final completeList = _completerList;
    if (null != completeList) {
      for (int i = 0; i < completeList.length; ++i) {
        await completeList[i].future;
      }
    }
    _completerList = null;
  }

  void _completeRun(int index) {
    final completeList = _completerList;
    if (null != completeList) {
      if (completeList.length > index && !completeList[index].isCompleted) {
        completeList[index].complete();
      }
    }
  }

  bool get running {
    return _completerList?.any((element) => !element.isCompleted) != true;
  }

  void cancel() {
    if (null == _completerList) {
      return;
    }
    final completeList = _completerList;
    _completerList = null;

    completeList.forEach((element) {
      element.completeError(Exception("canceled"));
    });
  }
}
