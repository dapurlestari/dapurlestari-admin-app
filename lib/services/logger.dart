import 'dart:developer';

import 'package:flutter/foundation.dart';

void logInfo(dynamic message, {String logLabel = 'LOG'}) {
  if (kDebugMode) log('$message', name: '${logLabel.toUpperCase()}_INFO');
}

void logWarning(dynamic message, {String logLabel = 'LOG'}) {
  if (kDebugMode) log('$message', name: '${logLabel.toUpperCase()}_WARNING');
}

void logError(dynamic message, {String logLabel = 'LOG'}) {
  if (kDebugMode) log('$message', name: '${logLabel.toUpperCase()}_ERROR', error: message);
}