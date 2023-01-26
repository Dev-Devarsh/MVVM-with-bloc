import 'package:flutter/material.dart';

class SingleUser extends StatefulWidget {
  static const String route = 'singleUser';
  final int intUserId;
  const SingleUser({required this.intUserId});

  @override
  State<SingleUser> createState() => _SingleUserState();
}

class _SingleUserState extends State<SingleUser> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
