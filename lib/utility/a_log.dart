class ALog {
  static IALog _logger;
  void init(IALog logger) {
    _logger = logger;
  }

  static void info(String tag, String msg) {
    _logger?.info(tag, msg);
  }

  static void debug(String tag, String msg) {
    _logger?.debug(tag, msg);
  }

  static void warn(String tag, String msg) {
    _logger?.warn(tag, msg);
  }

  static void error(String tag, String msg) {
    _logger?.error(tag, msg);
  }
}

abstract class IALog {
  void info(String tag, String msg);
  void debug(String tag, String msg);
  void warn(String tag, String msg);
  void error(String tag, String msg);
}
