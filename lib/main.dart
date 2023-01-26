import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/controllers/cubit/user_cubit.dart';
import 'package:flutter_task/data/network/user_api.dart';
import 'package:flutter_task/data/repositories/user_repo.dart';
import 'package:flutter_task/data/screens/router/router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (context) => UserCubit(userRepository: UserRepository(UserApi())),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Task',
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 34, 225, 82),
        ),
        initialRoute: '/',
        onGenerateRoute: AppRouter().onRouteGenerate,
      ),
    );
  }
}
