import 'dart:developer';

import 'package:flutter/foundation.dart';

class ApiResult<T> {
  final ApiStatus status;
  final T response;

  ApiResult({required this.status, required this.response});
  T get getResponse => response;

  ApiStatus get getStatus => status;
}

enum ApiStatus { success, failed, unauthorized, forbid, badRequest, offline, serverIssue }

class ApiStatusCode {
  static int SUCCESS = 200;
}
