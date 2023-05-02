import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_hub/utils/routes/route_name.dart';
import 'package:social_hub/utils/services/session_manager.dart';
import 'package:social_hub/utils/utility.dart';

class LogInController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void logIn(String email, String password, BuildContext context) async {
    setLoading(true);
    try {
      auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        setLoading(false);
        SessionController().userId = value.user!.uid.toString();
        Navigator.pushNamed(context, RouteName.dashBoard);
        Utility.customSnackBar(
            context: context,
            contentType: ContentType.success,
            title: 'Log In Successful',
            massage: value.toString());
      }).onError((error, stackTrace) {
        setLoading(false);
        Utility.customSnackBar(
            context: context,
            contentType: ContentType.failure,
            title: 'Something Wrong',
            massage: error.toString());
      });
    } catch (error) {
      setLoading(false);
      Utility.customSnackBar(
          context: context,
          contentType: ContentType.failure,
          title: 'Something Wrong',
          massage: error.toString());
    }
  }
}
