// ignore_for_file: unused_element

import 'package:chatting_app/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseConstants {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore fireStore = FirebaseFirestore.instance;
  static User get user => auth.currentUser!;

  //for checking user exit or not
  static Future<bool> userExits() async {
    return (await fireStore.collection('users').doc(user.uid).get()).exists;
  }

  //for createing new user
  static Future<void> createUser() async {
    final chatUser = userModel(
      id: auth.currentUser!.uid,
      name: auth.currentUser!.displayName.toString(),
      email: auth.currentUser!.email.toString(),
      about: 'Hey,Welcome',
      image: auth.currentUser!.photoURL.toString(),
      isOnline: false,
      lastActive: DateTime.now().millisecondsSinceEpoch.toString(),
      push_Token: '',
    );
    return (await fireStore
        .collection('users')
        .doc(user.uid)
        .set(chatUser.toJson()));
  }
}
