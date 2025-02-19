import 'package:logger/logger.dart';

class TLoggerHelper {
  static final logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 50,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
    level: Level.debug,
  );

  static void debug(String message) {
    logger.d(message);
  }

  static void info(String message) {
    logger.i(message);
  }

  static void warning(String message) {
    logger.w(message);
  }

  static void error(String message, [dynamic error]) {
    logger.e(message, error: error, stackTrace: StackTrace.current);
  }
}
