import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/controllers/cubit/user_cubit.dart';

class SingleUser extends StatefulWidget {
  static const String route = 'singleUser';
  final int userId;
  const SingleUser({required this.userId});

  @override
  State<SingleUser> createState() => _SingleUserState();
}

class _SingleUserState extends State<SingleUser> {
  late UserCubit _userCubit;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _userCubit.getSingleUserCubit(id: widget.userId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _userCubit = BlocProvider.of<UserCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('User Data'),
        centerTitle: true,
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is GetSingleUsersSuccess) {
            return Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 200,
                  width: 200,
                  child: CachedNetworkImage(
                    imageUrl: state.data.data.avatar,
                    imageBuilder: ((context, imageProvider) {
                      return CircleAvatar(
                        foregroundImage: imageProvider,
                      );
                    }),
                  ),
                ),
                SizedBox(
                  height: 250,
                ),
                Column(children: [
                  RowProp(
                      header: 'First Name:', value: state.data.data.firstName),
                  RowProp(
                      header: 'Last Name:', value: state.data.data.lastName),
                  RowProp(header: 'Email Name:', value: state.data.data.email),
                ]),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          createUser(
                            email: state.data.data.email,
                            firstName: state.data.data.firstName,
                            lastName: state.data.data.lastName,
                            imageUrl: state.data.data.avatar,
                            id: state.data.data.id,
                          );
                        },
                        child: Text('Add data')),
                    ElevatedButton(onPressed: () {}, child: Text('Edit data')),
                    ElevatedButton(
                        onPressed: () {
                          deleteData(state.data.data.id);
                        },
                        child: Text('Delete data')),
                  ],
                )
              ],
            );
          }
          if (state is GetSingleUserFailed) {
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

class RowProp extends StatelessWidget {
  final String value;
  final String header;
  const RowProp({required this.value, required this.header});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          header,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
          ),
        )
      ],
    );
  }
}

Future<void> createUser(
    {required String firstName,
    required int id,
    required String lastName,
    required String email,
    required String imageUrl}) async {
  final docUser =
      FirebaseFirestore.instance.collection('test').doc(id.toString());
  final user = UserData(
      email: email,
      firstName: firstName,
      lastName: lastName,
      id: id,
      imageUrl: imageUrl);
  final json2 = user.toJson();
  await docUser.set(json2);
}

deleteData(int id) {
  FirebaseFirestore.instance.collection('test').doc(id.toString()).delete();
}

class UserData {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String imageUrl;
  UserData({
    required this.lastName,
    required this.firstName,
    required this.id,
    required this.email,
    required this.imageUrl,
  });
  toJson() => {
        'id': this.id,
        'firstName': this.firstName,
        'email': this.email,
        'imageUrl': this.imageUrl
      };

  static UserData fromJson(Map<String, dynamic> json) => UserData(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      imageUrl: json['imageUrl']);
}
