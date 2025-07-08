import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppLogger {
  static final AppLogger _instance = AppLogger._internal();
  factory AppLogger() => _instance;
  AppLogger._internal();

  // Logger instance with custom configuration
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0, // No stack trace for regular logs
      errorMethodCount: 5, // Show stack trace for errors
      lineLength: 80, // Output width
      colors: true, // Enable colors in console
      printEmojis: true, // ✅ Fixed typo here
      printTime: true, // Include timestamps
    ),
    level: kDebugMode ? Level.verbose : Level.info,
  );

  // Log methods with tag + message
  void verbose(String tag, String message) => _logger.v('$tag: $message');
  void debug(String tag, String message) => _logger.d('$tag: $message');
  void info(String tag, String message) => _logger.i('$tag: $message');
  void warning(String tag, String message) => _logger.w('$tag: $message');
  void error(String tag, String message, [dynamic? error, StackTrace? stackTrace]) =>
      _logger.e('$tag: $message', error: error, stackTrace: stackTrace);

}
