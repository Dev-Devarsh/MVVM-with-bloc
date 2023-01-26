import 'package:flutter_task/data/network/network_status.dart';
import 'package:flutter_task/data/network/user_api.dart';

class UserRepository {
  final UserApi userApi;
  const UserRepository(this.userApi);
  Future<ApiResult> getAllUser() async {
    ApiResult result = await userApi.callgetAllUsers();
    return result;
  }

  Future<ApiResult> getSingleUser({required int userId}) async {
    ApiResult result = await userApi.callgetSingleUser(userId: userId);
    return result;
  }
}
