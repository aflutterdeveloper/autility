class ALog {
  static IALog _logger;
  static void init(IALog logger) {
    _logger = logger;
  }

  static void info(String tag, String msg) {
    if (_logger != null) {
      _logger.info(tag, msg);
    } else {
      print("info: $tag $msg");
    }
  }

  static void debug(String tag, String msg) {
    if (_logger != null) {
      _logger.debug(tag, msg);
    } else {
      print("debug: $tag $msg");
    }
  }

  static void warn(String tag, String msg) {
    if (_logger != null) {
      _logger.warn(tag, msg);
    } else {
      print("warn: $tag $msg");
    }
  }

  static void error(String tag, String msg) {
    if (_logger != null) {
      _logger.error(tag, msg);
    } else {
      print("error: $tag $msg");
    }
  }
}

abstract class IALog {
  void info(String tag, String msg);
  void debug(String tag, String msg);
  void warn(String tag, String msg);
  void error(String tag, String msg);
}
