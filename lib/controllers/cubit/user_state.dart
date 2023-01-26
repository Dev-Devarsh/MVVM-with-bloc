part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class Loading extends UserState {}

class GetAllUsersSuccess extends UserState {
  final AllUserData data;
  GetAllUsersSuccess({required this.data});
}

class GetSingleUsersSuccess extends UserState {
  final SingleUserData data;
  GetSingleUsersSuccess({required this.data});
}

class GetAllUsersFailed extends UserState {}

class GetSingleUserFailed extends UserState {}
