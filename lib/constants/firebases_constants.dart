// ignore_for_file: unused_element

import 'package:chatting_app/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseConstants {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore fireStore = FirebaseFirestore.instance;
  static User get user => auth.currentUser!;
  static late  userModel selfAccountInfo;

  //Firebase Storage 

  //for checking user exit or not
  static Future<bool> userExits() async {
    return (await fireStore.collection('users').doc(user.uid).get()).exists;
  }

  //for showing self Account
  static Future<void> selfAccountInformation() async {
    await fireStore.collection('users').doc(user.uid).get().then((value) async {
      if (value.exists) {
        print('Details: ${value.data()}');
        selfAccountInfo = userModel.fromJson(value.data()!);
      } else {
        await createUser().then((value) => selfAccountInformation());
      }
    });
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

  //for getting all users from firebase database

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return fireStore
        .collection('users')
        .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }

  //for updating Informations
  static Future<void> updateInformations() async {
    await fireStore.collection('users').doc(user.uid).update({
      'name': selfAccountInfo.name,
      'about': selfAccountInfo.about,
    });
  }
}
