import 'dart:io';

import 'package:flutter_task/data/models/all_user_model.dart';
import 'package:flutter_task/data/models/failed_resp.dart';
import 'package:flutter_task/data/models/single_user_model.dart';
import 'package:flutter_task/data/network/network_status.dart';
import 'package:http/http.dart' as http;

class UserApi {
  Future<ApiResult> callgetAllUsers() async {
    try {
      http.Response response =
          await http.get(Uri.parse('https://reqres.in/api/users?page=2'));

      final statusCode = response.statusCode;
      if (statusCode == ApiStatusCode.SUCCESS) {
        return ApiResult(
            status: ApiStatus.success,
            response: allUserDataFromJson(response.body));
      } else {
        return ApiResult<FailedResponse>(
            status: ApiStatus.failed,
            response: FailedResponse(
                message: 'Something went wrong Please try again'));
      }
    } on SocketException {
      return ApiResult(
        status: ApiStatus.offline,
        response:
            FailedResponse(message: 'Please check your internet connection'),
      );
    } on Exception catch (_) {
      return ApiResult(
        status: ApiStatus.failed,
        response:
            FailedResponse(message: 'Something went wrong Please try again'),
      );
    }
  }

  Future<ApiResult> callgetSingleUser({required int userId}) async {
    try {
      http.Response response =
          await http.get(Uri.parse('https://reqres.in/api/users/$userId'));

      final statusCode = response.statusCode;
      if (statusCode == ApiStatusCode.SUCCESS) {
        return ApiResult(
            status: ApiStatus.success,
            response: singleUserDataFromJson(response.body));
      } else {
        return ApiResult<FailedResponse>(
            status: ApiStatus.failed,
            response: FailedResponse(
                message: 'Something went wrong Please try again'));
      }
    } on SocketException {
      return ApiResult(
        status: ApiStatus.offline,
        response:
            FailedResponse(message: 'Please check your internet connection'),
      );
    } on Exception catch (_) {
      return ApiResult(
        status: ApiStatus.failed,
        response:
            FailedResponse(message: 'Something went wrong Please try again'),
      );
    }
  }
}
