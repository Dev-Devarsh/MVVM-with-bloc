// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_task/data/screens/router/router.dart';
import 'package:flutter_task/data/screens/user_list_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration(seconds: 3), () {
        AppRouter.pushReplacement(context, UserList.route);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterLogo(
          curve: Curves.easeIn,
          duration: Duration(seconds: 3),
          size: 100,
        ),
      ),
    );
  }
}
