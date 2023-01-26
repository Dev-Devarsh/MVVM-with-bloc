import 'package:bloc/bloc.dart';
import 'package:flutter_task/data/models/failed_resp.dart';
import 'package:flutter_task/data/models/single_user_model.dart';
import 'package:flutter_task/data/network/network_status.dart';
import 'package:flutter_task/data/repositories/user_repo.dart';
import 'package:meta/meta.dart';

import '../../data/models/all_user_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;
  UserCubit({required this.userRepository}) : super(UserInitial());

  void getAllUserCubit() async {
    emit(Loading());
    ApiResult result =
        await userRepository.getAllUser();
    if (result.status == ApiStatus.success) {
      emit(GetAllUsersSuccess(data: result.response));
    }
    if (result.status == ApiStatus.failed) {
      emit(GetAllUsersFailed());
    }
  }

  void getSingleUserCubit({required int id}) async {
    emit(Loading());
    ApiResult result =
        await userRepository.getSingleUser(userId: id);
    if (result.status == ApiStatus.success) {
      emit(GetAllUsersSuccess(data: result.response));
    }
    if (result.status == ApiStatus.failed) {
      emit(GetAllUsersFailed());
    }
  }
}
