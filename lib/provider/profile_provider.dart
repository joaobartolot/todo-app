import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

import 'package:flutter/cupertino.dart';

class ProfileProvider with ChangeNotifier {
  File _image;
  File get image => _image;
  set image(File value) {
    _image = value;
    notifyListeners();
  }

  bool _isEditing = false;
  bool get isEditing => _isEditing;
  set isEditing(bool value) {
    _isEditing = value;
    notifyListeners();
  }

  String _uploadedFileURL;
  String get uploadedFileURL => _uploadedFileURL;
  set uploadedFileURL(String value) {
    _uploadedFileURL = value;
    notifyListeners();
  }

  Future<void> saveChanges() async {
    isEditing = false;

    if (image != null) {
      await _saveImage();
    }

    _updateProfile();

    image = null;
  }

  Future _saveImage() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('profile/${Path.basename(image.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    uploadedFileURL = await storageReference.getDownloadURL();
  }

  Future _updateProfile() async {
    // TODO: add the name and email changes

    if (image == null) return;

    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    UserUpdateInfo profileUpdates = UserUpdateInfo();
    profileUpdates.photoUrl = uploadedFileURL;

    user.updateProfile(profileUpdates);
  }
}
