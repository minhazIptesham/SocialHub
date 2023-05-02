import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_hub/utils/services/session_manager.dart';
import 'package:social_hub/utils/utility.dart';

class ProfileController with ChangeNotifier {
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('UserName');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final picker = ImagePicker();
  XFile? _image;
  XFile? get image => _image;

  //Loading method...
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  //function for gallery image...
  Future pickGalleryImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      notifyListeners();
      //uploadImage(context);
    }
  }

  //function for camera image...
  Future pickCameraImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      notifyListeners();
      // uploadImage(context);
    }
  }

  void pickImage(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 120,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      pickCameraImage(context);
                      Navigator.pop(context);
                    },
                    title: const Text('Camera'),
                    leading: const Icon(Icons.camera_alt),
                  ),
                  ListTile(
                    onTap: () {
                      pickGalleryImage(context);
                      Navigator.pop(context);
                    },
                    title: const Text('Gallery'),
                    leading: const Icon(Icons.image),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void uploadImage(BuildContext context) async {
    setLoading(true);
    firebase_storage.Reference reference = firebase_storage
        .FirebaseStorage.instance
        .ref('/profileImage${SessionController().userId}');
    firebase_storage.UploadTask uploadTask =
        reference.putFile(File(image!.path).absolute);
    await Future.value(uploadTask);
    final newUrl = await reference.getDownloadURL();
    ref
        .child(SessionController().userId.toString())
        .update({'image': newUrl.toString()}).then((value) {
      _image = null;
      setLoading(false);
      Utility.customSnackBar(
          context: context,
          contentType: ContentType.success,
          title: 'Upload Successful',
          massage: 'Profile picture has been updated'.toString());
    }).onError((error, stackTrace) {
      setLoading(false);
      Utility.customSnackBar(
          context: context,
          contentType: ContentType.warning,
          title: 'Upload failed',
          massage: error.toString());
    });
  }
}
