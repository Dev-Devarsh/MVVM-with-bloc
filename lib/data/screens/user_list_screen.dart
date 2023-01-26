import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/controllers/cubit/user_cubit.dart';
import 'package:flutter_task/data/screens/widgets/user_tiles.dart';

class UserList extends StatefulWidget {
  static const String route = '/userList';
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  late UserCubit _userCubit;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _userCubit.getAllUserCubit();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _userCubit = BlocProvider.of<UserCubit>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("User List")),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is GetAllUsersSuccess) {
            return UserInfo(
              userData: state.data,
            );
          }
          if (state is GetAllUsersFailed) {
            return const Center(
                child: Text(
              'Something went wrong please try again',
              style: TextStyle(fontSize: 25),
            ));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
