import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/controllers/cubit/user_cubit.dart';
import 'package:flutter_task/data/models/all_user_model.dart';
import 'package:flutter_task/data/screens/router/router.dart';
import 'package:flutter_task/data/screens/single_user.dart';

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
            List<Datum> data = state.data.data;
            return ListView.separated(
              itemCount: data.length,
              separatorBuilder: (context, index) => const SizedBox(
                height: 20,
              ),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: InkWell(
                    onTap: () {
                      showProfile(data[index].avatar);
                    },
                    child: CachedNetworkImage(
                      height: 50,
                      width: 50,
                      imageUrl: data[index].avatar,
                      imageBuilder: ((context, imageProvider) {
                        return CircleAvatar(
                          foregroundImage: imageProvider,
                        );
                      }),
                    ),
                  ),
                  title: InkWell(
                    onTap: () {
                      AppRouter.goToNextPage(context, SingleUser.route,
                              arguments: {'userId': data[index].id})
                          .then((value) => _userCubit.getAllUserCubit());
                    },
                    child: Row(
                      children: [
                        Text(
                          data[index].firstName,
                          style: TextStyle(fontSize: 23),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          data[index].lastName,
                          style: TextStyle(fontSize: 23),
                        ),
                      ],
                    ),
                  ),
                  subtitle: Text(
                    data[index].email,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                );
              },
            );
            ;
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

  showProfile(String url) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return Container(
          height: 60,
          width: 60,
          child: CachedNetworkImage(
            height: 60,
            width: 60,
            imageUrl: url,
          ),
        );
      },
    );
  }
}
