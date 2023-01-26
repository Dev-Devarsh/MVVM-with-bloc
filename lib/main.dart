import 'package:flutter/material.dart';
import 'package:flutter_task/controllers/cubit/user_cubit.dart';
import 'package:flutter_task/data/screens/router/router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (context) => UserCubit(),
      child: MaterialApp(
        title: 'Flutter Task',
        theme: ThemeData(
          primaryColor: Color.fromARGB(255, 34, 225, 82),
        ),
        initialRoute: '/',
        onGenerateRoute: AppRouter().onRouteGenerate,
      ),
    );
  }
}
