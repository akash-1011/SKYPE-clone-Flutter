import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:skype_clone/provider/image_upload_provider.dart';
import 'package:skype_clone/resources/chat_methods.dart';

class StorageMethods {
  static final Firestore firestore = Firestore.instance;
  StorageReference _storageReference;

  Future<String> uploadImageToStorage(File image) async {
    try {
      _storageReference = FirebaseStorage.instance
          .ref()
          .child('${DateTime.now().millisecondsSinceEpoch}');
      StorageUploadTask _storageUploadTask = _storageReference.putFile(image);
      var url =
          await (await _storageUploadTask.onComplete).ref.getDownloadURL();
      return url;
    } catch (e) {
      print('error was! $e');
      return null;
    }
  }

  void uploadImage({
    @required File image,
    @required String receiverId,
    @required String senderId,
    @required ImageUploadProvider imageUploadProvider,
  }) async {
    final ChatMethods chatMethods = ChatMethods();

    // Set some loading value to db and show it to user
    imageUploadProvider.setToLoading();

    // Get url from the image bucket
    String url = await uploadImageToStorage(image);

    // Hide loading
    imageUploadProvider.setToIdel();
    chatMethods.setImageMsg(url, receiverId, senderId);
  }
}
