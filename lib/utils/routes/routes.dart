import 'package:flutter/material.dart';
import 'package:social_hub/utils/routes/route_name.dart';
import 'package:social_hub/view/dashboard/dashboard_screen.dart';
import 'package:social_hub/view/forget%20password/forget_password_screen.dart';
import 'package:social_hub/view/signup/sign_up_screen.dart';
import 'package:social_hub/view/splash/splash_screen.dart';

import '../../view/login/login_screen.dart';

class Routes {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
        case RouteName.logInScreen:
        return MaterialPageRoute(builder: (_) => const LogInScreen());
        case RouteName.signUpScreen:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
        case RouteName.forgetPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
        case RouteName.dashBoard:
        return MaterialPageRoute(builder: (_) => const DashBoardScreen());


      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}