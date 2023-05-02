import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class Utility {
  static void fieldFocus(
      BuildContext context, FocusNode currentNode, FocusNode nextFocus) {
    currentNode.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static void customSnackBar({
    required BuildContext context,
    required ContentType contentType,
    required String title,
    required String massage,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        content: AwesomeSnackbarContent(
          title: title,
          message: massage,
          contentType: contentType,
          inMaterialBanner: true,
        )));
  }
}
