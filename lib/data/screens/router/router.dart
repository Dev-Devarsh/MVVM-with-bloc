import 'package:flutter/material.dart';
import 'package:flutter_task/data/screens/single_user.dart';
import 'package:flutter_task/data/screens/splash_screen.dart';
import 'package:flutter_task/data/screens/user_list_screen.dart';

class AppRouter {
  Route onRouteGenerate(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(settings: settings, builder: (_) => const SplashScreen());
        case UserList.route:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const UserList());
        case SingleUser.route:
           Map argument = settings.arguments as Map;
        return MaterialPageRoute(
            settings: settings, builder: (_) => SingleUser(intUserId: argument["jobId"]));
      default:
        return MaterialPageRoute(settings: settings, builder: (_) => const SplashScreen());
    }
  }

  static Future goToNextPage(BuildContext context, String s, {required Map arguments}) async {
    return await Navigator.pushNamed(context, s, arguments: arguments);
  }

  static pushAndRemoveUntil(BuildContext context, String routeName) {
    Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
  }

  static pushReplacement(BuildContext context, String routeName, {required Map arguments}) {
    // Navigator.of(context).pop();
    Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
  }

  static pop(BuildContext context, {dynamic result}) {
    Navigator.pop(context, result);
  }

  static popUntil(BuildContext context, String routeName) {
    Navigator.popUntil(
      context,
      (route) {
        return route.settings.name == routeName;
      },
    );
  }
}
