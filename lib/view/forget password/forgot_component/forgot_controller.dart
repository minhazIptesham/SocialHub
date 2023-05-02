import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_hub/utils/routes/route_name.dart';
import 'package:social_hub/utils/utility.dart';

class ForgotController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void forgotPassword(String email,BuildContext context) async {
    setLoading(true);
    try {
      auth
          .sendPasswordResetEmail(email: email)
          .then((value) {
            setLoading(false);
        Navigator.pushNamed(context, RouteName.logInScreen);
        Utility.customSnackBar(
            context: context,
            contentType: ContentType.warning,
            title: 'Forgot password',massage:'Please check your email to recover your password' );
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
