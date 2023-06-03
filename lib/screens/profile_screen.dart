// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable, use_build_context_synchronously, unused_import
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatting_app/auth/login_screen.dart';
import 'package:chatting_app/constants/firebases_constants.dart';
import 'package:chatting_app/functions/utils.dart';
import 'package:chatting_app/screens/home_screen.dart';
import 'package:chatting_app/widgets/click_button.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:chatting_app/models/userModel.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatefulWidget {
  final userModel user;
  const ProfileScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _image;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final aboutController = TextEditingController();

  //SignOut-----------------------
  _signOUT() async {
    await FirebaseConstants.auth.signOut();
    await GoogleSignIn().signOut().then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ));
    });
  }

  //Bottom sheet for updating profile picture-------------------
  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      builder: (context) {
        return ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.02,
            bottom: MediaQuery.of(context).size.height * 0.09,
          ),
          children: [
            const Text(
              'Pick Profile Picture',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: const ButtonStyle(
                    shape: MaterialStatePropertyAll(CircleBorder()),
                    backgroundColor: MaterialStatePropertyAll(Colors.white),
                    fixedSize: MaterialStatePropertyAll(Size(100, 100)),
                  ),
                  onPressed: () async {
                    // Pick an image From Gallery.
                    final ImagePicker picker = ImagePicker();
                    final XFile? image = await picker.pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 100,
                    );

                    if (image != null) {
                      setState(() {
                        _image = image.path;
                      });
                    }
                    //for hiding bottom sheet
                    Navigator.pop(context);
                  },
                  child: Image.asset('images/picture.png'),
                ),
                50.widthBox,
                ElevatedButton(
                    style: const ButtonStyle(
                      shape: MaterialStatePropertyAll(CircleBorder()),
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                      fixedSize: MaterialStatePropertyAll(Size(100, 100)),
                    ),
                    onPressed: () async {
                      // Pick an image From Camera.

                      final ImagePicker picker = ImagePicker();
                      final XFile? image =
                          await picker.pickImage(source: ImageSource.camera);

                      //for hiding bottom sheet
                      Navigator.pop(context);
                    },
                    child: Image.asset('images/camera.png'))
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ));
            },
            icon: const Icon(
              CupertinoIcons.back,
              size: 30,
            )),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
              _signOUT();
            },
            icon: const Icon(Icons.logout_rounded),
          )
        ],
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
            ),
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.07,
                ),
                Stack(children: [
                  _image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.height * 0.1),
                          child: Image.file(
                            File(_image!),
                            width: MediaQuery.of(context).size.height * 0.2,
                            height: MediaQuery.of(context).size.height * 0.2,
                            fit: BoxFit.cover,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.height * 0.1),
                          child: CachedNetworkImage(
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 0.4,
                            fit: BoxFit.fill,
                            filterQuality: FilterQuality.high,
                            imageUrl: widget.user.image ?? '',
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const CircleAvatar(child: Icon(Icons.person)),
                          ),
                        ),
                  Positioned(
                    top: 110,
                    left: 90,
                    child: MaterialButton(
                      onPressed: () {
                        _showBottomSheet();
                      },
                      minWidth: 15,
                      shape: const CircleBorder(
                        side: BorderSide(
                          width: 2,
                        ),
                      ),
                      color: Colors.white,
                      child: const Icon(Icons.edit),
                    ),
                  )
                ]),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Card(
                  margin: const EdgeInsets.all(10.0),
                  elevation: 10.0,
                  child: Text(
                    widget.user.email ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                TextFormField(
                  onSaved: (newValue) =>
                      FirebaseConstants.selfAccountInfo.name = newValue ?? '',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                  initialValue: widget.user.name,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      label: const Text('Name')),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  onSaved: (newValue) {
                    FirebaseConstants.selfAccountInfo.about = newValue ?? '';
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Required';
                    }
                  },
                  initialValue: widget.user.about,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.info_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      label: const Text('About')),
                ),
                const SizedBox(
                  height: 25,
                ),
                ClickButton(
                  textt: 'Update',
                  onTapp: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      FirebaseConstants.updateInformations().then(
                        (value) {
                          return Utils().showMessage('Updated');
                        },
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
