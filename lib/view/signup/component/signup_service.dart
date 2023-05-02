import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:social_hub/utils/routes/route_name.dart';
import 'package:social_hub/utils/services/session_manager.dart';
import 'package:social_hub/utils/utility.dart';

class SignUpController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('UserName');
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void signUp(String username, String email, String password,
      BuildContext context) async {
    setLoading(true);
    try {
      auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        SessionController().userId = value.user!.uid.toString();
        ref.child(value.user!.uid.toString()).set({
          'uid': value.user!.uid.toString(),
          'email': value.user!.email.toString(),
          'onlineStatus': 'noOne',
          'phone': '',
          'userName': username,
          'profile': '',
          'image': '',
        }).then((value) {
          setLoading(false);
          Navigator.pushNamed(context, RouteName.dashBoard);
        }).onError((error, stackTrace) {
          setLoading(false);
          Utility.customSnackBar(
              context: context,
              contentType: ContentType.failure,
              title: 'Something Wrong',
              massage: error.toString());
        });
        // Utility.customSnackBar(
        //     context: context,
        //     contentType: ContentType.success,
        //     title: 'Account has been created',
        //     massage: value.toString());
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
