import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_hub/utils/routes/route_name.dart';
import 'package:social_hub/utils/services/session_manager.dart';

class SplashServices {
  void isLogIn(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      SessionController().userId = user.uid.toString();
      Timer(const Duration(seconds: 3),
          () => Navigator.pushNamed(context, RouteName.dashBoard));
    } else {
      Timer(const Duration(seconds: 3),
          () => Navigator.pushNamed(context, RouteName.logInScreen));
    }
  }
}
